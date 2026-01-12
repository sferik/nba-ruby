module NBA
  # Represents a player's award
  class Award < Shale::Mapper
    include Equalizer.new(:player_id, :description, :season)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     award.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] first_name
    #   Returns the player's first name
    #   @api public
    #   @example
    #     award.first_name #=> "Stephen"
    #   @return [String] the first name
    attribute :first_name, Shale::Type::String

    # @!attribute [rw] last_name
    #   Returns the player's last name
    #   @api public
    #   @example
    #     award.last_name #=> "Curry"
    #   @return [String] the last name
    attribute :last_name, Shale::Type::String

    # @!attribute [rw] team
    #   Returns the team name
    #   @api public
    #   @example
    #     award.team #=> "Golden State Warriors"
    #   @return [String] the team name
    attribute :team, Shale::Type::String

    # @!attribute [rw] description
    #   Returns the award description
    #   @api public
    #   @example
    #     award.description #=> "All-NBA"
    #   @return [String] the award description
    attribute :description, Shale::Type::String

    # @!attribute [rw] all_nba_team_number
    #   Returns the All-NBA team number (1st, 2nd, 3rd)
    #   @api public
    #   @example
    #     award.all_nba_team_number #=> 1
    #   @return [Integer] the team number
    attribute :all_nba_team_number, Shale::Type::Integer

    # @!attribute [rw] season
    #   Returns the season
    #   @api public
    #   @example
    #     award.season #=> "2023-24"
    #   @return [String] the season
    attribute :season, Shale::Type::String

    # @!attribute [rw] month
    #   Returns the month (for monthly awards)
    #   @api public
    #   @example
    #     award.month #=> 11
    #   @return [Integer] the month
    attribute :month, Shale::Type::Integer

    # @!attribute [rw] week
    #   Returns the week (for weekly awards)
    #   @api public
    #   @example
    #     award.week #=> 5
    #   @return [Integer] the week
    attribute :week, Shale::Type::Integer

    # @!attribute [rw] conference
    #   Returns the conference
    #   @api public
    #   @example
    #     award.conference #=> "West"
    #   @return [String] the conference
    attribute :conference, Shale::Type::String

    # @!attribute [rw] award_type
    #   Returns the award type
    #   @api public
    #   @example
    #     award.award_type #=> "All-Star"
    #   @return [String] the award type
    attribute :award_type, Shale::Type::String

    # @!attribute [rw] subtype1
    #   Returns the award subtype 1
    #   @api public
    #   @example
    #     award.subtype1 #=> "Guard"
    #   @return [String] the subtype
    attribute :subtype1, Shale::Type::String

    # @!attribute [rw] subtype2
    #   Returns the award subtype 2
    #   @api public
    #   @example
    #     award.subtype2 #=> "Starter"
    #   @return [String] the subtype
    attribute :subtype2, Shale::Type::String

    # @!attribute [rw] subtype3
    #   Returns the award subtype 3
    #   @api public
    #   @example
    #     award.subtype3 #=> nil
    #   @return [String] the subtype
    attribute :subtype3, Shale::Type::String

    # Returns the player object
    #
    # @api public
    # @example
    #   award.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end
  end
end
