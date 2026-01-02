module NBA
  # Represents franchise history data
  class Franchise < Shale::Mapper
    include Equalizer.new(:team_id)

    # @!attribute [rw] league_id
    #   Returns the league ID
    #   @api public
    #   @example
    #     franchise.league_id #=> "00"
    #   @return [String] the league ID
    attribute :league_id, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     franchise.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_city
    #   Returns the team city
    #   @api public
    #   @example
    #     franchise.team_city #=> "Golden State"
    #   @return [String] the team city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     franchise.team_name #=> "Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] start_year
    #   Returns the franchise start year
    #   @api public
    #   @example
    #     franchise.start_year #=> 1946
    #   @return [Integer] the start year
    attribute :start_year, Shale::Type::Integer

    # @!attribute [rw] end_year
    #   Returns the franchise end year
    #   @api public
    #   @example
    #     franchise.end_year #=> 2024
    #   @return [Integer] the end year
    attribute :end_year, Shale::Type::Integer

    # @!attribute [rw] years
    #   Returns the number of years the franchise has existed
    #   @api public
    #   @example
    #     franchise.years #=> 78
    #   @return [Integer] the number of years
    attribute :years, Shale::Type::Integer

    # @!attribute [rw] games
    #   Returns the total games played
    #   @api public
    #   @example
    #     franchise.games #=> 5832
    #   @return [Integer] the total games
    attribute :games, Shale::Type::Integer

    # @!attribute [rw] wins
    #   Returns the total wins
    #   @api public
    #   @example
    #     franchise.wins #=> 2980
    #   @return [Integer] the total wins
    attribute :wins, Shale::Type::Integer

    # @!attribute [rw] losses
    #   Returns the total losses
    #   @api public
    #   @example
    #     franchise.losses #=> 2852
    #   @return [Integer] the total losses
    attribute :losses, Shale::Type::Integer

    # @!attribute [rw] win_pct
    #   Returns the all-time win percentage
    #   @api public
    #   @example
    #     franchise.win_pct #=> 0.511
    #   @return [Float] the win percentage
    attribute :win_pct, Shale::Type::Float

    # @!attribute [rw] po_appearances
    #   Returns the number of playoff appearances
    #   @api public
    #   @example
    #     franchise.po_appearances #=> 35
    #   @return [Integer] the playoff appearances
    attribute :po_appearances, Shale::Type::Integer

    # @!attribute [rw] div_titles
    #   Returns the number of division titles
    #   @api public
    #   @example
    #     franchise.div_titles #=> 12
    #   @return [Integer] the division titles
    attribute :div_titles, Shale::Type::Integer

    # @!attribute [rw] conf_titles
    #   Returns the number of conference titles
    #   @api public
    #   @example
    #     franchise.conf_titles #=> 7
    #   @return [Integer] the conference titles
    attribute :conf_titles, Shale::Type::Integer

    # @!attribute [rw] league_titles
    #   Returns the number of league/NBA championships
    #   @api public
    #   @example
    #     franchise.league_titles #=> 7
    #   @return [Integer] the league championships
    attribute :league_titles, Shale::Type::Integer

    # Returns the team object for this franchise
    #
    # @api public
    # @example
    #   franchise.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end
end
