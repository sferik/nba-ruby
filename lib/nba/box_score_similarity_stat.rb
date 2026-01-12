module NBA
  # Represents a G League Alum box score similarity score
  class BoxScoreSimilarityStat < Shale::Mapper
    include Equalizer.new(:first_person_id, :second_person_id)

    # @!attribute [rw] first_person_id
    #   Returns the first player ID
    #   @api public
    #   @example
    #     stat.first_person_id #=> 201939
    #   @return [Integer] the first player ID
    attribute :first_person_id, Shale::Type::Integer

    # @!attribute [rw] second_person_id
    #   Returns the second player ID
    #   @api public
    #   @example
    #     stat.second_person_id #=> 203507
    #   @return [Integer] the second player ID
    attribute :second_person_id, Shale::Type::Integer

    # @!attribute [rw] second_person_name
    #   Returns the second player name
    #   @api public
    #   @example
    #     stat.second_person_name #=> "Giannis Antetokounmpo"
    #   @return [String] the second player name
    attribute :second_person_name, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612749
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] similarity_score
    #   Returns the similarity score between the two players
    #   @api public
    #   @example
    #     stat.similarity_score #=> 0.85
    #   @return [Float] the similarity score
    attribute :similarity_score, Shale::Type::Float

    # Returns the first player object
    #
    # @api public
    # @example
    #   stat.first_person #=> #<NBA::Player>
    # @return [Player, nil] the first player object
    def first_person
      Players.find(first_person_id)
    end

    # Returns the second player object
    #
    # @api public
    # @example
    #   stat.second_person #=> #<NBA::Player>
    # @return [Player, nil] the second player object
    def second_person
      Players.find(second_person_id)
    end

    # Returns the team object
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end
end
