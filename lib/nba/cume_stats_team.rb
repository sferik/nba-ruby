require "json"
require_relative "client"
require_relative "collection"
require_relative "cume_stats_team_player"
require_relative "cume_stats_team_total"
require_relative "utils"

module NBA
  # Provides methods to retrieve cumulative team statistics
  module CumeStatsTeam
    # Result set name for game by game stats
    # @return [String] the result set name
    GAME_BY_GAME_STATS = "GameByGameStats".freeze

    # Result set name for total team stats
    # @return [String] the result set name
    TOTAL_TEAM_STATS = "TotalTeamStats".freeze

    # Retrieves cumulative team statistics for specific games
    #
    # @api public
    # @example
    #   result = NBA::CumeStatsTeam.find(team: 1610612744, game_ids: ["0022400001", "0022400002"], season: 2024)
    #   result[:game_by_game].each { |p| puts "#{p.player_name}: #{p.pts} pts" }
    #   result[:total].pts #=> 220
    # @param team [Integer, Team] the team ID or Team object
    # @param game_ids [Array<String>, String] game IDs (array or pipe-separated string)
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param league [String, League] the league ID or League object
    # @param client [Client] the API client to use
    # @return [Hash, nil] hash with :game_by_game (Collection) and :total (CumeStatsTeamTotal) keys, or nil
    def self.find(team:, game_ids:, season:, season_type: "Regular Season", league: League::NBA, client: CLIENT)
      team_id = Utils.extract_id(team)
      return unless team_id

      game_ids_str = normalize_game_ids(game_ids)
      return unless game_ids_str

      path = build_path(team_id, game_ids_str, season, season_type, league)
      response = client.get(path)
      parse_response(response)
    end

    # Normalizes game IDs to pipe-separated string
    #
    # @api private
    # @param game_ids [Array<String>, String] game IDs
    # @return [String, nil] pipe-separated game IDs or nil
    def self.normalize_game_ids(game_ids)
      return if game_ids.nil?
      return game_ids if game_ids.instance_of?(String)
      return if game_ids.empty?

      game_ids.join("|")
    end
    private_class_method :normalize_game_ids

    # Builds the API request path
    #
    # @api private
    # @param team_id [Integer] the team ID
    # @param game_ids [String] pipe-separated game IDs
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param league [String, League] the league ID or League object
    # @return [String] the API request path
    def self.build_path(team_id, game_ids, season, season_type, league)
      season_str = Utils.format_season(season)
      league_id = Utils.extract_id(league)
      "cumestatsteam?TeamID=#{team_id}&GameIDs=#{game_ids}&LeagueID=#{league_id}&Season=#{season_str}&SeasonType=#{season_type}"
    end
    private_class_method :build_path

    # Parses the API response
    #
    # @api private
    # @param response [String, nil] the JSON response
    # @return [Hash, nil] parsed result hash or nil
    def self.parse_response(response)
      return unless response

      data = JSON.parse(response)
      return unless data

      game_by_game = parse_game_by_game(data)
      total = parse_total(data)

      return unless game_by_game || total

      {game_by_game: game_by_game, total: total}
    rescue JSON::ParserError
      nil
    end
    private_class_method :parse_response

    # Parses game by game stats
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @return [Collection, nil] collection of player stats or nil
    def self.parse_game_by_game(data)
      result_set = find_result_set(data, GAME_BY_GAME_STATS)
      return unless result_set

      build_player_collection(result_set)
    end
    private_class_method :parse_game_by_game

    # Parses total team stats
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @return [CumeStatsTeamTotal, nil] total stats or nil
    def self.parse_total(data)
      result_set = find_result_set(data, TOTAL_TEAM_STATS)
      return unless result_set

      build_total(result_set)
    end
    private_class_method :parse_total

    # Finds a result set by name
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @param name [String] the result set name
    # @return [Hash, nil] the result set or nil
    def self.find_result_set(data, name)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(name) }
    end
    private_class_method :find_result_set

    # Builds player collection from result set
    #
    # @api private
    # @param result_set [Hash] the result set
    # @return [Collection] collection of player stats
    def self.build_player_collection(result_set)
      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      players = rows.map { |row| build_player(headers, row) }
      Collection.new(players)
    end
    private_class_method :build_player_collection

    # Builds a player stat object
    #
    # @api private
    # @param headers [Array<String>] the headers
    # @param row [Array] the row data
    # @return [CumeStatsTeamPlayer] the player stat
    def self.build_player(headers, row)
      data = headers.zip(row).to_h
      CumeStatsTeamPlayer.new(**PlayerAttributes.extract(data))
    end
    private_class_method :build_player

    # Builds total stat object
    #
    # @api private
    # @param result_set [Hash] the result set
    # @return [CumeStatsTeamTotal, nil] total stat or nil
    def self.build_total(result_set)
      headers = result_set.fetch("headers", nil)
      row = result_set.dig("rowSet", 0)
      return unless headers && row

      data = headers.zip(row).to_h
      CumeStatsTeamTotal.new(**TotalAttributes.extract(data))
    end
    private_class_method :build_total

    # Extracts player attributes from data
    # @api private
    module PlayerAttributes
      # Extracts all player attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] extracted attributes
      def self.extract(data)
        identity(data).merge(stats(data)).merge(averages(data)).merge(per_min(data))
      end

      # Extracts identity attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] identity attributes
      def self.identity(data)
        {person_id: data.fetch("PERSON_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
         jersey_num: data.fetch("JERSEY_NUM", nil), team_id: data.fetch("TEAM_ID", nil)}
      end

      # Extracts stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] stat attributes
      def self.stats(data)
        time_stats(data).merge(shooting_stats(data)).merge(other_stats(data))
      end

      # Extracts time stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] time stat attributes
      def self.time_stats(data)
        {gp: data.fetch("GP", nil), gs: data.fetch("GS", nil),
         actual_minutes: data.fetch("ACTUAL_MINUTES", nil), actual_seconds: data.fetch("ACTUAL_SECONDS", nil)}
      end

      # Extracts shooting stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] shooting stat attributes
      def self.shooting_stats(data)
        {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
         fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
         ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)}
      end

      # Extracts other stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] other stat attributes
      def self.other_stats(data)
        {oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), tot_reb: data.fetch("TOT_REB", nil),
         ast: data.fetch("AST", nil), pf: data.fetch("PF", nil), stl: data.fetch("STL", nil),
         tov: data.fetch("TOV", nil), blk: data.fetch("BLK", nil), pts: data.fetch("PTS", nil)}
      end

      # Extracts average stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] average stat attributes
      def self.averages(data)
        {avg_minutes: data.fetch("AVG_MINUTES", nil), fgm_pg: data.fetch("FGM_PG", nil),
         fga_pg: data.fetch("FGA_PG", nil), fg3m_pg: data.fetch("FG3M_PG", nil),
         fg3a_pg: data.fetch("FG3A_PG", nil), ftm_pg: data.fetch("FTM_PG", nil),
         fta_pg: data.fetch("FTA_PG", nil), oreb_pg: data.fetch("OREB_PG", nil),
         dreb_pg: data.fetch("DREB_PG", nil), reb_pg: data.fetch("REB_PG", nil),
         ast_pg: data.fetch("AST_PG", nil), pf_pg: data.fetch("PF_PG", nil),
         stl_pg: data.fetch("STL_PG", nil), tov_pg: data.fetch("TOV_PG", nil),
         blk_pg: data.fetch("BLK_PG", nil), pts_pg: data.fetch("PTS_PG", nil)}
      end

      # Extracts per-minute stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] per-minute stat attributes
      def self.per_min(data)
        {fgm_per_min: data.fetch("FGM_PER_MIN", nil), fga_per_min: data.fetch("FGA_PER_MIN", nil),
         fg3m_per_min: data.fetch("FG3M_PER_MIN", nil), fg3a_per_min: data.fetch("FG3A_PER_MIN", nil),
         ftm_per_min: data.fetch("FTM_PER_MIN", nil), fta_per_min: data.fetch("FTA_PER_MIN", nil),
         oreb_per_min: data.fetch("OREB_PER_MIN", nil), dreb_per_min: data.fetch("DREB_PER_MIN", nil),
         reb_per_min: data.fetch("REB_PER_MIN", nil), ast_per_min: data.fetch("AST_PER_MIN", nil),
         pf_per_min: data.fetch("PF_PER_MIN", nil), stl_per_min: data.fetch("STL_PER_MIN", nil),
         tov_per_min: data.fetch("TOV_PER_MIN", nil), blk_per_min: data.fetch("BLK_PER_MIN", nil),
         pts_per_min: data.fetch("PTS_PER_MIN", nil)}
      end
    end

    # Extracts total attributes from data
    # @api private
    module TotalAttributes
      # Extracts all total attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] extracted attributes
      def self.extract(data)
        identity(data).merge(record(data)).merge(stats(data))
      end

      # Extracts identity attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] identity attributes
      def self.identity(data)
        {team_id: data.fetch("TEAM_ID", nil), city: data.fetch("CITY", nil), nickname: data.fetch("NICKNAME", nil)}
      end

      # Extracts record attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] record attributes
      def self.record(data)
        games(data).merge(wins_losses(data)).merge(other_record(data))
      end

      # Extracts game attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] game attributes
      def self.games(data)
        {gp: data.fetch("GP", nil), gs: data.fetch("GS", nil)}
      end

      # Extracts win and loss attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] win and loss attributes
      def self.wins_losses(data)
        {w: data.fetch("W", nil), l: data.fetch("L", nil),
         w_home: data.fetch("W_HOME", nil), l_home: data.fetch("L_HOME", nil),
         w_road: data.fetch("W_ROAD", nil), l_road: data.fetch("L_ROAD", nil)}
      end

      # Extracts other record attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] other record attributes
      def self.other_record(data)
        {team_turnovers: data.fetch("TEAM_TURNOVERS", nil), team_rebounds: data.fetch("TEAM_REBOUNDS", nil)}
      end

      # Extracts stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] stat attributes
      def self.stats(data)
        shooting(data).merge(other(data))
      end

      # Extracts shooting attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] shooting attributes
      def self.shooting(data)
        {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
         fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
         ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)}
      end

      # Extracts other stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] other stat attributes
      def self.other(data)
        {oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), tot_reb: data.fetch("TOT_REB", nil),
         ast: data.fetch("AST", nil), pf: data.fetch("PF", nil), stl: data.fetch("STL", nil),
         tov: data.fetch("TOV", nil), blk: data.fetch("BLK", nil), pts: data.fetch("PTS", nil)}
      end
    end
  end
end
