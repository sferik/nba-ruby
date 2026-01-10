require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

module NBA
  # Represents a player's league dashboard statistics
  class LeagueDashPlayerStat < Shale::Mapper
    include Equalizer.new(:player_id, :season_id)

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
    #     stat.age #=> 36
    #   @return [Integer] the age
    attribute :age, Shale::Type::Integer

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 72
    #   @return [Integer] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] w
    #   Returns wins
    #   @api public
    #   @example
    #     stat.w #=> 46
    #   @return [Integer] wins
    attribute :w, Shale::Type::Integer

    # @!attribute [rw] l
    #   Returns losses
    #   @api public
    #   @example
    #     stat.l #=> 26
    #   @return [Integer] losses
    attribute :l, Shale::Type::Integer

    # @!attribute [rw] w_pct
    #   Returns win percentage
    #   @api public
    #   @example
    #     stat.w_pct #=> 0.639
    #   @return [Float] win percentage
    attribute :w_pct, Shale::Type::Float

    # @!attribute [rw] min
    #   Returns minutes per game
    #   @api public
    #   @example
    #     stat.min #=> 34.7
    #   @return [Float] minutes per game
    attribute :min, Shale::Type::Float

    # @!attribute [rw] fgm
    #   Returns field goals made per game
    #   @api public
    #   @example
    #     stat.fgm #=> 9.2
    #   @return [Float] field goals made
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns field goals attempted per game
    #   @api public
    #   @example
    #     stat.fga #=> 19.4
    #   @return [Float] field goals attempted
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.474
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made per game
    #   @api public
    #   @example
    #     stat.fg3m #=> 4.8
    #   @return [Float] three-pointers made
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted per game
    #   @api public
    #   @example
    #     stat.fg3a #=> 11.7
    #   @return [Float] three-pointers attempted
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     stat.fg3_pct #=> 0.410
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made per game
    #   @api public
    #   @example
    #     stat.ftm #=> 5.1
    #   @return [Float] free throws made
    attribute :ftm, Shale::Type::Float

    # @!attribute [rw] fta
    #   Returns free throws attempted per game
    #   @api public
    #   @example
    #     stat.fta #=> 5.6
    #   @return [Float] free throws attempted
    attribute :fta, Shale::Type::Float

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stat.ft_pct #=> 0.911
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds per game
    #   @api public
    #   @example
    #     stat.oreb #=> 0.7
    #   @return [Float] offensive rebounds
    attribute :oreb, Shale::Type::Float

    # @!attribute [rw] dreb
    #   Returns defensive rebounds per game
    #   @api public
    #   @example
    #     stat.dreb #=> 4.9
    #   @return [Float] defensive rebounds
    attribute :dreb, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns total rebounds per game
    #   @api public
    #   @example
    #     stat.reb #=> 5.6
    #   @return [Float] total rebounds
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists per game
    #   @api public
    #   @example
    #     stat.ast #=> 6.3
    #   @return [Float] assists
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns turnovers per game
    #   @api public
    #   @example
    #     stat.tov #=> 2.8
    #   @return [Float] turnovers
    attribute :tov, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns steals per game
    #   @api public
    #   @example
    #     stat.stl #=> 1.3
    #   @return [Float] steals
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns blocks per game
    #   @api public
    #   @example
    #     stat.blk #=> 0.4
    #   @return [Float] blocks
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] blka
    #   Returns blocked attempts per game
    #   @api public
    #   @example
    #     stat.blka #=> 0.2
    #   @return [Float] blocked attempts
    attribute :blka, Shale::Type::Float

    # @!attribute [rw] pf
    #   Returns personal fouls per game
    #   @api public
    #   @example
    #     stat.pf #=> 1.8
    #   @return [Float] personal fouls
    attribute :pf, Shale::Type::Float

    # @!attribute [rw] pfd
    #   Returns personal fouls drawn per game
    #   @api public
    #   @example
    #     stat.pfd #=> 2.7
    #   @return [Float] personal fouls drawn
    attribute :pfd, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points per game
    #   @api public
    #   @example
    #     stat.pts #=> 28.4
    #   @return [Float] points
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] plus_minus
    #   Returns plus/minus per game
    #   @api public
    #   @example
    #     stat.plus_minus #=> 7.1
    #   @return [Float] plus/minus
    attribute :plus_minus, Shale::Type::Float

    # @!attribute [rw] nba_fantasy_pts
    #   Returns fantasy points per game
    #   @api public
    #   @example
    #     stat.nba_fantasy_pts #=> 52.3
    #   @return [Float] fantasy points
    attribute :nba_fantasy_pts, Shale::Type::Float

    # @!attribute [rw] dd2
    #   Returns double-doubles
    #   @api public
    #   @example
    #     stat.dd2 #=> 15
    #   @return [Integer] double-doubles
    attribute :dd2, Shale::Type::Integer

    # @!attribute [rw] td3
    #   Returns triple-doubles
    #   @api public
    #   @example
    #     stat.td3 #=> 3
    #   @return [Integer] triple-doubles
    attribute :td3, Shale::Type::Integer

    # @!attribute [rw] season_id
    #   Returns the season ID
    #   @api public
    #   @example
    #     stat.season_id #=> "2024-25"
    #   @return [String] the season ID
    attribute :season_id, Shale::Type::String

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

  # Provides methods to retrieve league-wide player statistics
  module LeagueDashPlayerStats
    # Result set name for league dash player stats
    # @return [String] the result set name
    LEAGUE_DASH_PLAYER_STATS = "LeagueDashPlayerStats".freeze

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

    # Per mode constant for per 36 minutes
    # @return [String] the per mode
    PER_36 = "Per36".freeze

    # Retrieves league-wide player statistics
    #
    # @api public
    # @example
    #   stats = NBA::LeagueDashPlayerStats.all(season: 2024)
    #   stats.each { |s| puts "#{s.player_name}: #{s.pts} ppg" }
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player stats
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      path = build_path(season, season_type, per_mode)
      response = client.get(path)
      parse_response(response, season)
    end

    # Builds the API path
    #
    # @api private
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @return [String] the API path
    def self.build_path(season, season_type, per_mode)
      season_str = Utils.format_season(season)
      encoded_type = season_type
      "leaguedashplayerstats?LeagueID=00&Season=#{season_str}&SeasonType=#{encoded_type}&PerMode=#{per_mode}" \
        "&MeasureType=Base&Pace=N&PlusMinus=N&Rank=N"
    end
    private_class_method :build_path

    # Parses the API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @param season [Integer] the season year
    # @return [Collection] a collection of player stats
    def self.parse_response(response, season)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      season_id = Utils.format_season(season)
      stats = rows.map { |row| build_player_stat(headers, row, season_id) }
      Collection.new(stats)
    end
    private_class_method :parse_response

    # Finds the result set
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @return [Hash, nil] the result set
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(LEAGUE_DASH_PLAYER_STATS) }
    end
    private_class_method :find_result_set

    # Builds a player stat from a row
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @param season_id [String] the season ID
    # @return [LeagueDashPlayerStat] the player stat object
    def self.build_player_stat(headers, row, season_id)
      data = headers.zip(row).to_h
      LeagueDashPlayerStat.new(**player_stat_attributes(data, season_id))
    end
    private_class_method :build_player_stat

    # Extracts player stat attributes from row data
    #
    # @api private
    # @param data [Hash] the player stat row data
    # @param season_id [String] the season ID
    # @return [Hash] the player stat attributes
    def self.player_stat_attributes(data, season_id)
      identity_attributes(data, season_id).merge(shooting_attributes(data), counting_attributes(data), advanced_attributes(data))
    end
    private_class_method :player_stat_attributes

    # Extracts identity attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @param season_id [String] the season ID
    # @return [Hash] the identity attributes
    def self.identity_attributes(data, season_id)
      {player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       age: data.fetch("AGE", nil), gp: data.fetch("GP", nil), w: data.fetch("W", nil), l: data.fetch("L", nil),
       w_pct: data.fetch("W_PCT", nil), min: data.fetch("MIN", nil), season_id: season_id}
    end
    private_class_method :identity_attributes

    # Extracts shooting attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the shooting attributes
    def self.shooting_attributes(data)
      {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
       fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
       ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)}
    end
    private_class_method :shooting_attributes

    # Extracts counting stats attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the counting stats attributes
    def self.counting_attributes(data)
      {oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), reb: data.fetch("REB", nil),
       ast: data.fetch("AST", nil), tov: data.fetch("TOV", nil), stl: data.fetch("STL", nil), blk: data.fetch("BLK", nil),
       blka: data.fetch("BLKA", nil), pf: data.fetch("PF", nil), pfd: data.fetch("PFD", nil), pts: data.fetch("PTS", nil)}
    end
    private_class_method :counting_attributes

    # Extracts advanced attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the advanced attributes
    def self.advanced_attributes(data)
      {plus_minus: data.fetch("PLUS_MINUS", nil), nba_fantasy_pts: data.fetch("NBA_FANTASY_PTS", nil),
       dd2: data.fetch("DD2", nil), td3: data.fetch("TD3", nil)}
    end
    private_class_method :advanced_attributes
  end
end
