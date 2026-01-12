module NBA
  # Represents a scheduled game
  class ScheduledGame < Shale::Mapper
    include Equalizer.new(:game_id)

    # @!attribute [rw] game_date
    #   Returns the game date
    #   @api public
    #   @example
    #     game.game_date #=> "2024-10-22T19:00:00Z"
    #   @return [String] the game date
    attribute :game_date, Shale::Type::String

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
    #     game.game_status #=> 1
    #   @return [Integer] the game status
    attribute :game_status, Shale::Type::Integer

    # @!attribute [rw] game_status_text
    #   Returns the game status text
    #   @api public
    #   @example
    #     game.game_status_text #=> "7:00 pm ET"
    #   @return [String] the game status text
    attribute :game_status_text, Shale::Type::String

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
    #   Returns the home team tricode/abbreviation
    #   @api public
    #   @example
    #     game.home_team_tricode #=> "GSW"
    #   @return [String] the home team tricode
    attribute :home_team_tricode, Shale::Type::String

    # @!attribute [rw] home_team_wins
    #   Returns the home team wins
    #   @api public
    #   @example
    #     game.home_team_wins #=> 46
    #   @return [Integer] the home team wins
    attribute :home_team_wins, Shale::Type::Integer

    # @!attribute [rw] home_team_losses
    #   Returns the home team losses
    #   @api public
    #   @example
    #     game.home_team_losses #=> 36
    #   @return [Integer] the home team losses
    attribute :home_team_losses, Shale::Type::Integer

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
    #   Returns the away team tricode/abbreviation
    #   @api public
    #   @example
    #     game.away_team_tricode #=> "LAL"
    #   @return [String] the away team tricode
    attribute :away_team_tricode, Shale::Type::String

    # @!attribute [rw] away_team_wins
    #   Returns the away team wins
    #   @api public
    #   @example
    #     game.away_team_wins #=> 43
    #   @return [Integer] the away team wins
    attribute :away_team_wins, Shale::Type::Integer

    # @!attribute [rw] away_team_losses
    #   Returns the away team losses
    #   @api public
    #   @example
    #     game.away_team_losses #=> 39
    #   @return [Integer] the away team losses
    attribute :away_team_losses, Shale::Type::Integer

    # @!attribute [rw] away_team_score
    #   Returns the away team score
    #   @api public
    #   @example
    #     game.away_team_score #=> 108
    #   @return [Integer] the away team score
    attribute :away_team_score, Shale::Type::Integer

    # @!attribute [rw] arena_name
    #   Returns the arena name
    #   @api public
    #   @example
    #     game.arena_name #=> "Chase Center"
    #   @return [String] the arena name
    attribute :arena_name, Shale::Type::String

    # @!attribute [rw] arena_city
    #   Returns the arena city
    #   @api public
    #   @example
    #     game.arena_city #=> "San Francisco"
    #   @return [String] the arena city
    attribute :arena_city, Shale::Type::String

    # @!attribute [rw] arena_state
    #   Returns the arena state
    #   @api public
    #   @example
    #     game.arena_state #=> "CA"
    #   @return [String] the arena state
    attribute :arena_state, Shale::Type::String

    # @!attribute [rw] broadcasters
    #   Returns the broadcaster information
    #   @api public
    #   @example
    #     game.broadcasters #=> "TNT"
    #   @return [String] the broadcasters
    attribute :broadcasters, Shale::Type::String

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
    #   game.scheduled? #=> true
    # @return [Boolean] true if scheduled
    def scheduled?
      game_status.eql?(1)
    end

    # Returns whether the game is in progress
    #
    # @api public
    # @example
    #   game.in_progress? #=> false
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
