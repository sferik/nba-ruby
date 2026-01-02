require "equalizer"
require "shale"

module NBA
  # Represents a team's historical record
  class TeamHistoricalRecord < Shale::Mapper
    include Equalizer.new(:team_id, :season_id)

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     record.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] city
    #   Returns the team city
    #   @api public
    #   @example
    #     record.city #=> "Golden State"
    #   @return [String] the city
    attribute :city, Shale::Type::String

    # @!attribute [rw] nickname
    #   Returns the team nickname
    #   @api public
    #   @example
    #     record.nickname #=> "Warriors"
    #   @return [String] the nickname
    attribute :nickname, Shale::Type::String

    # @!attribute [rw] season_id
    #   Returns the season ID
    #   @api public
    #   @example
    #     record.season_id #=> "22024"
    #   @return [String] the season ID
    attribute :season_id, Shale::Type::String

    # @!attribute [rw] year
    #   Returns the year
    #   @api public
    #   @example
    #     record.year #=> 2024
    #   @return [Integer] the year
    attribute :year, Shale::Type::Integer

    # @!attribute [rw] wins
    #   Returns the number of wins
    #   @api public
    #   @example
    #     record.wins #=> 46
    #   @return [Integer] the wins
    attribute :wins, Shale::Type::Integer

    # @!attribute [rw] losses
    #   Returns the number of losses
    #   @api public
    #   @example
    #     record.losses #=> 36
    #   @return [Integer] the losses
    attribute :losses, Shale::Type::Integer

    # @!attribute [rw] win_pct
    #   Returns the win percentage
    #   @api public
    #   @example
    #     record.win_pct #=> 0.561
    #   @return [Float] the win percentage
    attribute :win_pct, Shale::Type::Float

    # @!attribute [rw] conf_rank
    #   Returns the conference rank
    #   @api public
    #   @example
    #     record.conf_rank #=> 10
    #   @return [Integer] the conference rank
    attribute :conf_rank, Shale::Type::Integer

    # @!attribute [rw] div_rank
    #   Returns the division rank
    #   @api public
    #   @example
    #     record.div_rank #=> 3
    #   @return [Integer] the division rank
    attribute :div_rank, Shale::Type::Integer

    # @!attribute [rw] po_wins
    #   Returns playoff wins
    #   @api public
    #   @example
    #     record.po_wins #=> 0
    #   @return [Integer] the playoff wins
    attribute :po_wins, Shale::Type::Integer

    # @!attribute [rw] po_losses
    #   Returns playoff losses
    #   @api public
    #   @example
    #     record.po_losses #=> 0
    #   @return [Integer] the playoff losses
    attribute :po_losses, Shale::Type::Integer

    # @!attribute [rw] conf_count
    #   Returns conference titles
    #   @api public
    #   @example
    #     record.conf_count #=> 0
    #   @return [Integer] the conference titles
    attribute :conf_count, Shale::Type::Integer

    # @!attribute [rw] div_count
    #   Returns division titles
    #   @api public
    #   @example
    #     record.div_count #=> 0
    #   @return [Integer] the division titles
    attribute :div_count, Shale::Type::Integer

    # @!attribute [rw] nba_finals_appearance
    #   Returns NBA Finals appearances
    #   @api public
    #   @example
    #     record.nba_finals_appearance #=> "N/A"
    #   @return [String] the Finals appearances
    attribute :nba_finals_appearance, Shale::Type::String

    # Returns the team object
    #
    # @api public
    # @example
    #   record.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end
end
