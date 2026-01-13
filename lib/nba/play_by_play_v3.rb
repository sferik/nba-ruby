require_relative "client"
require_relative "response_parser"
require_relative "play"
require_relative "utils"

module NBA
  # Provides methods to retrieve play-by-play V3 data for games
  module PlayByPlayV3
    # Result set name for play-by-play data
    # @return [String] the result set name
    RESULT_SET_NAME = "PlayByPlay".freeze

    # Retrieves play-by-play V3 data for a game
    #
    # @api public
    # @example
    #   plays = NBA::PlayByPlayV3.find(game: "0022400001")
    #   plays.each { |p| puts "#{p.pc_time_string}: #{p.description}" }
    # @param game [String, Game] the game ID or Game object
    # @param start_period [Integer] the starting period (default 0)
    # @param end_period [Integer] the ending period (default 14)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of plays
    def self.find(game:, start_period: 0, end_period: 14, client: CLIENT)
      path = "playbyplayv3?GameID=#{Utils.extract_id(game)}&StartPeriod=#{start_period}&EndPeriod=#{end_period}"
      ResponseParser.parse(client.get(path), result_set: RESULT_SET_NAME) { |data| build_play(data) }
    end

    # Builds a play from API data
    # @api private
    # @param data [Hash] the row data
    # @return [Play] the play object
    def self.build_play(data)
      Play.new(**event_info(data), **descriptions(data), **player1_info(data),
        **player2_info(data), **player3_info(data))
    end
    private_class_method :build_play

    # Extracts event information from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] event info attributes
    def self.event_info(data)
      {game_id: data["GAME_ID"], event_num: data["EVENTNUM"], event_msg_type: data["EVENTMSGTYPE"],
       event_msg_action_type: data["EVENTMSGACTIONTYPE"], period: data["PERIOD"],
       wc_time_string: data["WCTIMESTRING"], pc_time_string: data["PCTIMESTRING"]}
    end
    private_class_method :event_info

    # Extracts description attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] description attributes
    def self.descriptions(data)
      {home_description: data["HOMEDESCRIPTION"], neutral_description: data["NEUTRALDESCRIPTION"],
       visitor_description: data["VISITORDESCRIPTION"], score: data["SCORE"],
       score_margin: data["SCOREMARGIN"], video_available: data["VIDEO_AVAILABLE_FLAG"]}
    end
    private_class_method :descriptions

    # Extracts player 1 information from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] player 1 attributes
    def self.player1_info(data)
      {player1_id: data["PLAYER1_ID"], player1_name: data["PLAYER1_NAME"],
       player1_team_id: data["PLAYER1_TEAM_ID"], player1_team_abbreviation: data["PLAYER1_TEAM_ABBREVIATION"]}
    end
    private_class_method :player1_info

    # Extracts player 2 information from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] player 2 attributes
    def self.player2_info(data)
      {player2_id: data["PLAYER2_ID"], player2_name: data["PLAYER2_NAME"],
       player2_team_id: data["PLAYER2_TEAM_ID"], player2_team_abbreviation: data["PLAYER2_TEAM_ABBREVIATION"]}
    end
    private_class_method :player2_info

    # Extracts player 3 information from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] player 3 attributes
    def self.player3_info(data)
      {player3_id: data["PLAYER3_ID"], player3_name: data["PLAYER3_NAME"],
       player3_team_id: data["PLAYER3_TEAM_ID"], player3_team_abbreviation: data["PLAYER3_TEAM_ABBREVIATION"]}
    end
    private_class_method :player3_info
  end
end
