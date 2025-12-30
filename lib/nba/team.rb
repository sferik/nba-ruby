require "equalizer"
require "shale"
require_relative "conference"
require_relative "division"

module NBA
  # Represents an NBA team
  class Team < Shale::Mapper
    include Equalizer.new(:id)

    # Team ID constants for all 30 NBA teams
    ATL = 1_610_612_737
    BOS = 1_610_612_738
    BKN = 1_610_612_751
    CHA = 1_610_612_766
    CHI = 1_610_612_741
    CLE = 1_610_612_739
    DAL = 1_610_612_742
    DEN = 1_610_612_743
    DET = 1_610_612_765
    GSW = 1_610_612_744
    HOU = 1_610_612_745
    IND = 1_610_612_754
    LAC = 1_610_612_746
    LAL = 1_610_612_747
    MEM = 1_610_612_763
    MIA = 1_610_612_748
    MIL = 1_610_612_749
    MIN = 1_610_612_750
    NOP = 1_610_612_740
    NYK = 1_610_612_752
    OKC = 1_610_612_760
    ORL = 1_610_612_753
    PHI = 1_610_612_755
    PHX = 1_610_612_756
    POR = 1_610_612_757
    SAC = 1_610_612_758
    SAS = 1_610_612_759
    TOR = 1_610_612_761
    UTA = 1_610_612_762
    WAS = 1_610_612_764

    # @!attribute [rw] id
    #   Returns the unique identifier for the team
    #   @api public
    #   @example
    #     team.id #=> 1610612747
    #   @return [Integer] the unique identifier for the team
    attribute :id, Shale::Type::Integer

    # @!attribute [rw] name
    #   Returns the team name
    #   @api public
    #   @example
    #     team.name #=> "Los Angeles Lakers"
    #   @return [String] the team name
    attribute :name, Shale::Type::String

    # @!attribute [rw] full_name
    #   Returns the team's full name
    #   @api public
    #   @example
    #     team.full_name #=> "Los Angeles Lakers"
    #   @return [String] the team's full name
    attribute :full_name, Shale::Type::String

    # @!attribute [rw] abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     team.abbreviation #=> "LAL"
    #   @return [String] the team abbreviation
    attribute :abbreviation, Shale::Type::String

    # @!attribute [rw] nickname
    #   Returns the team nickname
    #   @api public
    #   @example
    #     team.nickname #=> "Lakers"
    #   @return [String] the team nickname
    attribute :nickname, Shale::Type::String

    # @!attribute [rw] city
    #   Returns the team's city
    #   @api public
    #   @example
    #     team.city #=> "Los Angeles"
    #   @return [String] the team's city
    attribute :city, Shale::Type::String

    # @!attribute [rw] state
    #   Returns the team's state
    #   @api public
    #   @example
    #     team.state #=> "California"
    #   @return [String] the team's state
    attribute :state, Shale::Type::String

    # @!attribute [rw] year_founded
    #   Returns the year the team was founded
    #   @api public
    #   @example
    #     team.year_founded #=> 1947
    #   @return [Integer] the year the team was founded
    attribute :year_founded, Shale::Type::Integer

    # @!attribute [rw] conference
    #   Returns the team's conference
    #   @api public
    #   @example
    #     team.conference #=> #<NBA::Conference>
    #   @return [Conference] the team's conference
    attribute :conference, Conference

    # @!attribute [rw] division
    #   Returns the team's division
    #   @api public
    #   @example
    #     team.division #=> #<NBA::Division>
    #   @return [Division] the team's division
    attribute :division, Division

    json do
      map "id", to: :id
      map "name", to: :name
      map "full_name", to: :full_name
      map "fullName", to: :full_name
      map "abbreviation", to: :abbreviation
      map "nickname", to: :nickname
      map "city", to: :city
      map "state", to: :state
      map "year_founded", to: :year_founded
      map "yearFounded", to: :year_founded
      map "conference", to: :conference
      map "division", to: :division
    end
  end
end
