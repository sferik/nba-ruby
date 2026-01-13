require "json"
require_relative "client"
require_relative "response_parser"
require_relative "game_streak"
require_relative "utils"

module NBA
  # Provides methods to find player game streaks
  #
  # @api public
  module PlayerGameStreakFinder
    # Result set name for streak finder results
    # @return [String] the result set name
    RESULT_SET_NAME = "PlayerGameStreakFinderResults".freeze

    # Stat filter parameter mappings
    # @return [Hash] mapping of Ruby method parameters to API parameters
    STAT_FILTERS = {gt_pts: :GtPTS, gt_reb: :GtREB, gt_ast: :GtAST, gt_stl: :GtSTL, gt_blk: :GtBLK, gt_fg3m: :GtFG3M}.freeze

    # Finds player game streaks matching the specified criteria
    #
    # @api public
    # @example Find active 10+ point streaks
    #   NBA::PlayerGameStreakFinder.find(gt_pts: 10, active_streaks_only: true)
    # @param season [String, nil] the season to search (e.g., "2024-25")
    # @param player [Integer, Player, nil] filter by player ID or Player object
    # @param team [Integer, Team, nil] filter by team ID or Team object
    # @param active_streaks_only [Boolean, nil] only return active streaks
    # @param gt_pts [Integer, nil] minimum points per game
    # @param gt_reb [Integer, nil] minimum rebounds per game
    # @param gt_ast [Integer, nil] minimum assists per game
    # @param gt_stl [Integer, nil] minimum steals per game
    # @param gt_blk [Integer, nil] minimum blocks per game
    # @param gt_fg3m [Integer, nil] minimum 3-pointers made per game
    # @param client [Client] the API client to use
    # @return [Collection] collection of GameStreak objects
    def self.find(season: nil, player: nil, team: nil, active_streaks_only: nil, gt_pts: nil,
      gt_reb: nil, gt_ast: nil, gt_stl: nil, gt_blk: nil, gt_fg3m: nil, client: CLIENT)
      filters = {gt_pts: gt_pts, gt_reb: gt_reb, gt_ast: gt_ast, gt_stl: gt_stl, gt_blk: gt_blk, gt_fg3m: gt_fg3m}
      path = build_path(season, player, team, active_streaks_only, filters)
      ResponseParser.parse(client.get(path), result_set: RESULT_SET_NAME) { |data| build_streak(data) }
    end

    # Builds the API path with query parameters
    #
    # @api private
    # @return [String] the API endpoint path
    def self.build_path(season, player, team, active_only, filters)
      params = base_params(season, player, team, active_only)
      add_stat_filters(params, filters)
      "playergamestreakfinder?#{URI.encode_www_form(params)}"
    end
    private_class_method :build_path

    # Returns base parameters for the endpoint
    #
    # @api private
    # @return [Hash] the base parameters hash
    def self.base_params(season, player, team, active_only)
      params = {LeagueID: "00", MinGames: 1}
      params[:SeasonNullable] = season if season
      params[:PlayerIDNullable] = Utils.extract_id(player) if player
      params[:TeamIDNullable] = Utils.extract_id(team) if team
      params[:ActiveStreaksOnly] = "Y" if active_only
      params
    end
    private_class_method :base_params

    # Adds stat filter parameters
    #
    # @api private
    # @return [void]
    def self.add_stat_filters(params, filters)
      STAT_FILTERS.each { |key, param| params[param] = filters.fetch(key) if filters.fetch(key) }
    end
    private_class_method :add_stat_filters

    # Builds a GameStreak from API data
    #
    # @api private
    # @return [GameStreak] the game streak object
    def self.build_streak(data)
      GameStreak.new(**player_info(data), **streak_info(data))
    end
    private_class_method :build_streak

    # Extracts player information from data
    #
    # @api private
    # @return [Hash] the player information hash
    def self.player_info(data)
      {player_name: data["PLAYER_NAME_LAST_FIRST"], player_id: data["PLAYER_ID"]}
    end
    private_class_method :player_info

    # Extracts streak information from data
    #
    # @api private
    # @return [Hash] the streak information hash
    def self.streak_info(data)
      {game_streak: data["GAMESTREAK"], start_date: data["STARTDATE"],
       end_date: data["ENDDATE"], active_streak: data["ACTIVESTREAK"],
       num_seasons: data["NUMSEASONS"], last_season: data["LASTSEASON"],
       first_season: data["FIRSTSEASON"]}
    end
    private_class_method :streak_info
  end
end
