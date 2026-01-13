require "json"
require_relative "client"
require_relative "collection"
require_relative "draft_board_pick"

module NBA
  # Provides methods to retrieve draft board data
  module DraftBoard
    # Result set name
    # @return [String] the result set name
    RESULTS = "DraftBoard".freeze

    # Retrieves draft board picks for a season
    #
    # @api public
    # @example
    #   picks = NBA::DraftBoard.all(season: 2023)
    #   picks.each { |p| puts "#{p.player_name}: Pick #{p.overall_pick}" }
    # @param season [Integer] the draft season year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of draft board picks
    def self.all(season:, league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      path = build_path(season, league_id)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(season, league_id)
      "draftboard?LeagueID=#{league_id}&SeasonYear=#{season}"
    end
    private_class_method :build_path

    # Parses the API response into pick objects
    # @api private
    # @return [Collection] collection of picks
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      picks = rows.map { |row| build_pick(headers, row) }
      Collection.new(picks)
    end
    private_class_method :parse_response

    # Finds the result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(RESULTS) }
    end
    private_class_method :find_result_set

    # Builds a DraftBoardPick object from raw data
    # @api private
    # @return [DraftBoardPick] the pick object
    def self.build_pick(headers, row)
      data = headers.zip(row).to_h
      DraftBoardPick.new(**PickAttributes.extract(data))
    end
    private_class_method :build_pick

    # Extracts pick attributes from data
    # @api private
    module PickAttributes
      # Extracts all pick attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] extracted attributes
      def self.extract(data)
        player(data).merge(draft_info(data)).merge(team(data)).merge(physical(data))
      end

      # Extracts player attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] player attributes
      def self.player(data)
        {person_id: data["PERSON_ID"], player_name: data["PLAYER_NAME"]}
      end

      # Extracts draft info attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] draft info attributes
      def self.draft_info(data)
        {season: data["SEASON"], round_number: data["ROUND_NUMBER"],
         round_pick: data["ROUND_PICK"], overall_pick: data["OVERALL_PICK"]}
      end

      # Extracts team attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] team attributes
      def self.team(data)
        {team_id: data["TEAM_ID"], team_city: data["TEAM_CITY"],
         team_name: data["TEAM_NAME"], team_abbreviation: data["TEAM_ABBREVIATION"],
         organization: data["ORGANIZATION"], organization_type: data["ORGANIZATION_TYPE"]}
      end

      # Extracts physical attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] physical attributes
      def self.physical(data)
        {height: data["HEIGHT"], weight: data["WEIGHT"],
         position: data["POSITION"], jersey_number: data["JERSEY_NUMBER"],
         birthdate: data["BIRTHDATE"], age: data["AGE"]}
      end
    end
  end
end
