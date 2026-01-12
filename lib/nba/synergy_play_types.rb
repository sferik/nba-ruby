require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

require_relative "play_type_stat"

module NBA
  # Provides methods to retrieve Synergy play type data
  module SynergyPlayTypes
    # Result set name for play types
    # @return [String] the result set name
    SYNERGY_PLAY_TYPE = "SynergyPlayType".freeze

    # Season type constant for regular season
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Season type constant for playoffs
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Type grouping for offensive
    # @return [String] the type grouping
    OFFENSIVE = "offensive".freeze

    # Type grouping for defensive
    # @return [String] the type grouping
    DEFENSIVE = "defensive".freeze

    # Per mode constant for per game stats
    # @return [String] the per mode
    PER_GAME = "PerGame".freeze

    # Per mode constant for totals
    # @return [String] the per mode
    TOTALS = "Totals".freeze

    # Play type constant for isolation plays
    # @return [String] the play type
    ISOLATION = "Isolation".freeze
    # Play type constant for transition plays
    # @return [String] the play type
    TRANSITION = "Transition".freeze
    # Play type constant for pick and roll ball handler plays
    # @return [String] the play type
    PICK_AND_ROLL_BALL_HANDLER = "PRBallHandler".freeze
    # Play type constant for pick and roll roll man plays
    # @return [String] the play type
    PICK_AND_ROLL_ROLL_MAN = "PRRollman".freeze
    # Play type constant for post up plays
    # @return [String] the play type
    POST_UP = "Postup".freeze
    # Play type constant for spot up plays
    # @return [String] the play type
    SPOT_UP = "Spotup".freeze
    # Play type constant for handoff plays
    # @return [String] the play type
    HANDOFF = "Handoff".freeze
    # Play type constant for cut plays
    # @return [String] the play type
    CUT = "Cut".freeze
    # Play type constant for off screen plays
    # @return [String] the play type
    OFF_SCREEN = "OffScreen".freeze
    # Play type constant for putback plays
    # @return [String] the play type
    PUTBACKS = "OffRebound".freeze
    # Play type constant for miscellaneous plays
    # @return [String] the play type
    MISCELLANEOUS = "Misc".freeze

    # Retrieves synergy play type stats for players
    #
    # @api public
    # @example
    #   stats = NBA::SynergyPlayTypes.player_stats(play_type: "Isolation", type_grouping: "offensive")
    #   stats.each { |s| puts "#{s.player_name}: #{s.ppp} PPP" }
    # @param play_type [String] the play type
    # @param type_grouping [String] offensive or defensive
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of play type stats
    def self.player_stats(play_type:, type_grouping: OFFENSIVE, season: Utils.current_season,
      season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      path = build_path("player", play_type, type_grouping, season, season_type: season_type, per_mode: per_mode)
      response = client.get(path)
      parse_response(response, play_type, type_grouping)
    end

    # Retrieves synergy play type stats for teams
    #
    # @api public
    # @example
    #   stats = NBA::SynergyPlayTypes.team_stats(play_type: "Transition", type_grouping: "offensive")
    #   stats.each { |s| puts "#{s.team_abbreviation}: #{s.ppp} PPP" }
    # @param play_type [String] the play type
    # @param type_grouping [String] offensive or defensive
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of play type stats
    def self.team_stats(play_type:, type_grouping: OFFENSIVE, season: Utils.current_season,
      season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      path = build_path("team", play_type, type_grouping, season, season_type: season_type, per_mode: per_mode)
      response = client.get(path)
      parse_response(response, play_type, type_grouping)
    end

    # Builds the API path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(player_or_team, play_type, type_grouping, season, season_type:, per_mode:)
      season_str = Utils.format_season(season)
      "synergyplaytypes?LeagueID=00&SeasonYear=#{season_str}&SeasonType=#{season_type}" \
        "&PerMode=#{per_mode}&PlayerOrTeam=#{player_or_team.capitalize}" \
        "&PlayType=#{play_type}&TypeGrouping=#{type_grouping}"
    end
    private_class_method :build_path

    # Parses the API response into play type stat objects
    #
    # @api private
    # @return [Collection] collection of play type stats
    def self.parse_response(response, play_type, type_grouping)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_play_type_stat(headers, row, play_type, type_grouping) }
      Collection.new(stats)
    end
    private_class_method :parse_response

    # Finds the result set in the response
    #
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(SYNERGY_PLAY_TYPE) }
    end
    private_class_method :find_result_set

    # Builds a PlayTypeStat object from raw data
    #
    # @api private
    # @return [PlayTypeStat] the play type stat object
    def self.build_play_type_stat(headers, row, play_type, type_grouping)
      data = headers.zip(row).to_h
      PlayTypeStat.new(**play_type_attributes(data, play_type, type_grouping))
    end
    private_class_method :build_play_type_stat

    # Combines all play type attributes
    #
    # @api private
    # @return [Hash] the combined attributes
    def self.play_type_attributes(data, play_type, type_grouping)
      identity_attributes(data, play_type, type_grouping)
        .merge(possession_attributes(data))
        .merge(efficiency_attributes(data))
    end
    private_class_method :play_type_attributes

    # Extracts identity attributes from data
    #
    # @api private
    # @return [Hash] identity attributes
    def self.identity_attributes(data, play_type, type_grouping)
      {player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       play_type: play_type, type_grouping: type_grouping, gp: data.fetch("GP", nil)}
    end
    private_class_method :identity_attributes

    # Extracts possession attributes from data
    #
    # @api private
    # @return [Hash] possession attributes
    def self.possession_attributes(data)
      {poss: data.fetch("POSS", nil), poss_pct: data.fetch("POSS_PCT", nil),
       pts: data.fetch("PTS", nil), pts_pct: data.fetch("PTS_PCT", nil)}
    end
    private_class_method :possession_attributes

    # Extracts efficiency attributes from data
    #
    # @api private
    # @return [Hash] efficiency attributes
    def self.efficiency_attributes(data)
      {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
       efg_pct: data.fetch("EFG_PCT", nil), ft_poss_pct: data.fetch("FT_POSS_PCT", nil),
       tov_poss_pct: data.fetch("TOV_POSS_PCT", nil), sf_poss_pct: data.fetch("SF_POSS_PCT", nil),
       ppp: data.fetch("PPP", nil), percentile: data.fetch("PERCENTILE", nil)}
    end
    private_class_method :efficiency_attributes
  end
end
