module NBA
  # Represents a playoff series
  class PlayoffSeries < Shale::Mapper
    include Equalizer.new(:game_id, :series_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     series.game_id #=> "0042400101"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] home_team_id
    #   Returns the home team ID
    #   @api public
    #   @example
    #     series.home_team_id #=> 1610612744
    #   @return [Integer] the home team ID
    attribute :home_team_id, Shale::Type::Integer

    # @!attribute [rw] visitor_team_id
    #   Returns the visitor team ID
    #   @api public
    #   @example
    #     series.visitor_team_id #=> 1610612747
    #   @return [Integer] the visitor team ID
    attribute :visitor_team_id, Shale::Type::Integer

    # @!attribute [rw] series_id
    #   Returns the series ID
    #   @api public
    #   @example
    #     series.series_id #=> "0042400101"
    #   @return [String] the series ID
    attribute :series_id, Shale::Type::String

    # @!attribute [rw] game_num
    #   Returns the game number in the series
    #   @api public
    #   @example
    #     series.game_num #=> 1
    #   @return [Integer] the game number
    attribute :game_num, Shale::Type::Integer

    # Returns the home team object
    #
    # @api public
    # @example
    #   series.home_team #=> #<NBA::Team>
    # @return [Team, nil] the home team object
    def home_team
      Teams.find(home_team_id)
    end

    # Returns the visitor team object
    #
    # @api public
    # @example
    #   series.visitor_team #=> #<NBA::Team>
    # @return [Team, nil] the visitor team object
    def visitor_team
      Teams.find(visitor_team_id)
    end

    # Returns the game object
    #
    # @api public
    # @example
    #   series.game #=> #<NBA::Game>
    # @return [Game, nil] the game object
    def game
      Games.find(game_id)
    end
  end
end
