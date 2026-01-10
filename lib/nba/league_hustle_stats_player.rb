require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

module NBA
  # Provides methods to retrieve league-wide player hustle statistics
  module LeagueHustleStatsPlayer
    # Result set name for hustle stats
    # @return [String] the result set name
    HUSTLE_STATS_PLAYER = "HustleStatsPlayer".freeze

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

    # Retrieves league-wide player hustle statistics
    #
    # @api public
    # @example
    #   stats = NBA::LeagueHustleStatsPlayer.all(season: 2024)
    #   stats.each { |s| puts "#{s.player_name}: #{s.deflections} deflections" }
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player hustle stats
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
      "leaguehustlestatsplayer?LeagueID=00&Season=#{season_str}&SeasonType=#{season_type}&PerMode=#{per_mode}"
    end
    private_class_method :build_path

    # Parses the API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Collection] a collection of player hustle stats
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_player_stat(headers, row) }
      Collection.new(stats)
    end
    private_class_method :parse_response

    # Finds the result set
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @return [Hash, nil] the result set
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(HUSTLE_STATS_PLAYER) }
    end
    private_class_method :find_result_set

    # Builds a player stat from a row
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [LeagueHustleStatsPlayerStat] the player stat object
    def self.build_player_stat(headers, row)
      data = headers.zip(row).to_h
      LeagueHustleStatsPlayerStat.new(**player_stat_attributes(data))
    end
    private_class_method :build_player_stat

    # Extracts player stat attributes from row data
    #
    # @api private
    # @param data [Hash] the player stat row data
    # @return [Hash] the player stat attributes
    def self.player_stat_attributes(data)
      identity_attributes(data).merge(hustle_attributes(data), box_out_attributes(data))
    end
    private_class_method :player_stat_attributes

    # Extracts identity attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the identity attributes
    def self.identity_attributes(data)
      {player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       age: data.fetch("AGE", nil), g: data.fetch("G", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :identity_attributes

    # Extracts hustle attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the hustle attributes
    def self.hustle_attributes(data)
      {contested_shots: data.fetch("CONTESTED_SHOTS", nil),
       contested_shots_2pt: data.fetch("CONTESTED_SHOTS_2PT", nil),
       contested_shots_3pt: data.fetch("CONTESTED_SHOTS_3PT", nil),
       deflections: data.fetch("DEFLECTIONS", nil), charges_drawn: data.fetch("CHARGES_DRAWN", nil),
       screen_assists: data.fetch("SCREEN_ASSISTS", nil), screen_ast_pts: data.fetch("SCREEN_AST_PTS", nil),
       off_loose_balls_recovered: data.fetch("OFF_LOOSE_BALLS_RECOVERED", nil),
       def_loose_balls_recovered: data.fetch("DEF_LOOSE_BALLS_RECOVERED", nil),
       loose_balls_recovered: data.fetch("LOOSE_BALLS_RECOVERED", nil),
       pct_loose_balls_recovered_off: data.fetch("PCT_LOOSE_BALLS_RECOVERED_OFF", nil),
       pct_loose_balls_recovered_def: data.fetch("PCT_LOOSE_BALLS_RECOVERED_DEF", nil)}
    end
    private_class_method :hustle_attributes

    # Extracts box out attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the box out attributes
    def self.box_out_attributes(data)
      {off_boxouts: data.fetch("OFF_BOXOUTS", nil), def_boxouts: data.fetch("DEF_BOXOUTS", nil),
       box_out_player_team_rebs: data.fetch("BOX_OUT_PLAYER_TEAM_REBS", nil),
       box_out_player_rebs: data.fetch("BOX_OUT_PLAYER_REBS", nil), box_outs: data.fetch("BOX_OUTS", nil),
       pct_box_outs_off: data.fetch("PCT_BOX_OUTS_OFF", nil), pct_box_outs_def: data.fetch("PCT_BOX_OUTS_DEF", nil),
       pct_box_outs_team_reb: data.fetch("PCT_BOX_OUTS_TEAM_REB", nil),
       pct_box_outs_reb: data.fetch("PCT_BOX_OUTS_REB", nil)}
    end
    private_class_method :box_out_attributes
  end
end
