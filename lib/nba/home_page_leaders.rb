require "json"
require_relative "client"
require_relative "collection"
require_relative "home_page_leader"
require_relative "league"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Provides methods to retrieve NBA home page leaders
  module HomePageLeaders
    # Result set name for home page leaders
    # @return [String] the result set name
    RESULT_SET = "HomePageLeaders".freeze

    # Retrieves home page leaders for a season
    #
    # @api public
    # @example
    #   leaders = NBA::HomePageLeaders.all(season: 2023, stat_category: "PTS")
    #   leaders.each { |l| puts "#{l.rank}. #{l.player}: #{l.pts}" }
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param stat_category [String] the stat category (PTS, AST, REB, etc.)
    # @param game_scope [String] the game scope (Season, Yesterday, etc.)
    # @param player_or_team [String] player or team (Player, Team)
    # @param player_scope [String] the player scope (All Players, Rookies)
    # @param league [String, League] the league ID or League object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of leaders
    def self.all(season: Utils.current_season, season_type: "Regular Season", stat_category: "PTS",
      game_scope: "Season", player_or_team: "Player", player_scope: "All Players",
      league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      opts = {season: season, season_type: season_type, stat_category: stat_category,
              game_scope: game_scope, player_or_team: player_or_team, player_scope: player_scope,
              league_id: league_id}
      ResponseParser.parse(client.get(build_path(opts)), result_set: RESULT_SET) { |data| build_leader(data) }
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(opts)
      "homepageleaders?GameScope=#{opts[:game_scope]}&LeagueID=#{opts[:league_id]}" \
        "&PlayerOrTeam=#{opts[:player_or_team]}&PlayerScope=#{opts[:player_scope]}" \
        "&Season=#{Utils.format_season(opts[:season])}&SeasonType=#{opts[:season_type]}" \
        "&StatCategory=#{opts[:stat_category]}"
    end
    private_class_method :build_path

    # Builds a HomePageLeader object from raw data
    # @api private
    # @param data [Hash] the row data
    # @return [HomePageLeader] the leader object
    def self.build_leader(data)
      HomePageLeader.new(**leader_attributes(data))
    end
    private_class_method :build_leader

    # Extracts leader attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] leader attributes
    def self.leader_attributes(data)
      {rank: data["RANK"], player_id: data["PLAYER_ID"],
       player: data["PLAYER"], team_id: data["TEAM_ID"],
       team_abbreviation: data["TEAM_ABBREVIATION"],
       pts: data["PTS"], fg_pct: data["FG_PCT"],
       fg3_pct: data["FG3_PCT"], ft_pct: data["FT_PCT"],
       eff: data["EFF"], ast: data["AST"], reb: data["REB"]}
    end
    private_class_method :leader_attributes
  end
end
