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
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(name) }
    end
    private_class_method :find_result_set

    # Builds player collection from result set
    #
    # @api private
    # @param result_set [Hash] the result set
    # @return [Collection] collection of player stats
    def self.build_player_collection(result_set)
      headers = result_set["headers"]
      rows = result_set["rowSet"]
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
      headers = result_set["headers"]
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
        {person_id: data["PERSON_ID"], player_name: data["PLAYER_NAME"],
         jersey_num: data["JERSEY_NUM"], team_id: data["TEAM_ID"]}
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
        {gp: data["GP"], gs: data["GS"],
         actual_minutes: data["ACTUAL_MINUTES"], actual_seconds: data["ACTUAL_SECONDS"]}
      end

      # Extracts shooting stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] shooting stat attributes
      def self.shooting_stats(data)
        {fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"],
         fg3m: data["FG3M"], fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"],
         ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]}
      end

      # Extracts other stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] other stat attributes
      def self.other_stats(data)
        {oreb: data["OREB"], dreb: data["DREB"], tot_reb: data["TOT_REB"],
         ast: data["AST"], pf: data["PF"], stl: data["STL"],
         tov: data["TOV"], blk: data["BLK"], pts: data["PTS"]}
      end

      # Extracts average stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] average stat attributes
      def self.averages(data)
        {avg_minutes: data["AVG_MINUTES"], fgm_pg: data["FGM_PG"],
         fga_pg: data["FGA_PG"], fg3m_pg: data["FG3M_PG"],
         fg3a_pg: data["FG3A_PG"], ftm_pg: data["FTM_PG"],
         fta_pg: data["FTA_PG"], oreb_pg: data["OREB_PG"],
         dreb_pg: data["DREB_PG"], reb_pg: data["REB_PG"],
         ast_pg: data["AST_PG"], pf_pg: data["PF_PG"],
         stl_pg: data["STL_PG"], tov_pg: data["TOV_PG"],
         blk_pg: data["BLK_PG"], pts_pg: data["PTS_PG"]}
      end

      # Extracts per-minute stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] per-minute stat attributes
      def self.per_min(data)
        {fgm_per_min: data["FGM_PER_MIN"], fga_per_min: data["FGA_PER_MIN"],
         fg3m_per_min: data["FG3M_PER_MIN"], fg3a_per_min: data["FG3A_PER_MIN"],
         ftm_per_min: data["FTM_PER_MIN"], fta_per_min: data["FTA_PER_MIN"],
         oreb_per_min: data["OREB_PER_MIN"], dreb_per_min: data["DREB_PER_MIN"],
         reb_per_min: data["REB_PER_MIN"], ast_per_min: data["AST_PER_MIN"],
         pf_per_min: data["PF_PER_MIN"], stl_per_min: data["STL_PER_MIN"],
         tov_per_min: data["TOV_PER_MIN"], blk_per_min: data["BLK_PER_MIN"],
         pts_per_min: data["PTS_PER_MIN"]}
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
        {team_id: data["TEAM_ID"], city: data["CITY"], nickname: data["NICKNAME"]}
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
        {gp: data["GP"], gs: data["GS"]}
      end

      # Extracts win and loss attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] win and loss attributes
      def self.wins_losses(data)
        {w: data["W"], l: data["L"],
         w_home: data["W_HOME"], l_home: data["L_HOME"],
         w_road: data["W_ROAD"], l_road: data["L_ROAD"]}
      end

      # Extracts other record attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] other record attributes
      def self.other_record(data)
        {team_turnovers: data["TEAM_TURNOVERS"], team_rebounds: data["TEAM_REBOUNDS"]}
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
        {fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"],
         fg3m: data["FG3M"], fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"],
         ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]}
      end

      # Extracts other stat attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] other stat attributes
      def self.other(data)
        {oreb: data["OREB"], dreb: data["DREB"], tot_reb: data["TOT_REB"],
         ast: data["AST"], pf: data["PF"], stl: data["STL"],
         tov: data["TOV"], blk: data["BLK"], pts: data["PTS"]}
      end
    end
  end
end
