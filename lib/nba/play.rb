module NBA
  # Represents a single play in a game's play-by-play data
  class Play < Shale::Mapper
    include Equalizer.new(:game_id, :event_num)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     play.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] event_num
    #   Returns the event number
    #   @api public
    #   @example
    #     play.event_num #=> 1
    #   @return [Integer] the event number
    attribute :event_num, Shale::Type::Integer

    # @!attribute [rw] event_msg_type
    #   Returns the event message type
    #   @api public
    #   @example
    #     play.event_msg_type #=> 2
    #   @return [Integer] the event message type
    attribute :event_msg_type, Shale::Type::Integer

    # @!attribute [rw] event_msg_action_type
    #   Returns the event message action type
    #   @api public
    #   @example
    #     play.event_msg_action_type #=> 79
    #   @return [Integer] the event message action type
    attribute :event_msg_action_type, Shale::Type::Integer

    # @!attribute [rw] period
    #   Returns the period number
    #   @api public
    #   @example
    #     play.period #=> 1
    #   @return [Integer] the period number
    attribute :period, Shale::Type::Integer

    # @!attribute [rw] wc_time_string
    #   Returns the wall clock time string
    #   @api public
    #   @example
    #     play.wc_time_string #=> "8:05 PM"
    #   @return [String] the wall clock time
    attribute :wc_time_string, Shale::Type::String

    # @!attribute [rw] pc_time_string
    #   Returns the period clock time string
    #   @api public
    #   @example
    #     play.pc_time_string #=> "11:45"
    #   @return [String] the period clock time
    attribute :pc_time_string, Shale::Type::String

    # @!attribute [rw] home_description
    #   Returns the home team's play description
    #   @api public
    #   @example
    #     play.home_description #=> "Curry 3PT Jump Shot (3 PTS)"
    #   @return [String] the home description
    attribute :home_description, Shale::Type::String

    # @!attribute [rw] neutral_description
    #   Returns the neutral play description
    #   @api public
    #   @example
    #     play.neutral_description #=> "Jump Ball"
    #   @return [String] the neutral description
    attribute :neutral_description, Shale::Type::String

    # @!attribute [rw] visitor_description
    #   Returns the visitor team's play description
    #   @api public
    #   @example
    #     play.visitor_description #=> "James Turnover"
    #   @return [String] the visitor description
    attribute :visitor_description, Shale::Type::String

    # @!attribute [rw] score
    #   Returns the current score
    #   @api public
    #   @example
    #     play.score #=> "105 - 102"
    #   @return [String] the score (e.g., "105 - 102")
    attribute :score, Shale::Type::String

    # @!attribute [rw] score_margin
    #   Returns the score margin
    #   @api public
    #   @example
    #     play.score_margin #=> "3"
    #   @return [String] the score margin
    attribute :score_margin, Shale::Type::String

    # @!attribute [rw] player1_id
    #   Returns the first player's ID
    #   @api public
    #   @example
    #     play.player1_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player1_id, Shale::Type::Integer

    # @!attribute [rw] player1_name
    #   Returns the first player's name
    #   @api public
    #   @example
    #     play.player1_name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :player1_name, Shale::Type::String

    # @!attribute [rw] player1_team_id
    #   Returns the first player's team ID
    #   @api public
    #   @example
    #     play.player1_team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :player1_team_id, Shale::Type::Integer

    # @!attribute [rw] player1_team_abbreviation
    #   Returns the first player's team abbreviation
    #   @api public
    #   @example
    #     play.player1_team_abbreviation #=> "GSW"
    #   @return [String] the team abbreviation
    attribute :player1_team_abbreviation, Shale::Type::String

    # @!attribute [rw] player2_id
    #   Returns the second player's ID
    #   @api public
    #   @example
    #     play.player2_id #=> 2544
    #   @return [Integer] the player ID
    attribute :player2_id, Shale::Type::Integer

    # @!attribute [rw] player2_name
    #   Returns the second player's name
    #   @api public
    #   @example
    #     play.player2_name #=> "LeBron James"
    #   @return [String] the player name
    attribute :player2_name, Shale::Type::String

    # @!attribute [rw] player2_team_id
    #   Returns the second player's team ID
    #   @api public
    #   @example
    #     play.player2_team_id #=> 1610612747
    #   @return [Integer] the team ID
    attribute :player2_team_id, Shale::Type::Integer

    # @!attribute [rw] player2_team_abbreviation
    #   Returns the second player's team abbreviation
    #   @api public
    #   @example
    #     play.player2_team_abbreviation #=> "LAL"
    #   @return [String] the team abbreviation
    attribute :player2_team_abbreviation, Shale::Type::String

    # @!attribute [rw] player3_id
    #   Returns the third player's ID
    #   @api public
    #   @example
    #     play.player3_id #=> 203507
    #   @return [Integer] the player ID
    attribute :player3_id, Shale::Type::Integer

    # @!attribute [rw] player3_name
    #   Returns the third player's name
    #   @api public
    #   @example
    #     play.player3_name #=> "Draymond Green"
    #   @return [String] the player name
    attribute :player3_name, Shale::Type::String

    # @!attribute [rw] player3_team_id
    #   Returns the third player's team ID
    #   @api public
    #   @example
    #     play.player3_team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :player3_team_id, Shale::Type::Integer

    # @!attribute [rw] player3_team_abbreviation
    #   Returns the third player's team abbreviation
    #   @api public
    #   @example
    #     play.player3_team_abbreviation #=> "GSW"
    #   @return [String] the team abbreviation
    attribute :player3_team_abbreviation, Shale::Type::String

    # @!attribute [rw] video_available
    #   Returns whether video is available for this play
    #   @api public
    #   @example
    #     play.video_available #=> 1
    #   @return [Integer] 1 if available, 0 if not
    attribute :video_available, Shale::Type::Integer

    # Returns the primary description for this play
    #
    # @api public
    # @example
    #   play.description #=> "Curry 3PT Jump Shot"
    # @return [String, nil] the description
    def description
      home_description || visitor_description || neutral_description
    end

    # Returns the game object for this play
    #
    # @api public
    # @example
    #   play.game #=> #<NBA::Game>
    # @return [Game, nil] the game object
    def game
      Games.find(game_id)
    end

    # Returns the first player involved in this play
    #
    # @api public
    # @example
    #   play.player1 #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player1
      Players.find(player1_id)
    end

    # Returns the second player involved in this play
    #
    # @api public
    # @example
    #   play.player2 #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player2
      Players.find(player2_id)
    end

    # Returns the third player involved in this play
    #
    # @api public
    # @example
    #   play.player3 #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player3
      Players.find(player3_id)
    end

    alias_method :player, :player1
  end
end
