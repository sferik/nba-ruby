require "equalizer"
require "shale"
require_relative "conference"
require_relative "division"

module NBA
  # Represents an NBA team
  class Team < Shale::Mapper
    include Equalizer.new(:id)

    # @!group Team ID Constants

    # Atlanta Hawks team ID
    # @return [Integer] the team ID
    ATL = 1_610_612_737
    # Boston Celtics team ID
    # @return [Integer] the team ID
    BOS = 1_610_612_738
    # Brooklyn Nets team ID
    # @return [Integer] the team ID
    BKN = 1_610_612_751
    # Charlotte Hornets team ID
    # @return [Integer] the team ID
    CHA = 1_610_612_766
    # Chicago Bulls team ID
    # @return [Integer] the team ID
    CHI = 1_610_612_741
    # Cleveland Cavaliers team ID
    # @return [Integer] the team ID
    CLE = 1_610_612_739
    # Dallas Mavericks team ID
    # @return [Integer] the team ID
    DAL = 1_610_612_742
    # Denver Nuggets team ID
    # @return [Integer] the team ID
    DEN = 1_610_612_743
    # Detroit Pistons team ID
    # @return [Integer] the team ID
    DET = 1_610_612_765
    # Golden State Warriors team ID
    # @return [Integer] the team ID
    GSW = 1_610_612_744
    # Houston Rockets team ID
    # @return [Integer] the team ID
    HOU = 1_610_612_745
    # Indiana Pacers team ID
    # @return [Integer] the team ID
    IND = 1_610_612_754
    # Los Angeles Clippers team ID
    # @return [Integer] the team ID
    LAC = 1_610_612_746
    # Los Angeles Lakers team ID
    # @return [Integer] the team ID
    LAL = 1_610_612_747
    # Memphis Grizzlies team ID
    # @return [Integer] the team ID
    MEM = 1_610_612_763
    # Miami Heat team ID
    # @return [Integer] the team ID
    MIA = 1_610_612_748
    # Milwaukee Bucks team ID
    # @return [Integer] the team ID
    MIL = 1_610_612_749
    # Minnesota Timberwolves team ID
    # @return [Integer] the team ID
    MIN = 1_610_612_750
    # New Orleans Pelicans team ID
    # @return [Integer] the team ID
    NOP = 1_610_612_740
    # New York Knicks team ID
    # @return [Integer] the team ID
    NYK = 1_610_612_752
    # Oklahoma City Thunder team ID
    # @return [Integer] the team ID
    OKC = 1_610_612_760
    # Orlando Magic team ID
    # @return [Integer] the team ID
    ORL = 1_610_612_753
    # Philadelphia 76ers team ID
    # @return [Integer] the team ID
    PHI = 1_610_612_755
    # Phoenix Suns team ID
    # @return [Integer] the team ID
    PHX = 1_610_612_756
    # Portland Trail Blazers team ID
    # @return [Integer] the team ID
    POR = 1_610_612_757
    # Sacramento Kings team ID
    # @return [Integer] the team ID
    SAC = 1_610_612_758
    # San Antonio Spurs team ID
    # @return [Integer] the team ID
    SAS = 1_610_612_759
    # Toronto Raptors team ID
    # @return [Integer] the team ID
    TOR = 1_610_612_761
    # Utah Jazz team ID
    # @return [Integer] the team ID
    UTA = 1_610_612_762
    # Washington Wizards team ID
    # @return [Integer] the team ID
    WAS = 1_610_612_764

    # @!endgroup

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

    # Returns the team's home arena
    #
    # @api public
    # @example
    #   team.arena #=> "Chase Center"
    # @return [String, nil] the arena name
    def arena
      TeamDetails.find(team: id)&.arena
    end
  end
end
