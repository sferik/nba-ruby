module NBA
  # Represents a player from the player index endpoint
  #
  # @api public
  class PlayerIndexEntry < Shale::Mapper
    include Equalizer.new(:id)

    # @!attribute [rw] id
    #   Returns the player ID
    #   @api public
    #   @example
    #     entry.id #=> 201939
    #   @return [Integer] the player ID
    attribute :id, Shale::Type::Integer

    # @!attribute [rw] last_name
    #   Returns the player's last name
    #   @api public
    #   @example
    #     entry.last_name #=> "Curry"
    #   @return [String] the last name
    attribute :last_name, Shale::Type::String

    # @!attribute [rw] first_name
    #   Returns the player's first name
    #   @api public
    #   @example
    #     entry.first_name #=> "Stephen"
    #   @return [String] the first name
    attribute :first_name, Shale::Type::String

    # @!attribute [rw] slug
    #   Returns the player's URL slug
    #   @api public
    #   @example
    #     entry.slug #=> "stephen-curry"
    #   @return [String] the slug
    attribute :slug, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     entry.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_slug
    #   Returns the team's URL slug
    #   @api public
    #   @example
    #     entry.team_slug #=> "warriors"
    #   @return [String] the team slug
    attribute :team_slug, Shale::Type::String

    # @!attribute [rw] team_city
    #   Returns the team's city
    #   @api public
    #   @example
    #     entry.team_city #=> "Golden State"
    #   @return [String] the team city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team's name
    #   @api public
    #   @example
    #     entry.team_name #=> "Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] team_abbreviation
    #   Returns the team's abbreviation
    #   @api public
    #   @example
    #     entry.team_abbreviation #=> "GSW"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] jersey_number
    #   Returns the player's jersey number
    #   @api public
    #   @example
    #     entry.jersey_number #=> "30"
    #   @return [String] the jersey number
    attribute :jersey_number, Shale::Type::String

    # @!attribute [rw] position
    #   Returns the player's position
    #   @api public
    #   @example
    #     entry.position #=> "G"
    #   @return [String] the position
    attribute :position, Shale::Type::String

    # @!attribute [rw] height
    #   Returns the player's height
    #   @api public
    #   @example
    #     entry.height #=> "6-2"
    #   @return [String] the height
    attribute :height, Shale::Type::String

    # @!attribute [rw] weight
    #   Returns the player's weight in pounds
    #   @api public
    #   @example
    #     entry.weight #=> 185
    #   @return [Integer] the weight
    attribute :weight, Shale::Type::Integer

    # @!attribute [rw] college
    #   Returns the player's college
    #   @api public
    #   @example
    #     entry.college #=> "Davidson"
    #   @return [String] the college
    attribute :college, Shale::Type::String

    # @!attribute [rw] country
    #   Returns the player's country
    #   @api public
    #   @example
    #     entry.country #=> "USA"
    #   @return [String] the country
    attribute :country, Shale::Type::String

    # @!attribute [rw] draft_year
    #   Returns the player's draft year
    #   @api public
    #   @example
    #     entry.draft_year #=> 2009
    #   @return [Integer] the draft year
    attribute :draft_year, Shale::Type::Integer

    # @!attribute [rw] draft_round
    #   Returns the player's draft round
    #   @api public
    #   @example
    #     entry.draft_round #=> 1
    #   @return [Integer] the draft round
    attribute :draft_round, Shale::Type::Integer

    # @!attribute [rw] draft_number
    #   Returns the player's draft pick number
    #   @api public
    #   @example
    #     entry.draft_number #=> 7
    #   @return [Integer] the draft number
    attribute :draft_number, Shale::Type::Integer

    # @!attribute [rw] roster_status
    #   Returns the player's roster status
    #   @api public
    #   @example
    #     entry.roster_status #=> 1
    #   @return [Integer] the roster status
    attribute :roster_status, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns career points per game
    #   @api public
    #   @example
    #     entry.pts #=> 24.8
    #   @return [Float] points per game
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns career rebounds per game
    #   @api public
    #   @example
    #     entry.reb #=> 4.7
    #   @return [Float] rebounds per game
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns career assists per game
    #   @api public
    #   @example
    #     entry.ast #=> 6.5
    #   @return [Float] assists per game
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] stats_timeframe
    #   Returns the stats timeframe
    #   @api public
    #   @example
    #     entry.stats_timeframe #=> "Season"
    #   @return [String] the stats timeframe
    attribute :stats_timeframe, Shale::Type::String

    # @!attribute [rw] from_year
    #   Returns the first year played
    #   @api public
    #   @example
    #     entry.from_year #=> 2009
    #   @return [Integer] the first year
    attribute :from_year, Shale::Type::Integer

    # @!attribute [rw] to_year
    #   Returns the last year played
    #   @api public
    #   @example
    #     entry.to_year #=> 2024
    #   @return [Integer] the last year
    attribute :to_year, Shale::Type::Integer

    # @!attribute [rw] is_defunct
    #   Returns whether the player's team is defunct
    #   @api public
    #   @example
    #     entry.is_defunct #=> 0
    #   @return [Integer] defunct flag (0 or 1)
    attribute :is_defunct, Shale::Type::Integer

    # Returns the player's full name
    #
    # @api public
    # @example
    #   entry.full_name #=> "Stephen Curry"
    # @return [String] the full name
    def full_name
      "#{first_name} #{last_name}".strip
    end

    # Returns whether the player is currently on a roster
    #
    # @api public
    # @example
    #   entry.active? #=> true
    # @return [Boolean] true if on a roster
    def active?
      roster_status.eql?(1)
    end

    # Returns whether the player's team is defunct
    #
    # @api public
    # @example
    #   entry.defunct? #=> false
    # @return [Boolean] true if team is defunct
    def defunct?
      is_defunct.eql?(1)
    end

    # Returns the player object
    #
    # @api public
    # @example
    #   entry.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(id)
    end

    # Returns the team object
    #
    # @api public
    # @example
    #   entry.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end
end
