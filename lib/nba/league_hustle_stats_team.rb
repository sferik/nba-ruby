require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

module NBA
  # Provides methods to retrieve league-wide team hustle statistics
  module LeagueHustleStatsTeam
    # Result set name for hustle stats
    # @return [String] the result set name
    HUSTLE_STATS_TEAM = "HustleStatsTeam".freeze

    # Season type constant for regular season
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Season type constant for playoffs
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Per mode constant for per game stats
    # @return [String] the per mode
    PER_GAME = "PerGame".freeze

    # Per mode constant for totals
    # @return [String] the per mode
    TOTALS = "Totals".freeze

    # Retrieves league-wide team hustle statistics
    #
    # @api public
    # @example
    #   stats = NBA::LeagueHustleStatsTeam.all(season: 2024)
    #   stats.each { |s| puts "#{s.team_name}: #{s.deflections} deflections" }
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team hustle stats
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      path = build_path(season, season_type, per_mode)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API path
    #
    # @api private
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @return [String] the API path
    def self.build_path(season, season_type, per_mode)
      season_str = Utils.format_season(season)
      "leaguehustlestatsteam?LeagueID=00&Season=#{season_str}&SeasonType=#{season_type}&PerMode=#{per_mode}"
    end
    private_class_method :build_path

    # Parses the API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Collection] a collection of team hustle stats
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_team_stat(headers, row) }
      Collection.new(stats)
    end
    private_class_method :parse_response

    # Finds the result set
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @return [Hash, nil] the result set
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(HUSTLE_STATS_TEAM) }
    end
    private_class_method :find_result_set

    # Builds a team stat from a row
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [LeagueHustleStatsTeamStat] the team stat object
    def self.build_team_stat(headers, row)
      data = headers.zip(row).to_h
      LeagueHustleStatsTeamStat.new(**team_stat_attributes(data))
    end
    private_class_method :build_team_stat

    # Extracts team stat attributes from row data
    #
    # @api private
    # @param data [Hash] the team stat row data
    # @return [Hash] the team stat attributes
    def self.team_stat_attributes(data)
      identity_attributes(data).merge(hustle_attributes(data), box_out_attributes(data))
    end
    private_class_method :team_stat_attributes

    # Extracts identity attributes
    #
    # @api private
    # @param data [Hash] the team stat data
    # @return [Hash] the identity attributes
    def self.identity_attributes(data)
      {team_id: data["TEAM_ID"], team_name: data["TEAM_NAME"],
       min: data["MIN"]}
    end
    private_class_method :identity_attributes

    # Extracts hustle attributes
    #
    # @api private
    # @param data [Hash] the team stat data
    # @return [Hash] the hustle attributes
    def self.hustle_attributes(data)
      {contested_shots: data["CONTESTED_SHOTS"],
       contested_shots_2pt: data["CONTESTED_SHOTS_2PT"],
       contested_shots_3pt: data["CONTESTED_SHOTS_3PT"],
       deflections: data["DEFLECTIONS"], charges_drawn: data["CHARGES_DRAWN"],
       screen_assists: data["SCREEN_ASSISTS"], screen_ast_pts: data["SCREEN_AST_PTS"],
       off_loose_balls_recovered: data["OFF_LOOSE_BALLS_RECOVERED"],
       def_loose_balls_recovered: data["DEF_LOOSE_BALLS_RECOVERED"],
       loose_balls_recovered: data["LOOSE_BALLS_RECOVERED"],
       pct_loose_balls_recovered_off: data["PCT_LOOSE_BALLS_RECOVERED_OFF"],
       pct_loose_balls_recovered_def: data["PCT_LOOSE_BALLS_RECOVERED_DEF"]}
    end
    private_class_method :hustle_attributes

    # Extracts box out attributes
    #
    # @api private
    # @param data [Hash] the team stat data
    # @return [Hash] the box out attributes
    def self.box_out_attributes(data)
      {off_boxouts: data["OFF_BOXOUTS"], def_boxouts: data["DEF_BOXOUTS"],
       box_outs: data["BOX_OUTS"],
       pct_box_outs_off: data["PCT_BOX_OUTS_OFF"], pct_box_outs_def: data["PCT_BOX_OUTS_DEF"]}
    end
    private_class_method :box_out_attributes
  end
end
