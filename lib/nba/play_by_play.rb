require_relative "client"
require_relative "response_parser"
require_relative "play"
require_relative "utils"

module NBA
  # Provides methods to retrieve play-by-play data for games
  module PlayByPlay
    # Result set name for play-by-play data
    # @return [String] the result set name
    RESULT_SET_NAME = "PlayByPlay".freeze

    # Retrieves play-by-play data for a game
    #
    # @api public
    # @example
    #   plays = NBA::PlayByPlay.find(game: "0022400001")
    #   plays.each { |p| puts "#{p.pc_time_string}: #{p.description}" }
    # @param game [String, Game] the game ID or Game object
    # @param start_period [Integer] the starting period (default 1)
    # @param end_period [Integer] the ending period (default 10)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of plays
    def self.find(game:, start_period: 1, end_period: 10, client: CLIENT)
      path = "playbyplayv2?GameID=#{Utils.extract_id(game)}&StartPeriod=#{start_period}&EndPeriod=#{end_period}"
      ResponseParser.parse(client.get(path), result_set: RESULT_SET_NAME) { |data| build_play(data) }
    end

    # Builds a play from API data
    # @api private
    # @return [Play]
    def self.build_play(data)
      Play.new(**event_info(data), **descriptions(data), **player1_info(data),
        **player2_info(data), **player3_info(data))
    end
    private_class_method :build_play

    # Extracts event information from data
    # @api private
    # @return [Hash]
    def self.event_info(data)
      {game_id: data.fetch("GAME_ID", nil), event_num: data.fetch("EVENTNUM", nil), event_msg_type: data.fetch("EVENTMSGTYPE", nil),
       event_msg_action_type: data.fetch("EVENTMSGACTIONTYPE", nil), period: data.fetch("PERIOD", nil),
       wc_time_string: data.fetch("WCTIMESTRING", nil), pc_time_string: data.fetch("PCTIMESTRING", nil)}
    end
    private_class_method :event_info

    # Extracts description attributes from data
    # @api private
    # @return [Hash]
    def self.descriptions(data)
      {home_description: data.fetch("HOMEDESCRIPTION", nil), neutral_description: data.fetch("NEUTRALDESCRIPTION", nil),
       visitor_description: data.fetch("VISITORDESCRIPTION", nil), score: data.fetch("SCORE", nil),
       score_margin: data.fetch("SCOREMARGIN", nil), video_available: data.fetch("VIDEO_AVAILABLE_FLAG", nil)}
    end
    private_class_method :descriptions

    # Extracts player 1 information from data
    # @api private
    # @return [Hash]
    def self.player1_info(data)
      {player1_id: data.fetch("PLAYER1_ID", nil), player1_name: data.fetch("PLAYER1_NAME", nil),
       player1_team_id: data.fetch("PLAYER1_TEAM_ID", nil), player1_team_abbreviation: data.fetch("PLAYER1_TEAM_ABBREVIATION", nil)}
    end
    private_class_method :player1_info

    # Extracts player 2 information from data
    # @api private
    # @return [Hash]
    def self.player2_info(data)
      {player2_id: data.fetch("PLAYER2_ID", nil), player2_name: data.fetch("PLAYER2_NAME", nil),
       player2_team_id: data.fetch("PLAYER2_TEAM_ID", nil), player2_team_abbreviation: data.fetch("PLAYER2_TEAM_ABBREVIATION", nil)}
    end
    private_class_method :player2_info

    # Extracts player 3 information from data
    # @api private
    # @return [Hash]
    def self.player3_info(data)
      {player3_id: data.fetch("PLAYER3_ID", nil), player3_name: data.fetch("PLAYER3_NAME", nil),
       player3_team_id: data.fetch("PLAYER3_TEAM_ID", nil), player3_team_abbreviation: data.fetch("PLAYER3_TEAM_ABBREVIATION", nil)}
    end
    private_class_method :player3_info
  end
end
