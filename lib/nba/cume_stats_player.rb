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

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
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

      headers = result_set.fetch("headers", nil)
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
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(name) }
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
          game_id: data.fetch("GAME_ID", nil),
          matchup: data.fetch("MATCHUP", nil),
          game_date: data.fetch("GAME_DATE", nil),
          vs_team_id: data.fetch("VS_TEAM_ID", nil),
          vs_team_city: data.fetch("VS_TEAM_CITY", nil),
          vs_team_name: data.fetch("VS_TEAM_NAME", nil)
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
        {min: data.fetch("MIN", nil), sec: data.fetch("SEC", nil)}
      end

      # Extracts shooting attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] shooting attributes
      def self.shooting(data)
        {
          fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
          fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
          ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)
        }
      end

      # Extracts rebound attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] rebound attributes
      def self.rebounds(data)
        {oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), reb: data.fetch("REB", nil)}
      end

      # Extracts other stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] other stat attributes
      def self.other(data)
        {
          ast: data.fetch("AST", nil), pf: data.fetch("PF", nil), stl: data.fetch("STL", nil),
          tov: data.fetch("TOV", nil), blk: data.fetch("BLK", nil), pts: data.fetch("PTS", nil)
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
          player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
          jersey_num: data.fetch("JERSEY_NUM", nil), season: data.fetch("SEASON", nil),
          gp: data.fetch("GP", nil), gs: data.fetch("GS", nil),
          actual_minutes: data.fetch("ACTUAL_MINUTES", nil), actual_seconds: data.fetch("ACTUAL_SECONDS", nil)
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
          fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
          fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
          ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)
        }
      end

      # Extracts rebound and other stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] rebound and other stat attributes
      def self.rebounds_and_other(data)
        {
          oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), tot_reb: data.fetch("TOT_REB", nil),
          ast: data.fetch("AST", nil), pf: data.fetch("PF", nil), stl: data.fetch("STL", nil),
          tov: data.fetch("TOV", nil), blk: data.fetch("BLK", nil), pts: data.fetch("PTS", nil)
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
        {avg_min: data.fetch("AVG_MIN", nil), avg_sec: data.fetch("AVG_SEC", nil)}
      end

      # Extracts average shooting attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] average shooting attributes
      def self.avg_shooting(data)
        {
          avg_fgm: data.fetch("AVG_FGM", nil), avg_fga: data.fetch("AVG_FGA", nil),
          avg_fg3m: data.fetch("AVG_FG3M", nil), avg_fg3a: data.fetch("AVG_FG3A", nil),
          avg_ftm: data.fetch("AVG_FTM", nil), avg_fta: data.fetch("AVG_FTA", nil),
          avg_oreb: data.fetch("AVG_OREB", nil), avg_dreb: data.fetch("AVG_DREB", nil)
        }
      end

      # Extracts average other stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] average other stat attributes
      def self.avg_other(data)
        {
          avg_tot_reb: data.fetch("AVG_TOT_REB", nil), avg_ast: data.fetch("AVG_AST", nil),
          avg_pf: data.fetch("AVG_PF", nil), avg_stl: data.fetch("AVG_STL", nil),
          avg_tov: data.fetch("AVG_TOV", nil), avg_blk: data.fetch("AVG_BLK", nil),
          avg_pts: data.fetch("AVG_PTS", nil)
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
          max_min: data.fetch("MAX_MIN", nil), max_fgm: data.fetch("MAX_FGM", nil),
          max_fga: data.fetch("MAX_FGA", nil), max_fg3m: data.fetch("MAX_FG3M", nil),
          max_fg3a: data.fetch("MAX_FG3A", nil), max_ftm: data.fetch("MAX_FTM", nil),
          max_fta: data.fetch("MAX_FTA", nil), max_oreb: data.fetch("MAX_OREB", nil),
          max_dreb: data.fetch("MAX_DREB", nil), max_reb: data.fetch("MAX_REB", nil)
        }
      end

      # Extracts maximum other stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] maximum other stat attributes
      def self.max_other(data)
        {
          max_ast: data.fetch("MAX_AST", nil), max_pf: data.fetch("MAX_PF", nil),
          max_stl: data.fetch("MAX_STL", nil), max_tov: data.fetch("MAX_TOV", nil),
          max_blk: data.fetch("MAX_BLK", nil), max_pts: data.fetch("MAX_PTS", nil)
        }
      end
    end
  end
end
