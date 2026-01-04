module NBA
  # Represents a live game from the NBA Live Data API
  class LiveGame < Shale::Mapper
    include Equalizer.new(:game_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     game.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] game_code
    #   Returns the game code
    #   @api public
    #   @example
    #     game.game_code #=> "20241022/LALGSW"
    #   @return [String] the game code
    attribute :game_code, Shale::Type::String

    # @!attribute [rw] game_status
    #   Returns the game status (1=scheduled, 2=in progress, 3=final)
    #   @api public
    #   @example
    #     game.game_status #=> 2
    #   @return [Integer] the game status
    attribute :game_status, Shale::Type::Integer

    # @!attribute [rw] game_status_text
    #   Returns the game status text
    #   @api public
    #   @example
    #     game.game_status_text #=> "Q4 2:30"
    #   @return [String] the game status text
    attribute :game_status_text, Shale::Type::String

    # @!attribute [rw] period
    #   Returns the current period
    #   @api public
    #   @example
    #     game.period #=> 4
    #   @return [Integer] the current period
    attribute :period, Shale::Type::Integer

    # @!attribute [rw] game_clock
    #   Returns the game clock
    #   @api public
    #   @example
    #     game.game_clock #=> "PT02M30.00S"
    #   @return [String] the game clock in ISO 8601 duration format
    attribute :game_clock, Shale::Type::String

    # @!attribute [rw] game_time_utc
    #   Returns the game time in UTC
    #   @api public
    #   @example
    #     game.game_time_utc #=> "2024-10-22T23:30:00Z"
    #   @return [String] the game time in UTC
    attribute :game_time_utc, Shale::Type::String

    # @!attribute [rw] game_et
    #   Returns the game time in Eastern Time
    #   @api public
    #   @example
    #     game.game_et #=> "2024-10-22T19:30:00"
    #   @return [String] the game time in ET
    attribute :game_et, Shale::Type::String

    # @!attribute [rw] home_team_id
    #   Returns the home team ID
    #   @api public
    #   @example
    #     game.home_team_id #=> 1610612744
    #   @return [Integer] the home team ID
    attribute :home_team_id, Shale::Type::Integer

    # @!attribute [rw] home_team_name
    #   Returns the home team name
    #   @api public
    #   @example
    #     game.home_team_name #=> "Warriors"
    #   @return [String] the home team name
    attribute :home_team_name, Shale::Type::String

    # @!attribute [rw] home_team_city
    #   Returns the home team city
    #   @api public
    #   @example
    #     game.home_team_city #=> "Golden State"
    #   @return [String] the home team city
    attribute :home_team_city, Shale::Type::String

    # @!attribute [rw] home_team_tricode
    #   Returns the home team tricode
    #   @api public
    #   @example
    #     game.home_team_tricode #=> "GSW"
    #   @return [String] the home team tricode
    attribute :home_team_tricode, Shale::Type::String

    # @!attribute [rw] home_team_score
    #   Returns the home team score
    #   @api public
    #   @example
    #     game.home_team_score #=> 112
    #   @return [Integer] the home team score
    attribute :home_team_score, Shale::Type::Integer

    # @!attribute [rw] away_team_id
    #   Returns the away team ID
    #   @api public
    #   @example
    #     game.away_team_id #=> 1610612747
    #   @return [Integer] the away team ID
    attribute :away_team_id, Shale::Type::Integer

    # @!attribute [rw] away_team_name
    #   Returns the away team name
    #   @api public
    #   @example
    #     game.away_team_name #=> "Lakers"
    #   @return [String] the away team name
    attribute :away_team_name, Shale::Type::String

    # @!attribute [rw] away_team_city
    #   Returns the away team city
    #   @api public
    #   @example
    #     game.away_team_city #=> "Los Angeles"
    #   @return [String] the away team city
    attribute :away_team_city, Shale::Type::String

    # @!attribute [rw] away_team_tricode
    #   Returns the away team tricode
    #   @api public
    #   @example
    #     game.away_team_tricode #=> "LAL"
    #   @return [String] the away team tricode
    attribute :away_team_tricode, Shale::Type::String

    # @!attribute [rw] away_team_score
    #   Returns the away team score
    #   @api public
    #   @example
    #     game.away_team_score #=> 108
    #   @return [Integer] the away team score
    attribute :away_team_score, Shale::Type::Integer

    # Returns the home team object
    #
    # @api public
    # @example
    #   game.home_team #=> #<NBA::Team>
    # @return [Team, nil] the home team object
    def home_team
      Teams.find(home_team_id)
    end

    # Returns the away team object
    #
    # @api public
    # @example
    #   game.away_team #=> #<NBA::Team>
    # @return [Team, nil] the away team object
    def away_team
      Teams.find(away_team_id)
    end

    # Returns whether the game is scheduled
    #
    # @api public
    # @example
    #   game.scheduled? #=> false
    # @return [Boolean] true if scheduled
    def scheduled?
      game_status.eql?(1)
    end

    # Returns whether the game is in progress
    #
    # @api public
    # @example
    #   game.in_progress? #=> true
    # @return [Boolean] true if in progress
    def in_progress?
      game_status.eql?(2)
    end

    # Returns whether the game is final
    #
    # @api public
    # @example
    #   game.final? #=> false
    # @return [Boolean] true if final
    def final?
      game_status.eql?(3)
    end
  end
end
