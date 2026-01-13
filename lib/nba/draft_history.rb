require "json"
require_relative "client"
require_relative "collection"

require_relative "draft_pick"

module NBA
  # Provides methods to retrieve draft history
  module DraftHistory
    # Result set name for draft history
    # @return [String] the result set name
    DRAFT_HISTORY = "DraftHistory".freeze

    # Retrieves all draft picks for a season
    #
    # @api public
    # @example
    #   picks = NBA::DraftHistory.all(season: 2023)
    #   picks.each { |p| puts "#{p.overall_pick}. #{p.player_name}" }
    # @param season [Integer] the draft year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of draft picks
    def self.all(season: nil, league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      path = build_path(season, league_id)
      response = client.get(path)
      parse_response(response)
    end

    # Retrieves draft picks for a specific team
    #
    # @api public
    # @example
    #   picks = NBA::DraftHistory.by_team(team: NBA::Team::GSW, season: 2023)
    #   picks.each { |p| puts "#{p.round_number}.#{p.round_pick}: #{p.player_name}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the draft year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of draft picks
    def self.by_team(team:, season: nil, league: League::NBA, client: CLIENT)
      team_id = extract_team_id(team)
      all_picks = all(season: season, league: league, client: client)
      filtered = all_picks.select { |pick| pick.team_id.eql?(team_id) }
      Collection.new(filtered)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(season, league_id)
      season_param = season && "&Season=#{season}"
      "drafthistory?LeagueID=#{league_id}#{season_param}"
    end
    private_class_method :build_path

    # Parses the API response into draft pick objects
    # @api private
    # @return [Collection] collection of draft picks
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      picks = rows.map { |row| build_draft_pick(headers, row) }
      Collection.new(picks)
    end
    private_class_method :parse_response

    # Finds the draft history result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(DRAFT_HISTORY) }
    end
    private_class_method :find_result_set

    # Builds a DraftPick object from raw data
    # @api private
    # @return [DraftPick] the draft pick object
    def self.build_draft_pick(headers, row)
      data = headers.zip(row).to_h
      DraftPick.new(**draft_pick_attributes(data))
    end
    private_class_method :build_draft_pick

    # Combines all draft pick attributes
    # @api private
    # @return [Hash] the combined attributes
    def self.draft_pick_attributes(data)
      pick_info_attributes(data).merge(team_attributes(data), player_attributes(data))
    end
    private_class_method :draft_pick_attributes

    # Extracts pick info attributes from data
    # @api private
    # @return [Hash] pick info attributes
    def self.pick_info_attributes(data)
      {player_id: data["PERSON_ID"], season: data["SEASON"],
       round_number: data["ROUND_NUMBER"], round_pick: data["ROUND_PICK"],
       overall_pick: data["OVERALL_PICK"], draft_type: data["DRAFT_TYPE"]}
    end
    private_class_method :pick_info_attributes

    # Extracts team attributes from data
    # @api private
    # @return [Hash] team attributes
    def self.team_attributes(data)
      {team_id: data["TEAM_ID"], team_city: data["TEAM_CITY"],
       team_name: data["TEAM_NAME"], team_abbreviation: data["TEAM_ABBREVIATION"]}
    end
    private_class_method :team_attributes

    # Extracts player attributes from data
    # @api private
    # @return [Hash] player attributes
    def self.player_attributes(data)
      {player_name: data["PLAYER_NAME"], position: data["POSITION"],
       height: data["HEIGHT"], weight: data["WEIGHT"],
       college: data["ORGANIZATION"], country: data["PLAYER_PROFILE_FLAG"]}
    end
    private_class_method :player_attributes

    # Extracts team ID from team object or integer
    # @api private
    # @return [Integer] the team ID
    def self.extract_team_id(team)
      team.instance_of?(Team) ? team.id : team
    end
    private_class_method :extract_team_id
  end
end
