require "json"
require_relative "client"
require_relative "collection"
require_relative "matchup_rollup"
require_relative "league"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Provides methods to retrieve NBA matchup rollup statistics
  module MatchupsRollup
    # Result set name for matchups rollup
    # @return [String] the result set name
    RESULT_SET = "MatchupsRollup".freeze

    # Retrieves matchup rollup statistics
    #
    # @api public
    # @example
    #   matchups = NBA::MatchupsRollup.all(season: 2023)
    #   matchups.each { |m| puts "#{m.def_player_name}: #{m.matchup_fg_pct}" }
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs, etc.)
    # @param per_mode [String] the per mode (Totals, PerGame, etc.)
    # @param def_player [Integer, Player, nil] the defensive player ID or Player object
    # @param def_team [Integer, Team, nil] the defensive team ID or Team object
    # @param off_player [Integer, Player, nil] the offensive player ID or Player object
    # @param off_team [Integer, Team, nil] the offensive team ID or Team object
    # @param league [String, League] the league ID or League object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of matchup rollups
    def self.all(season: Utils.current_season, season_type: "Regular Season",
      per_mode: "Totals", def_player: nil, def_team: nil, off_player: nil,
      off_team: nil, league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      opts = {season: season, season_type: season_type, per_mode: per_mode,
              def_player_id: Utils.extract_id(def_player), def_team_id: Utils.extract_id(def_team),
              off_player_id: Utils.extract_id(off_player), off_team_id: Utils.extract_id(off_team),
              league_id: league_id}
      ResponseParser.parse(client.get(build_path(opts)), result_set: RESULT_SET) do |data|
        build_matchup(data)
      end
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(opts)
      "matchupsrollup?DefPlayerID=#{opts[:def_player_id]}&DefTeamID=#{opts[:def_team_id]}" \
        "&LeagueID=#{opts[:league_id]}&OffPlayerID=#{opts[:off_player_id]}" \
        "&OffTeamID=#{opts[:off_team_id]}&PerMode=#{opts[:per_mode]}" \
        "&Season=#{Utils.format_season(opts[:season])}&SeasonType=#{opts[:season_type]}"
    end
    private_class_method :build_path

    # Builds a MatchupRollup object from raw data
    # @api private
    # @param data [Hash] the row data
    # @return [MatchupRollup] the matchup object
    def self.build_matchup(data)
      MatchupRollup.new(**matchup_attributes(data))
    end
    private_class_method :build_matchup

    # Extracts matchup attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] matchup attributes
    def self.matchup_attributes(data)
      {season_id: data["SEASON_ID"], position: data["POSITION"],
       percent_of_time: data["PERCENT_OF_TIME"],
       def_player_id: data["DEF_PLAYER_ID"],
       def_player_name: data["DEF_PLAYER_NAME"], gp: data["GP"],
       matchup_min: data["MATCHUP_MIN"],
       partial_poss: data["PARTIAL_POSS"], player_pts: data["PLAYER_PTS"],
       team_pts: data["TEAM_PTS"], matchup_fg_pct: data["MATCHUP_FG_PCT"],
       matchup_fg3_pct: data["MATCHUP_FG3_PCT"]}
    end
    private_class_method :matchup_attributes
  end
end
