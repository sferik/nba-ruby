require "equalizer"
require "shale"
require_relative "players"
require_relative "teams"

module NBA
  # Represents league-wide player biographical statistics
  #
  # @api public
  class LeagueDashPlayerBioStat < Shale::Mapper
    include Equalizer.new(:player_id, :team_id)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer, nil] the player's ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     stat.player_name #=> "Stephen Curry"
    #   @return [String, nil] the player's name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer, nil] the team's ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     stat.team_abbreviation #=> "GSW"
    #   @return [String, nil] the team's abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] age
    #   Returns the player's age
    #   @api public
    #   @example
    #     stat.age #=> 36
    #   @return [Float, nil] the player's age
    attribute :age, Shale::Type::Float

    # @!attribute [rw] player_height
    #   Returns the player's height as a formatted string
    #   @api public
    #   @example
    #     stat.player_height #=> "6-2"
    #   @return [String, nil] the player's height
    attribute :player_height, Shale::Type::String

    # @!attribute [rw] player_height_inches
    #   Returns the player's height in inches
    #   @api public
    #   @example
    #     stat.player_height_inches #=> 74
    #   @return [Integer, nil] the player's height in inches
    attribute :player_height_inches, Shale::Type::Integer

    # @!attribute [rw] player_weight
    #   Returns the player's weight in pounds
    #   @api public
    #   @example
    #     stat.player_weight #=> 185
    #   @return [Integer, nil] the player's weight
    attribute :player_weight, Shale::Type::Integer

    # @!attribute [rw] college
    #   Returns the player's college
    #   @api public
    #   @example
    #     stat.college #=> "Davidson"
    #   @return [String, nil] the player's college
    attribute :college, Shale::Type::String

    # @!attribute [rw] country
    #   Returns the player's country
    #   @api public
    #   @example
    #     stat.country #=> "USA"
    #   @return [String, nil] the player's country
    attribute :country, Shale::Type::String

    # @!attribute [rw] draft_year
    #   Returns the player's draft year
    #   @api public
    #   @example
    #     stat.draft_year #=> "2009"
    #   @return [String, nil] the player's draft year
    attribute :draft_year, Shale::Type::String

    # @!attribute [rw] draft_round
    #   Returns the player's draft round
    #   @api public
    #   @example
    #     stat.draft_round #=> "1"
    #   @return [String, nil] the player's draft round
    attribute :draft_round, Shale::Type::String

    # @!attribute [rw] draft_number
    #   Returns the player's draft number
    #   @api public
    #   @example
    #     stat.draft_number #=> "7"
    #   @return [String, nil] the player's draft number
    attribute :draft_number, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 74
    #   @return [Integer, nil] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns points per game
    #   @api public
    #   @example
    #     stat.pts #=> 26.4
    #   @return [Float, nil] points per game
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns rebounds per game
    #   @api public
    #   @example
    #     stat.reb #=> 5.2
    #   @return [Float, nil] rebounds per game
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists per game
    #   @api public
    #   @example
    #     stat.ast #=> 6.1
    #   @return [Float, nil] assists per game
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] net_rating
    #   Returns net rating
    #   @api public
    #   @example
    #     stat.net_rating #=> 8.5
    #   @return [Float, nil] net rating
    attribute :net_rating, Shale::Type::Float

    # @!attribute [rw] oreb_pct
    #   Returns offensive rebound percentage
    #   @api public
    #   @example
    #     stat.oreb_pct #=> 0.025
    #   @return [Float, nil] offensive rebound percentage
    attribute :oreb_pct, Shale::Type::Float

    # @!attribute [rw] dreb_pct
    #   Returns defensive rebound percentage
    #   @api public
    #   @example
    #     stat.dreb_pct #=> 0.112
    #   @return [Float, nil] defensive rebound percentage
    attribute :dreb_pct, Shale::Type::Float

    # @!attribute [rw] usg_pct
    #   Returns usage percentage
    #   @api public
    #   @example
    #     stat.usg_pct #=> 0.298
    #   @return [Float, nil] usage percentage
    attribute :usg_pct, Shale::Type::Float

    # @!attribute [rw] ts_pct
    #   Returns true shooting percentage
    #   @api public
    #   @example
    #     stat.ts_pct #=> 0.621
    #   @return [Float, nil] true shooting percentage
    attribute :ts_pct, Shale::Type::Float

    # @!attribute [rw] ast_pct
    #   Returns assist percentage
    #   @api public
    #   @example
    #     stat.ast_pct #=> 0.312
    #   @return [Float, nil] assist percentage
    attribute :ast_pct, Shale::Type::Float

    # Returns the player
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player id=201939 ...>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns the team
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team id=1610612744 ...>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end
end
