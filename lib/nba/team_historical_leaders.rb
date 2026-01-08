require_relative "client"
require_relative "collection"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Provides methods to retrieve team historical career leaders
  #
  # @api public
  module TeamHistoricalLeaders
    # Result set name in API response
    # @return [String] the result set name
    RESULT_SET_NAME = "CareerLeadersByTeam".freeze

    # Retrieves historical leaders for a team
    #
    # @api public
    # @example
    #   leaders = NBA::TeamHistoricalLeaders.find(team: 1610612744)
    #   leaders.pts_player #=> "Stephen Curry"
    # @param team [Integer, Team] the team or team ID
    # @param season [Integer] the season year (defaults to current season)
    # @param client [Client] the API client to use
    # @return [TeamHistoricalLeader, nil] the team historical leaders
    def self.find(team:, season: Utils.current_season, client: CLIENT)
      id = Utils.extract_id(team)
      return unless id

      path = build_path(id, season)
      ResponseParser.parse_single(client.get(path), result_set: RESULT_SET_NAME) { |data| build_leader(data) }
    end

    # Builds the API path
    # @api private
    # @return [String]
    def self.build_path(team_id, season)
      "teamhistoricalleaders?TeamID=#{team_id}&LeagueID=00&SeasonID=#{Utils.format_season_id(season)}"
    end
    private_class_method :build_path

    # Builds a TeamHistoricalLeader from API data
    # @api private
    # @return [TeamHistoricalLeader]
    def self.build_leader(data)
      TeamHistoricalLeader.new(**identity_info(data), **pts_info(data), **ast_info(data), **reb_info(data),
        **blk_info(data), **stl_info(data))
    end
    private_class_method :build_leader

    # Extracts identity fields
    # @api private
    # @return [Hash]
    def self.identity_info(data)
      {team_id: data["TEAM_ID"], season_year: data["SEASON_YEAR"]}
    end
    private_class_method :identity_info

    # Extracts points leader fields
    # @api private
    # @return [Hash]
    def self.pts_info(data)
      {pts: data["PTS"], pts_person_id: data["PTS_PERSON_ID"], pts_player: data["PTS_PLAYER"]}
    end
    private_class_method :pts_info

    # Extracts assists leader fields
    # @api private
    # @return [Hash]
    def self.ast_info(data)
      {ast: data["AST"], ast_person_id: data["AST_PERSON_ID"], ast_player: data["AST_PLAYER"]}
    end
    private_class_method :ast_info

    # Extracts rebounds leader fields
    # @api private
    # @return [Hash]
    def self.reb_info(data)
      {reb: data["REB"], reb_person_id: data["REB_PERSON_ID"], reb_player: data["REB_PLAYER"]}
    end
    private_class_method :reb_info

    # Extracts blocks leader fields
    # @api private
    # @return [Hash]
    def self.blk_info(data)
      {blk: data["BLK"], blk_person_id: data["BLK_PERSON_ID"], blk_player: data["BLK_PLAYER"]}
    end
    private_class_method :blk_info

    # Extracts steals leader fields
    # @api private
    # @return [Hash]
    def self.stl_info(data)
      {stl: data["STL"], stl_person_id: data["STL_PERSON_ID"], stl_player: data["STL_PLAYER"]}
    end
    private_class_method :stl_info
  end
end
