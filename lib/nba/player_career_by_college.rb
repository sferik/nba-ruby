require_relative "client"
require_relative "response_parser"

module NBA
  # Represents a player's career stats from a specific college
  class CollegePlayerStat < Shale::Mapper
    include Equalizer.new(:player_id)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player's name
    #   @api public
    #   @example
    #     stat.player_name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] college
    #   Returns the college name
    #   @api public
    #   @example
    #     stat.college #=> "Davidson"
    #   @return [String] the college name
    attribute :college, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 966
    #   @return [Integer] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] min
    #   Returns total minutes played
    #   @api public
    #   @example
    #     stat.min #=> 31000.0
    #   @return [Float] minutes
    attribute :min, Shale::Type::Float

    # @!attribute [rw] fgm
    #   Returns field goals made
    #   @api public
    #   @example
    #     stat.fgm #=> 8000.0
    #   @return [Float] field goals made
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     stat.fga #=> 16000.0
    #   @return [Float] field goals attempted
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.475
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made
    #   @api public
    #   @example
    #     stat.fg3m #=> 3500.0
    #   @return [Float] three-pointers made
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted
    #   @api public
    #   @example
    #     stat.fg3a #=> 8500.0
    #   @return [Float] three-pointers attempted
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     stat.fg3_pct #=> 0.428
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made
    #   @api public
    #   @example
    #     stat.ftm #=> 4500.0
    #   @return [Float] free throws made
    attribute :ftm, Shale::Type::Float

    # @!attribute [rw] fta
    #   Returns free throws attempted
    #   @api public
    #   @example
    #     stat.fta #=> 4900.0
    #   @return [Float] free throws attempted
    attribute :fta, Shale::Type::Float

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stat.ft_pct #=> 0.918
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds
    #   @api public
    #   @example
    #     stat.oreb #=> 700.0
    #   @return [Float] offensive rebounds
    attribute :oreb, Shale::Type::Float

    # @!attribute [rw] dreb
    #   Returns defensive rebounds
    #   @api public
    #   @example
    #     stat.dreb #=> 4200.0
    #   @return [Float] defensive rebounds
    attribute :dreb, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns total rebounds
    #   @api public
    #   @example
    #     stat.reb #=> 4900.0
    #   @return [Float] total rebounds
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists
    #   @api public
    #   @example
    #     stat.ast #=> 5800.0
    #   @return [Float] assists
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns steals
    #   @api public
    #   @example
    #     stat.stl #=> 1400.0
    #   @return [Float] steals
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns blocks
    #   @api public
    #   @example
    #     stat.blk #=> 300.0
    #   @return [Float] blocks
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns turnovers
    #   @api public
    #   @example
    #     stat.tov #=> 2600.0
    #   @return [Float] turnovers
    attribute :tov, Shale::Type::Float

    # @!attribute [rw] pf
    #   Returns personal fouls
    #   @api public
    #   @example
    #     stat.pf #=> 2000.0
    #   @return [Float] personal fouls
    attribute :pf, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points
    #   @api public
    #   @example
    #     stat.pts #=> 24000.0
    #   @return [Float] points
    attribute :pts, Shale::Type::Float

    # Returns the player object
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end
  end

  # Provides methods to retrieve player career stats by college
  module PlayerCareerByCollege
    # Per mode constant for per game stats
    # @return [String] the per mode
    PER_GAME = "PerGame".freeze

    # Per mode constant for totals
    # @return [String] the per mode
    TOTALS = "Totals".freeze

    # Retrieves career statistics for all players from a specific college
    #
    # @api public
    # @example
    #   # Get all players from Duke
    #   stats = NBA::PlayerCareerByCollege.find(college: "Duke")
    #   stats.each { |s| puts "#{s.player_name}: #{s.pts} career points" }
    #
    # @example
    #   # Get per-game averages
    #   stats = NBA::PlayerCareerByCollege.find(college: "Kentucky", per_mode: NBA::PlayerCareerByCollege::PER_GAME)
    #
    # @param college [String] the college name (required)
    # @param per_mode [String] the per mode (Totals or PerGame)
    # @param season [String, nil] optional season filter
    # @param client [Client] the API client to use
    # @return [Collection] a collection of college player stats
    def self.find(college:, per_mode: TOTALS, season: nil, client: CLIENT)
      path = build_path(college, per_mode, season)
      ResponseParser.parse(client.get(path)) { |data| build_stat(data) }
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(college, per_mode, season)
      season_param = "&SeasonNullable=#{season}" if season
      "playercareerbycollege?College=#{college}&LeagueID=00" \
        "&PerModeSimple=#{per_mode}&SeasonTypeAllStar=Regular+Season#{season_param}"
    end
    private_class_method :build_path

    # Builds a college player stat from API data
    # @api private
    # @return [CollegePlayerStat]
    def self.build_stat(data)
      CollegePlayerStat.new(**identity_info(data), **shooting_stats(data), **counting_stats(data))
    end
    private_class_method :build_stat

    # Extracts identity information from data
    # @api private
    # @return [Hash]
    def self.identity_info(data)
      {player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       college: data.fetch("COLLEGE", nil), gp: data.fetch("GP", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :identity_info

    # Extracts shooting statistics from data
    # @api private
    # @return [Hash]
    def self.shooting_stats(data)
      {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
       fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
       ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)}
    end
    private_class_method :shooting_stats

    # Extracts counting statistics from data
    # @api private
    # @return [Hash]
    def self.counting_stats(data)
      {oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), reb: data.fetch("REB", nil),
       ast: data.fetch("AST", nil), stl: data.fetch("STL", nil), blk: data.fetch("BLK", nil),
       tov: data.fetch("TOV", nil), pf: data.fetch("PF", nil), pts: data.fetch("PTS", nil)}
    end
    private_class_method :counting_stats
  end
end
