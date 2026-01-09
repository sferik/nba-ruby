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
      league_id = extract_league_id(league)
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

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      picks = rows.map { |row| build_pick(headers, row) }
      Collection.new(picks)
    end
    private_class_method :parse_response

    # Finds the result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(RESULTS) }
    end
    private_class_method :find_result_set

    # Builds a DraftBoardPick object from raw data
    # @api private
    # @return [DraftBoardPick] the pick object
    def self.build_pick(headers, row)
      data = headers.zip(row).to_h
      DraftBoardPick.new(**pick_attributes(data))
    end
    private_class_method :build_pick

    # Extracts pick attributes from data
    # @api private
    # @return [Hash] the pick attributes
    def self.pick_attributes(data)
      {
        person_id: data.fetch("PERSON_ID", nil),
        player_name: data.fetch("PLAYER_NAME", nil),
        season: data.fetch("SEASON", nil),
        round_number: data.fetch("ROUND_NUMBER", nil),
        round_pick: data.fetch("ROUND_PICK", nil),
        overall_pick: data.fetch("OVERALL_PICK", nil),
        team_id: data.fetch("TEAM_ID", nil),
        team_city: data.fetch("TEAM_CITY", nil),
        team_name: data.fetch("TEAM_NAME", nil),
        team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
        organization: data.fetch("ORGANIZATION", nil),
        organization_type: data.fetch("ORGANIZATION_TYPE", nil),
        height: data.fetch("HEIGHT", nil),
        weight: data.fetch("WEIGHT", nil),
        position: data.fetch("POSITION", nil),
        jersey_number: data.fetch("JERSEY_NUMBER", nil),
        birthdate: data.fetch("BIRTHDATE", nil),
        age: data.fetch("AGE", nil)
      }
    end
    private_class_method :pick_attributes

    # Extracts the league ID from a League object or string
    #
    # @api private
    # @param league [String, League] the league ID or League object
    # @return [String] the league ID string
    def self.extract_league_id(league)
      case league
      when League then league.id
      else league
      end
    end
    private_class_method :extract_league_id
  end
end
