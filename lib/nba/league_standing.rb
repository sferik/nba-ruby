module NBA
  # Represents a team's standing with extended information
  class LeagueStanding < Shale::Mapper
    include Equalizer.new(:team_id, :season_id)

    # @!attribute [rw] league_id
    #   Returns the league ID
    #   @api public
    #   @example
    #     standing.league_id #=> "00"
    #   @return [String] the league ID
    attribute :league_id, Shale::Type::String

    # @!attribute [rw] season_id
    #   Returns the season ID
    #   @api public
    #   @example
    #     standing.season_id #=> "22024"
    #   @return [String] the season ID
    attribute :season_id, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     standing.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_city
    #   Returns the team city
    #   @api public
    #   @example
    #     standing.team_city #=> "Golden State"
    #   @return [String] the team city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     standing.team_name #=> "Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] team_slug
    #   Returns the team slug
    #   @api public
    #   @example
    #     standing.team_slug #=> "warriors"
    #   @return [String] the team slug
    attribute :team_slug, Shale::Type::String

    # @!attribute [rw] conference
    #   Returns the conference
    #   @api public
    #   @example
    #     standing.conference #=> "West"
    #   @return [String] the conference
    attribute :conference, Shale::Type::String

    # @!attribute [rw] conference_record
    #   Returns the conference record
    #   @api public
    #   @example
    #     standing.conference_record #=> "30-22"
    #   @return [String] the conference record
    attribute :conference_record, Shale::Type::String

    # @!attribute [rw] playoff_rank
    #   Returns the playoff rank
    #   @api public
    #   @example
    #     standing.playoff_rank #=> 10
    #   @return [Integer] the playoff rank
    attribute :playoff_rank, Shale::Type::Integer

    # @!attribute [rw] clinch_indicator
    #   Returns the clinch indicator
    #   @api public
    #   @example
    #     standing.clinch_indicator #=> "x"
    #   @return [String] the clinch indicator
    attribute :clinch_indicator, Shale::Type::String

    # @!attribute [rw] division
    #   Returns the division
    #   @api public
    #   @example
    #     standing.division #=> "Pacific"
    #   @return [String] the division
    attribute :division, Shale::Type::String

    # @!attribute [rw] division_record
    #   Returns the division record
    #   @api public
    #   @example
    #     standing.division_record #=> "8-8"
    #   @return [String] the division record
    attribute :division_record, Shale::Type::String

    # @!attribute [rw] division_rank
    #   Returns the division rank
    #   @api public
    #   @example
    #     standing.division_rank #=> 3
    #   @return [Integer] the division rank
    attribute :division_rank, Shale::Type::Integer

    # @!attribute [rw] wins
    #   Returns the number of wins
    #   @api public
    #   @example
    #     standing.wins #=> 46
    #   @return [Integer] the wins
    attribute :wins, Shale::Type::Integer

    # @!attribute [rw] losses
    #   Returns the number of losses
    #   @api public
    #   @example
    #     standing.losses #=> 36
    #   @return [Integer] the losses
    attribute :losses, Shale::Type::Integer

    # @!attribute [rw] win_pct
    #   Returns the win percentage
    #   @api public
    #   @example
    #     standing.win_pct #=> 0.561
    #   @return [Float] the win percentage
    attribute :win_pct, Shale::Type::Float

    # @!attribute [rw] league_rank
    #   Returns the league rank
    #   @api public
    #   @example
    #     standing.league_rank #=> 15
    #   @return [Integer] the league rank
    attribute :league_rank, Shale::Type::Integer

    # @!attribute [rw] record
    #   Returns the full record string
    #   @api public
    #   @example
    #     standing.record #=> "46-36"
    #   @return [String] the record
    attribute :record, Shale::Type::String

    # @!attribute [rw] home_record
    #   Returns the home record
    #   @api public
    #   @example
    #     standing.home_record #=> "28-13"
    #   @return [String] the home record
    attribute :home_record, Shale::Type::String

    # @!attribute [rw] road_record
    #   Returns the road record
    #   @api public
    #   @example
    #     standing.road_record #=> "18-23"
    #   @return [String] the road record
    attribute :road_record, Shale::Type::String

    # @!attribute [rw] l10_record
    #   Returns the last 10 games record
    #   @api public
    #   @example
    #     standing.l10_record #=> "6-4"
    #   @return [String] the L10 record
    attribute :l10_record, Shale::Type::String

    # @!attribute [rw] long_win_streak
    #   Returns the longest win streak
    #   @api public
    #   @example
    #     standing.long_win_streak #=> 7
    #   @return [Integer] the longest win streak
    attribute :long_win_streak, Shale::Type::Integer

    # @!attribute [rw] long_loss_streak
    #   Returns the longest loss streak
    #   @api public
    #   @example
    #     standing.long_loss_streak #=> 4
    #   @return [Integer] the longest loss streak
    attribute :long_loss_streak, Shale::Type::Integer

    # @!attribute [rw] current_streak
    #   Returns the current streak
    #   @api public
    #   @example
    #     standing.current_streak #=> "W 2"
    #   @return [String] the current streak
    attribute :current_streak, Shale::Type::String

    # @!attribute [rw] conference_games_back
    #   Returns games back in the conference
    #   @api public
    #   @example
    #     standing.conference_games_back #=> 12.0
    #   @return [Float] the games back
    attribute :conference_games_back, Shale::Type::Float

    # @!attribute [rw] clinched_conference_title
    #   Returns if team clinched conference title
    #   @api public
    #   @example
    #     standing.clinched_conference_title #=> 0
    #   @return [Integer] 1 if clinched, 0 otherwise
    attribute :clinched_conference_title, Shale::Type::Integer

    # @!attribute [rw] clinched_playoff_birth
    #   Returns if team clinched playoff berth
    #   @api public
    #   @example
    #     standing.clinched_playoff_birth #=> 1
    #   @return [Integer] 1 if clinched, 0 otherwise
    attribute :clinched_playoff_birth, Shale::Type::Integer

    # @!attribute [rw] eliminated_conference
    #   Returns if team is eliminated from conference
    #   @api public
    #   @example
    #     standing.eliminated_conference #=> 0
    #   @return [Integer] 1 if eliminated, 0 otherwise
    attribute :eliminated_conference, Shale::Type::Integer

    # @!attribute [rw] points_pg
    #   Returns points per game
    #   @api public
    #   @example
    #     standing.points_pg #=> 118.7
    #   @return [Float] the points per game
    attribute :points_pg, Shale::Type::Float

    # @!attribute [rw] opp_points_pg
    #   Returns opponent points per game
    #   @api public
    #   @example
    #     standing.opp_points_pg #=> 117.2
    #   @return [Float] the opponent points per game
    attribute :opp_points_pg, Shale::Type::Float

    # @!attribute [rw] diff_points_pg
    #   Returns point differential per game
    #   @api public
    #   @example
    #     standing.diff_points_pg #=> 1.5
    #   @return [Float] the point differential
    attribute :diff_points_pg, Shale::Type::Float

    # Returns the team object
    #
    # @api public
    # @example
    #   standing.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns the full team name
    #
    # @api public
    # @example
    #   standing.full_name #=> "Golden State Warriors"
    # @return [String] the full name
    def full_name
      "#{team_city} #{team_name}".strip
    end

    # Returns whether the team made the playoffs
    #
    # @api public
    # @example
    #   standing.playoffs? #=> true
    # @return [Boolean] true if in playoffs
    def playoffs?
      clinched_playoff_birth.eql?(1)
    end
  end
end
