require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

module NBA
  # Represents player hustle statistics
  class PlayerHustleStat < Shale::Mapper
    include Equalizer.new(:player_id)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     stat.player_name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     stat.team_abbreviation #=> "GSW"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] age
    #   Returns the player's age
    #   @api public
    #   @example
    #     stat.age #=> 28
    #   @return [Integer] the age
    attribute :age, Shale::Type::Integer

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 82
    #   @example
    #     stat.gp #=> 82
    #   @return [Integer] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] w
    #   Returns wins
    #   @api public
    #   @example
    #     stat.w #=> 55
    #   @example
    #     stat.w #=> 55
    #   @return [Integer] wins
    attribute :w, Shale::Type::Integer

    # @!attribute [rw] l
    #   Returns losses
    #   @api public
    #   @example
    #     stat.l #=> 27
    #   @return [Integer] losses
    attribute :l, Shale::Type::Integer

    # @!attribute [rw] min
    #   Returns minutes per game
    #   @api public
    #   @example
    #     stat.min #=> 34.2
    #   @return [Float] minutes
    attribute :min, Shale::Type::Float

    # @!attribute [rw] contested_shots
    #   Returns contested shots per game
    #   @api public
    #   @example
    #     stat.contested_shots #=> 5.3
    #   @return [Float] contested shots
    attribute :contested_shots, Shale::Type::Float

    # @!attribute [rw] contested_shots_2pt
    #   Returns contested 2-point shots per game
    #   @api public
    #   @example
    #     stat.contested_shots_2pt #=> 3.1
    #   @return [Float] contested 2-point shots
    attribute :contested_shots_2pt, Shale::Type::Float

    # @!attribute [rw] contested_shots_3pt
    #   Returns contested 3-point shots per game
    #   @api public
    #   @example
    #     stat.contested_shots_3pt #=> 2.2
    #   @return [Float] contested 3-point shots
    attribute :contested_shots_3pt, Shale::Type::Float

    # @!attribute [rw] deflections
    #   Returns deflections per game
    #   @api public
    #   @example
    #     stat.deflections #=> 3.5
    #   @return [Float] deflections
    attribute :deflections, Shale::Type::Float

    # @!attribute [rw] charges_drawn
    #   Returns charges drawn per game
    #   @api public
    #   @example
    #     stat.charges_drawn #=> 0.3
    #   @return [Float] charges drawn
    attribute :charges_drawn, Shale::Type::Float

    # @!attribute [rw] screen_assists
    #   Returns screen assists per game
    #   @api public
    #   @example
    #     stat.screen_assists #=> 1.8
    #   @return [Float] screen assists
    attribute :screen_assists, Shale::Type::Float

    # @!attribute [rw] screen_ast_pts
    #   Returns points from screen assists per game
    #   @api public
    #   @example
    #     stat.screen_ast_pts #=> 4.2
    #   @return [Float] screen assist points
    attribute :screen_ast_pts, Shale::Type::Float

    # @!attribute [rw] loose_balls_recovered
    #   Returns loose balls recovered per game
    #   @api public
    #   @example
    #     stat.loose_balls_recovered #=> 1.5
    #   @return [Float] loose balls recovered
    attribute :loose_balls_recovered, Shale::Type::Float

    # @!attribute [rw] off_loose_balls_recovered
    #   Returns offensive loose balls recovered per game
    #   @api public
    #   @example
    #     stat.off_loose_balls_recovered #=> 0.7
    #   @return [Float] offensive loose balls recovered
    attribute :off_loose_balls_recovered, Shale::Type::Float

    # @!attribute [rw] def_loose_balls_recovered
    #   Returns defensive loose balls recovered per game
    #   @api public
    #   @example
    #     stat.def_loose_balls_recovered #=> 0.8
    #   @return [Float] defensive loose balls recovered
    attribute :def_loose_balls_recovered, Shale::Type::Float

    # @!attribute [rw] box_outs
    #   Returns box outs per game
    #   @api public
    #   @example
    #     stat.box_outs #=> 2.3
    #   @return [Float] box outs
    attribute :box_outs, Shale::Type::Float

    # @!attribute [rw] off_box_outs
    #   Returns offensive box outs per game
    #   @api public
    #   @example
    #     stat.off_box_outs #=> 0.5
    #   @return [Float] offensive box outs
    attribute :off_box_outs, Shale::Type::Float

    # @!attribute [rw] def_box_outs
    #   Returns defensive box outs per game
    #   @api public
    #   @example
    #     stat.def_box_outs #=> 1.8
    #   @return [Float] defensive box outs
    attribute :def_box_outs, Shale::Type::Float

    # Returns the player object
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
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

  # Represents team hustle statistics
  class TeamHustleStat < Shale::Mapper
    include Equalizer.new(:team_id)

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @return [Integer] the team ID
    #   @example
    #     stat.team_id #=> 1610612744
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     stat.team_name #=> "Golden State Warriors"
    #   @return [String] the team name
    #   @example
    #     stat.team_name #=> "Golden State Warriors"
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 82
    #   @return [Integer] games played
    #   @example
    #     stat.gp #=> 82
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] w
    #   Returns wins
    #   @api public
    #   @example
    #     stat.w #=> 55
    #   @return [Integer] wins
    #   @example
    #     stat.w #=> 55
    attribute :w, Shale::Type::Integer

    # @!attribute [rw] l
    #   Returns losses
    #   @api public
    #   @example
    #     stat.l #=> 27
    #   @return [Integer] losses
    attribute :l, Shale::Type::Integer

    # @!attribute [rw] min
    #   Returns minutes per game
    #   @api public
    #   @example
    #     stat.min #=> 34.2
    #   @return [Float] minutes
    attribute :min, Shale::Type::Float

    # @!attribute [rw] contested_shots
    #   Returns contested shots per game
    #   @api public
    #   @example
    #     stat.contested_shots #=> 5.3
    #   @return [Float] contested shots
    attribute :contested_shots, Shale::Type::Float

    # @!attribute [rw] contested_shots_2pt
    #   Returns contested 2-point shots per game
    #   @api public
    #   @example
    #     stat.contested_shots_2pt #=> 3.1
    #   @return [Float] contested 2-point shots
    attribute :contested_shots_2pt, Shale::Type::Float

    # @!attribute [rw] contested_shots_3pt
    #   Returns contested 3-point shots per game
    #   @api public
    #   @example
    #     stat.contested_shots_3pt #=> 2.2
    #   @return [Float] contested 3-point shots
    attribute :contested_shots_3pt, Shale::Type::Float

    # @!attribute [rw] deflections
    #   Returns deflections per game
    #   @api public
    #   @example
    #     stat.deflections #=> 3.5
    #   @return [Float] deflections
    attribute :deflections, Shale::Type::Float

    # @!attribute [rw] charges_drawn
    #   Returns charges drawn per game
    #   @api public
    #   @example
    #     stat.charges_drawn #=> 0.3
    #   @return [Float] charges drawn
    attribute :charges_drawn, Shale::Type::Float

    # @!attribute [rw] screen_assists
    #   Returns screen assists per game
    #   @api public
    #   @example
    #     stat.screen_assists #=> 1.8
    #   @return [Float] screen assists
    attribute :screen_assists, Shale::Type::Float

    # @!attribute [rw] screen_ast_pts
    #   Returns points from screen assists per game
    #   @api public
    #   @example
    #     stat.screen_ast_pts #=> 4.2
    #   @return [Float] screen assist points
    attribute :screen_ast_pts, Shale::Type::Float

    # @!attribute [rw] loose_balls_recovered
    #   Returns loose balls recovered per game
    #   @api public
    #   @example
    #     stat.loose_balls_recovered #=> 1.5
    #   @return [Float] loose balls recovered
    attribute :loose_balls_recovered, Shale::Type::Float

    # @!attribute [rw] off_loose_balls_recovered
    #   Returns offensive loose balls recovered per game
    #   @api public
    #   @example
    #     stat.off_loose_balls_recovered #=> 0.7
    #   @return [Float] offensive loose balls recovered
    attribute :off_loose_balls_recovered, Shale::Type::Float

    # @!attribute [rw] def_loose_balls_recovered
    #   Returns defensive loose balls recovered per game
    #   @api public
    #   @example
    #     stat.def_loose_balls_recovered #=> 0.8
    #   @return [Float] defensive loose balls recovered
    attribute :def_loose_balls_recovered, Shale::Type::Float

    # @!attribute [rw] box_outs
    #   Returns box outs per game
    #   @api public
    #   @example
    #     stat.box_outs #=> 2.3
    #   @return [Float] box outs
    attribute :box_outs, Shale::Type::Float

    # @!attribute [rw] off_box_outs
    #   Returns offensive box outs per game
    #   @api public
    #   @example
    #     stat.off_box_outs #=> 0.5
    #   @return [Float] offensive box outs
    attribute :off_box_outs, Shale::Type::Float

    # @!attribute [rw] def_box_outs
    #   Returns defensive box outs per game
    #   @api public
    #   @example
    #     stat.def_box_outs #=> 1.8
    #   @return [Float] defensive box outs
    attribute :def_box_outs, Shale::Type::Float

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

  # Provides methods to retrieve league hustle statistics
  module LeagueHustleStats
    # Result set name for player hustle stats
    # @return [String] the result set name
    PLAYER_HUSTLE_STATS = "PlayerHustleStats".freeze

    # Result set name for team hustle stats
    # @return [String] the result set name
    TEAM_HUSTLE_STATS = "TeamHustleStats".freeze

    # Season type constant for regular season
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Season type constant for playoffs
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Per mode constant for per game stats
    # @return [String] the per mode
    PER_GAME = "PerGame".freeze

    # Per mode constant for totals
    # @return [String] the per mode
    TOTALS = "Totals".freeze

    # Retrieves hustle stats for all players
    #
    # @api public
    # @example
    #   stats = NBA::LeagueHustleStats.player_stats(season: 2024)
    #   stats.each { |s| puts "#{s.player_name}: #{s.deflections} deflections" }
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player hustle stats
    def self.player_stats(season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      path = build_path("leaguehustlestatsplayer", season, season_type, per_mode)
      response = client.get(path)
      parse_player_response(response)
    end

    # Retrieves hustle stats for all teams
    #
    # @api public
    # @example
    #   stats = NBA::LeagueHustleStats.team_stats(season: 2024)
    #   stats.each { |s| puts "#{s.team_name}: #{s.deflections} deflections" }
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team hustle stats
    def self.team_stats(season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      path = build_path("leaguehustlestatsteam", season, season_type, per_mode)
      response = client.get(path)
      parse_team_response(response)
    end

    # Builds the API path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(endpoint, season, season_type, per_mode)
      season_str = Utils.format_season(season)
      "#{endpoint}?LeagueID=00&Season=#{season_str}&SeasonType=#{season_type}&PerMode=#{per_mode}"
    end
    private_class_method :build_path

    # Parses the player API response
    #
    # @api private
    # @return [Collection] collection of player hustle stats
    def self.parse_player_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, "HustleStatsPlayer")
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_player_stat(headers, row) }
      Collection.new(stats)
    end
    private_class_method :parse_player_response

    # Parses the team API response
    #
    # @api private
    # @return [Collection] collection of team hustle stats
    def self.parse_team_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, "HustleStatsTeam")
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_team_stat(headers, row) }
      Collection.new(stats)
    end
    private_class_method :parse_team_response

    # Finds the result set in the response
    #
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data, name)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(name) }
    end
    private_class_method :find_result_set

    # Builds a PlayerHustleStat object from raw data
    #
    # @api private
    # @return [PlayerHustleStat] the player hustle stat object
    def self.build_player_stat(headers, row)
      data = headers.zip(row).to_h
      PlayerHustleStat.new(**player_attributes(data))
    end
    private_class_method :build_player_stat

    # Builds a TeamHustleStat object from raw data
    #
    # @api private
    # @return [TeamHustleStat] the team hustle stat object
    def self.build_team_stat(headers, row)
      data = headers.zip(row).to_h
      TeamHustleStat.new(**team_attributes(data))
    end
    private_class_method :build_team_stat

    # Extracts player attributes from data
    #
    # @api private
    # @return [Hash] player attributes
    def self.player_attributes(data)
      identity_player_attributes(data).merge(hustle_attributes(data))
    end
    private_class_method :player_attributes

    # Extracts team attributes from data
    #
    # @api private
    # @return [Hash] team attributes
    def self.team_attributes(data)
      identity_team_attributes(data).merge(hustle_attributes(data))
    end
    private_class_method :team_attributes

    # Extracts player identity attributes from data
    #
    # @api private
    # @return [Hash] identity attributes
    def self.identity_player_attributes(data)
      {player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       age: data.fetch("AGE", nil), gp: data.fetch("G", nil), w: data.fetch("W", nil), l: data.fetch("L", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :identity_player_attributes

    # Extracts team identity attributes from data
    #
    # @api private
    # @return [Hash] identity attributes
    def self.identity_team_attributes(data)
      {team_id: data.fetch("TEAM_ID", nil), team_name: data.fetch("TEAM_NAME", nil),
       gp: data.fetch("G", nil), w: data.fetch("W", nil), l: data.fetch("L", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :identity_team_attributes

    # Extracts hustle attributes from data
    #
    # @api private
    # @return [Hash] hustle attributes
    def self.hustle_attributes(data)
      {contested_shots: data.fetch("CONTESTED_SHOTS", nil), contested_shots_2pt: data.fetch("CONTESTED_SHOTS_2PT", nil),
       contested_shots_3pt: data.fetch("CONTESTED_SHOTS_3PT", nil), deflections: data.fetch("DEFLECTIONS", nil),
       charges_drawn: data.fetch("CHARGES_DRAWN", nil), screen_assists: data.fetch("SCREEN_ASSISTS", nil),
       screen_ast_pts: data.fetch("SCREEN_AST_PTS", nil), loose_balls_recovered: data.fetch("LOOSE_BALLS_RECOVERED", nil),
       off_loose_balls_recovered: data.fetch("OFF_LOOSE_BALLS_RECOVERED", nil),
       def_loose_balls_recovered: data.fetch("DEF_LOOSE_BALLS_RECOVERED", nil),
       box_outs: data.fetch("BOX_OUTS", nil), off_box_outs: data.fetch("OFF_BOX_OUTS", nil), def_box_outs: data.fetch("DEF_BOX_OUTS", nil)}
    end
    private_class_method :hustle_attributes
  end
end
