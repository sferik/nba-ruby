require "json"
require_relative "client"
require_relative "collection"
require_relative "cume_stats_player_game"
require_relative "cume_stats_player_total"
require_relative "league"
require_relative "utils"

module NBA
  # Provides methods to retrieve cumulative player statistics
  module CumeStatsPlayer
    # Result set name for game-by-game stats
    # @return [String] the result set name
    GAME_BY_GAME_STATS = "GameByGameStats".freeze

    # Result set name for total player stats
    # @return [String] the result set name
    TOTAL_PLAYER_STATS = "TotalPlayerStats".freeze

    # Retrieves cumulative player statistics for specific games
    #
    # @api public
    # @example
    #   stats = NBA::CumeStatsPlayer.find(
    #     player: 201939,
    #     game_ids: ["0022400001", "0022400002"],
    #     season: "2024-25",
    #     season_type: "Regular Season"
    #   )
    #   stats[:game_by_game].each { |g| puts "#{g.game_date}: #{g.pts} PTS" }
    #   puts "Total: #{stats[:total].pts} PTS"
    # @param player [Integer, Player] the player ID or Player object
    # @param game_ids [Array<String>, String] game IDs as array or pipe-separated string
    # @param season [String] the season (e.g., "2024-25")
    # @param season_type [String] the season type (default "Regular Season")
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Hash, nil] hash with :game_by_game and :total keys, or nil
    def self.find(player:, game_ids:, season:, season_type: "Regular Season", league: League::NBA, client: CLIENT)
      player_id = Utils.extract_id(player)
      league_id = Utils.extract_league_id(league)
      game_ids_param = format_game_ids(game_ids)

      path = "cumestatsplayer?PlayerID=#{player_id}&GameIDs=#{game_ids_param}" \
             "&LeagueID=#{league_id}&Season=#{season}&SeasonType=#{season_type}"
      response = client.get(path)
      parse_response(response)
    end

    # Parses the API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Hash, nil] hash with :game_by_game and :total keys, or nil
    def self.parse_response(response)
      return unless response

      data = JSON.parse(response)
      game_by_game = parse_game_by_game(data)
      total = parse_total(data)

      return unless game_by_game && total

      {game_by_game: game_by_game, total: total}
    end
    private_class_method :parse_response

    # Parses the game-by-game stats result set
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @return [Collection, nil] collection of game stats, or nil
    def self.parse_game_by_game(data)
      result_set = find_result_set(data, GAME_BY_GAME_STATS)
      return unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return unless headers && rows

      games = rows.map { |row| build_game(headers, row) }
      Collection.new(games)
    end
    private_class_method :parse_game_by_game

    # Parses the total player stats result set
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @return [CumeStatsPlayerTotal, nil] total stats, or nil
    def self.parse_total(data)
      result_set = find_result_set(data, TOTAL_PLAYER_STATS)
      return unless result_set

      headers = result_set["headers"]
      row = result_set.dig("rowSet", 0)
      return unless headers && row

      build_total(headers, row)
    end
    private_class_method :parse_total

    # Finds a result set by name
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @param name [String] the result set name
    # @return [Hash, nil] the result set
    def self.find_result_set(data, name)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(name) }
    end
    private_class_method :find_result_set

    # Builds a game stat object from a row
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [CumeStatsPlayerGame] the game stat object
    def self.build_game(headers, row)
      data = headers.zip(row).to_h
      CumeStatsPlayerGame.new(**GameAttributes.extract(data))
    end
    private_class_method :build_game

    # Builds a total stat object from a row
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [CumeStatsPlayerTotal] the total stat object
    def self.build_total(headers, row)
      data = headers.zip(row).to_h
      CumeStatsPlayerTotal.new(**TotalAttributes.extract(data))
    end
    private_class_method :build_total

    # Formats game IDs as a pipe-separated string
    #
    # @api private
    # @param game_ids [Array<String>, String] game IDs as array or string
    # @return [String] pipe-separated game IDs
    def self.format_game_ids(game_ids)
      game_ids.instance_of?(Array) ? game_ids.join("|") : game_ids
    end
    private_class_method :format_game_ids

    # Extracts game attributes from row data
    # @api private
    module GameAttributes
      # Extracts all game attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] extracted attributes
      def self.extract(data)
        identity(data).merge(stats(data))
      end

      # Extracts identity attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] identity attributes
      def self.identity(data)
        {
          game_id: data["GAME_ID"],
          matchup: data["MATCHUP"],
          game_date: data["GAME_DATE"],
          vs_team_id: data["VS_TEAM_ID"],
          vs_team_city: data["VS_TEAM_CITY"],
          vs_team_name: data["VS_TEAM_NAME"]
        }
      end

      # Extracts stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] stat attributes
      def self.stats(data)
        time(data).merge(shooting(data)).merge(rebounds(data)).merge(other(data))
      end

      # Extracts time attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] time attributes
      def self.time(data)
        {min: data["MIN"], sec: data["SEC"]}
      end

      # Extracts shooting attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] shooting attributes
      def self.shooting(data)
        {
          fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"],
          fg3m: data["FG3M"], fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"],
          ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]
        }
      end

      # Extracts rebound attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] rebound attributes
      def self.rebounds(data)
        {oreb: data["OREB"], dreb: data["DREB"], reb: data["REB"]}
      end

      # Extracts other stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] other stat attributes
      def self.other(data)
        {
          ast: data["AST"], pf: data["PF"], stl: data["STL"],
          tov: data["TOV"], blk: data["BLK"], pts: data["PTS"]
        }
      end
    end

    # Extracts total attributes from row data
    # @api private
    module TotalAttributes
      # Extracts all total attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] extracted attributes
      def self.extract(data)
        identity(data).merge(totals(data)).merge(averages(data)).merge(maximums(data))
      end

      # Extracts identity attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] identity attributes
      def self.identity(data)
        {
          player_id: data["PLAYER_ID"], player_name: data["PLAYER_NAME"],
          jersey_num: data["JERSEY_NUM"], season: data["SEASON"],
          gp: data["GP"], gs: data["GS"],
          actual_minutes: data["ACTUAL_MINUTES"], actual_seconds: data["ACTUAL_SECONDS"]
        }
      end

      # Extracts total stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] total stat attributes
      def self.totals(data)
        shooting(data).merge(rebounds_and_other(data))
      end

      # Extracts shooting attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] shooting attributes
      def self.shooting(data)
        {
          fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"],
          fg3m: data["FG3M"], fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"],
          ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]
        }
      end

      # Extracts rebound and other stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] rebound and other stat attributes
      def self.rebounds_and_other(data)
        {
          oreb: data["OREB"], dreb: data["DREB"], tot_reb: data["TOT_REB"],
          ast: data["AST"], pf: data["PF"], stl: data["STL"],
          tov: data["TOV"], blk: data["BLK"], pts: data["PTS"]
        }
      end

      # Extracts average stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] average stat attributes
      def self.averages(data)
        avg_time(data).merge(avg_shooting(data)).merge(avg_other(data))
      end

      # Extracts average time attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] average time attributes
      def self.avg_time(data)
        {avg_min: data["AVG_MIN"], avg_sec: data["AVG_SEC"]}
      end

      # Extracts average shooting attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] average shooting attributes
      def self.avg_shooting(data)
        {
          avg_fgm: data["AVG_FGM"], avg_fga: data["AVG_FGA"],
          avg_fg3m: data["AVG_FG3M"], avg_fg3a: data["AVG_FG3A"],
          avg_ftm: data["AVG_FTM"], avg_fta: data["AVG_FTA"],
          avg_oreb: data["AVG_OREB"], avg_dreb: data["AVG_DREB"]
        }
      end

      # Extracts average other stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] average other stat attributes
      def self.avg_other(data)
        {
          avg_tot_reb: data["AVG_TOT_REB"], avg_ast: data["AVG_AST"],
          avg_pf: data["AVG_PF"], avg_stl: data["AVG_STL"],
          avg_tov: data["AVG_TOV"], avg_blk: data["AVG_BLK"],
          avg_pts: data["AVG_PTS"]
        }
      end

      # Extracts maximum stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] maximum stat attributes
      def self.maximums(data)
        max_shooting(data).merge(max_other(data))
      end

      # Extracts maximum shooting attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] maximum shooting attributes
      def self.max_shooting(data)
        {
          max_min: data["MAX_MIN"], max_fgm: data["MAX_FGM"],
          max_fga: data["MAX_FGA"], max_fg3m: data["MAX_FG3M"],
          max_fg3a: data["MAX_FG3A"], max_ftm: data["MAX_FTM"],
          max_fta: data["MAX_FTA"], max_oreb: data["MAX_OREB"],
          max_dreb: data["MAX_DREB"], max_reb: data["MAX_REB"]
        }
      end

      # Extracts maximum other stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] maximum other stat attributes
      def self.max_other(data)
        {
          max_ast: data["MAX_AST"], max_pf: data["MAX_PF"],
          max_stl: data["MAX_STL"], max_tov: data["MAX_TOV"],
          max_blk: data["MAX_BLK"], max_pts: data["MAX_PTS"]
        }
      end
    end
  end
end
