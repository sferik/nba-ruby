require "json"
require_relative "client"
require_relative "collection"
require_relative "assist_tracker_entry"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Provides methods to retrieve NBA assist tracker data (who passes to who)
  module AssistTracker
    # Result set name for assist tracker
    # @return [String] the result set name
    RESULT_SET = "AssistTracker".freeze

    # Retrieves assist tracker data for a season
    #
    # @api public
    # @example
    #   entries = NBA::AssistTracker.all(season: 2023)
    #   entries.each { |e| puts "#{e.player_name} -> #{e.pass_to}: #{e.ast} assists" }
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs, etc.)
    # @param per_mode [String] the per mode (Totals, PerGame)
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of assist tracker entries
    def self.all(season: Utils.current_season, season_type: "Regular Season", per_mode: "Totals",
      league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      path = build_path(season, season_type, per_mode, league_id)
      ResponseParser.parse(client.get(path), result_set: RESULT_SET) { |data| build_entry(data) }
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(season, season_type, per_mode, league_id)
      "assisttracker?LeagueID=#{league_id}&PerMode=#{per_mode}" \
        "&Season=#{Utils.format_season(season)}&SeasonType=#{season_type}"
    end
    private_class_method :build_path

    # Builds an AssistTrackerEntry object from raw data
    # @api private
    # @param data [Hash] the row data
    # @return [AssistTrackerEntry] the entry object
    def self.build_entry(data)
      AssistTrackerEntry.new(**player_attrs(data), **pass_attrs(data), **shooting_attrs(data))
    end
    private_class_method :build_entry

    # Extracts player attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] player attributes
    def self.player_attrs(data)
      {player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil)}
    end
    private_class_method :player_attrs

    # Extracts pass attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] pass attributes
    def self.pass_attrs(data)
      {pass_to: data.fetch("PASS_TO", nil), pass_to_player_id: data.fetch("PASS_TO_PLAYER_ID", nil),
       frequency: data.fetch("FREQUENCY", nil), pass: data.fetch("PASS", nil), ast: data.fetch("AST", nil)}
    end
    private_class_method :pass_attrs

    # Extracts shooting attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] shooting attributes
    def self.shooting_attrs(data)
      fg_attrs(data).merge(fg2_attrs(data)).merge(fg3_attrs(data))
    end
    private_class_method :shooting_attrs

    # Extracts field goal attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] field goal attributes
    def self.fg_attrs(data)
      {fg_m: data.fetch("FGM", nil), fg_a: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil)}
    end
    private_class_method :fg_attrs

    # Extracts 2-point field goal attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] 2-point field goal attributes
    def self.fg2_attrs(data)
      {fg2m: data.fetch("FG2M", nil), fg2a: data.fetch("FG2A", nil), fg2_pct: data.fetch("FG2_PCT", nil)}
    end
    private_class_method :fg2_attrs

    # Extracts 3-point field goal attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] 3-point field goal attributes
    def self.fg3_attrs(data)
      {fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil)}
    end
    private_class_method :fg3_attrs
  end
end
