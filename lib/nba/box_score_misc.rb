require_relative "client"
require_relative "response_parser"
require_relative "box_score_misc_player_stat"
require_relative "box_score_misc_team_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve miscellaneous box score statistics
  module BoxScoreMisc
    # Result set name for player stats
    # @return [String] the result set name
    PLAYER_STATS = "PlayerStats".freeze

    # Result set name for team stats
    # @return [String] the result set name
    TEAM_STATS = "TeamStats".freeze

    # Retrieves player miscellaneous box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreMisc.player_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.player_name}: #{s.pts_paint} paint pts" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player miscellaneous box score stats
    def self.player_stats(game:, client: CLIENT)
      path = "boxscoremiscv2?GameID=#{Utils.extract_id(game)}"
      ResponseParser.parse(client.get(path), result_set: PLAYER_STATS) { |data| build_player_stat(data) }
    end

    # Retrieves team miscellaneous box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreMisc.team_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.team_name}: #{s.pts_fb} fast break pts" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team miscellaneous box score stats
    def self.team_stats(game:, client: CLIENT)
      path = "boxscoremiscv2?GameID=#{Utils.extract_id(game)}"
      ResponseParser.parse(client.get(path), result_set: TEAM_STATS) { |data| build_team_stat(data) }
    end

    # Builds a player miscellaneous stat from API data
    # @api private
    # @return [BoxScoreMiscPlayerStat]
    def self.build_player_stat(data)
      BoxScoreMiscPlayerStat.new(**player_identity(data), **scoring_stats(data), **defense_stats(data))
    end
    private_class_method :build_player_stat

    # Builds a team miscellaneous stat from API data
    # @api private
    # @return [BoxScoreMiscTeamStat]
    def self.build_team_stat(data)
      BoxScoreMiscTeamStat.new(**team_identity(data), **scoring_stats(data), **defense_stats(data))
    end
    private_class_method :build_team_stat

    # Extracts player identity attributes from data
    # @api private
    # @return [Hash]
    def self.player_identity(data)
      {game_id: data["GAME_ID"], team_id: data["TEAM_ID"], team_abbreviation: data["TEAM_ABBREVIATION"],
       team_city: data["TEAM_CITY"], player_id: data["PLAYER_ID"], player_name: data["PLAYER_NAME"],
       start_position: data["START_POSITION"], comment: data["COMMENT"], min: data["MIN"]}
    end
    private_class_method :player_identity

    # Extracts team identity attributes from data
    # @api private
    # @return [Hash]
    def self.team_identity(data)
      {game_id: data["GAME_ID"], team_id: data["TEAM_ID"], team_name: data["TEAM_NAME"],
       team_abbreviation: data["TEAM_ABBREVIATION"], team_city: data["TEAM_CITY"], min: data["MIN"]}
    end
    private_class_method :team_identity

    # Extracts scoring statistics from data
    # @api private
    # @return [Hash]
    def self.scoring_stats(data)
      {pts_off_tov: data["PTS_OFF_TOV"], pts_2nd_chance: data["PTS_2ND_CHANCE"],
       pts_fb: data["PTS_FB"], pts_paint: data["PTS_PAINT"],
       opp_pts_off_tov: data["OPP_PTS_OFF_TOV"], opp_pts_2nd_chance: data["OPP_PTS_2ND_CHANCE"],
       opp_pts_fb: data["OPP_PTS_FB"], opp_pts_paint: data["OPP_PTS_PAINT"]}
    end
    private_class_method :scoring_stats

    # Extracts defense statistics from data
    # @api private
    # @return [Hash]
    def self.defense_stats(data)
      {blk: data["BLK"], blka: data["BLKA"], pf: data["PF"], pfd: data["PFD"]}
    end
    private_class_method :defense_stats
  end
end
