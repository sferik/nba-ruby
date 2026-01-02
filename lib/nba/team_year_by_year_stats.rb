require "json"
require_relative "client"
require_relative "collection"

module NBA
  # Represents a team's year-by-year statistics
  class TeamYearStat < Shale::Mapper
    include Equalizer.new(:team_id, :year)

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_city
    #   Returns the team city
    #   @api public
    #   @example
    #     stat.team_city #=> "Golden State"
    #   @return [String] the team city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     stat.team_name #=> "Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] year
    #   Returns the year
    #   @api public
    #   @example
    #     stat.year #=> "2024-25"
    #   @return [String] the year
    attribute :year, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 82
    #   @return [Integer] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] wins
    #   Returns wins
    #   @api public
    #   @example
    #     stat.wins #=> 46
    #   @return [Integer] wins
    attribute :wins, Shale::Type::Integer

    # @!attribute [rw] losses
    #   Returns losses
    #   @api public
    #   @example
    #     stat.losses #=> 36
    #   @return [Integer] losses
    attribute :losses, Shale::Type::Integer

    # @!attribute [rw] win_pct
    #   Returns win percentage
    #   @api public
    #   @example
    #     stat.win_pct #=> 0.561
    #   @return [Float] win percentage
    attribute :win_pct, Shale::Type::Float

    # @!attribute [rw] conf_rank
    #   Returns conference rank
    #   @api public
    #   @example
    #     stat.conf_rank #=> 10
    #   @return [Integer] conference rank
    attribute :conf_rank, Shale::Type::Integer

    # @!attribute [rw] div_rank
    #   Returns division rank
    #   @api public
    #   @example
    #     stat.div_rank #=> 3
    #   @return [Integer] division rank
    attribute :div_rank, Shale::Type::Integer

    # @!attribute [rw] po_wins
    #   Returns playoff wins
    #   @api public
    #   @example
    #     stat.po_wins #=> 0
    #   @return [Integer] playoff wins
    attribute :po_wins, Shale::Type::Integer

    # @!attribute [rw] po_losses
    #   Returns playoff losses
    #   @api public
    #   @example
    #     stat.po_losses #=> 0
    #   @return [Integer] playoff losses
    attribute :po_losses, Shale::Type::Integer

    # @!attribute [rw] nba_finals_appearance
    #   Returns NBA Finals appearance
    #   @api public
    #   @example
    #     stat.nba_finals_appearance #=> "N/A"
    #   @return [String] Finals appearance
    attribute :nba_finals_appearance, Shale::Type::String

    # @!attribute [rw] fgm
    #   Returns field goals made per game
    #   @api public
    #   @example
    #     stat.fgm #=> 43.2
    #   @return [Float] field goals made
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns field goals attempted per game
    #   @api public
    #   @example
    #     stat.fga #=> 91.5
    #   @return [Float] field goals attempted
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.472
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made per game
    #   @api public
    #   @example
    #     stat.fg3m #=> 14.8
    #   @return [Float] three-pointers made
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted per game
    #   @api public
    #   @example
    #     stat.fg3a #=> 40.2
    #   @return [Float] three-pointers attempted
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     stat.fg3_pct #=> 0.368
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made per game
    #   @api public
    #   @example
    #     stat.ftm #=> 17.5
    #   @return [Float] free throws made
    attribute :ftm, Shale::Type::Float

    # @!attribute [rw] fta
    #   Returns free throws attempted per game
    #   @api public
    #   @example
    #     stat.fta #=> 22.1
    #   @return [Float] free throws attempted
    attribute :fta, Shale::Type::Float

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stat.ft_pct #=> 0.792
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds per game
    #   @api public
    #   @example
    #     stat.oreb #=> 10.5
    #   @return [Float] offensive rebounds
    attribute :oreb, Shale::Type::Float

    # @!attribute [rw] dreb
    #   Returns defensive rebounds per game
    #   @api public
    #   @example
    #     stat.dreb #=> 33.8
    #   @return [Float] defensive rebounds
    attribute :dreb, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns total rebounds per game
    #   @api public
    #   @example
    #     stat.reb #=> 44.3
    #   @return [Float] total rebounds
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists per game
    #   @api public
    #   @example
    #     stat.ast #=> 28.1
    #   @return [Float] assists
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] pf
    #   Returns personal fouls per game
    #   @api public
    #   @example
    #     stat.pf #=> 19.5
    #   @return [Float] personal fouls
    attribute :pf, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns steals per game
    #   @api public
    #   @example
    #     stat.stl #=> 7.8
    #   @return [Float] steals
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns turnovers per game
    #   @api public
    #   @example
    #     stat.tov #=> 14.2
    #   @return [Float] turnovers
    attribute :tov, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns blocks per game
    #   @api public
    #   @example
    #     stat.blk #=> 5.2
    #   @return [Float] blocks
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points per game
    #   @api public
    #   @example
    #     stat.pts #=> 118.7
    #   @return [Float] points
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] pts_rank
    #   Returns points rank
    #   @api public
    #   @example
    #     stat.pts_rank #=> 5
    #   @return [Integer] points rank
    attribute :pts_rank, Shale::Type::Integer

    # Returns the team object
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns the full team name
    #
    # @api public
    # @example
    #   stat.full_name #=> "Golden State Warriors"
    # @return [String] the full name
    def full_name
      "#{team_city} #{team_name}".strip
    end
  end

  # Provides methods to retrieve team year-by-year statistics
  module TeamYearByYearStats
    # Result set name for team stats
    # @return [String] the result set name
    TEAM_STATS = "TeamStats".freeze

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

    # Retrieves year-by-year statistics for a team
    #
    # @api public
    # @example
    #   stats = NBA::TeamYearByYearStats.find(team: NBA::Team::GSW)
    #   stats.each { |s| puts "#{s.year}: #{s.wins}-#{s.losses}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of year-by-year stats
    def self.find(team:, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      team_id = extract_team_id(team)
      path = build_path(team_id, season_type, per_mode)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(team_id, season_type, per_mode)
      encoded_type = season_type
      "teamyearbyyearstats?TeamID=#{team_id}&SeasonType=#{encoded_type}&PerMode=#{per_mode}&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response into year stat objects
    # @api private
    # @return [Collection] collection of year stats
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_year_stat(headers, row) }
      Collection.new(stats)
    end
    private_class_method :parse_response

    # Finds the team stats result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name").eql?(TEAM_STATS) }
    end
    private_class_method :find_result_set

    # Builds a TeamYearStat object from raw data
    # @api private
    # @return [TeamYearStat] the year stat object
    def self.build_year_stat(headers, row)
      data = headers.zip(row).to_h
      TeamYearStat.new(**year_stat_attributes(data))
    end
    private_class_method :build_year_stat

    # Combines all year stat attributes
    # @api private
    # @return [Hash] the combined attributes
    def self.year_stat_attributes(data)
      identity_attributes(data).merge(record_attributes(data), shooting_attributes(data), counting_attributes(data))
    end
    private_class_method :year_stat_attributes

    # Extracts identity attributes from data
    # @api private
    # @return [Hash] identity attributes
    def self.identity_attributes(data)
      {team_id: data["TEAM_ID"], team_city: data["TEAM_CITY"],
       team_name: data["TEAM_NAME"], year: data["YEAR"], gp: data["GP"]}
    end
    private_class_method :identity_attributes

    # Extracts record attributes from data
    # @api private
    # @return [Hash] record attributes
    def self.record_attributes(data)
      {wins: data["WINS"], losses: data["LOSSES"], win_pct: data["WIN_PCT"],
       conf_rank: data["CONF_RANK"], div_rank: data["DIV_RANK"],
       po_wins: data["PO_WINS"], po_losses: data["PO_LOSSES"],
       nba_finals_appearance: data["NBA_FINALS_APPEARANCE"]}
    end
    private_class_method :record_attributes

    # Extracts shooting attributes from data
    # @api private
    # @return [Hash] shooting attributes
    def self.shooting_attributes(data)
      {fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"],
       fg3m: data["FG3M"], fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"],
       ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]}
    end
    private_class_method :shooting_attributes

    # Extracts counting stats attributes from data
    # @api private
    # @return [Hash] counting attributes
    def self.counting_attributes(data)
      {oreb: data["OREB"], dreb: data["DREB"], reb: data["REB"],
       ast: data["AST"], pf: data["PF"], stl: data["STL"],
       tov: data["TOV"], blk: data["BLK"], pts: data["PTS"], pts_rank: data["PTS_RANK"]}
    end
    private_class_method :counting_attributes

    # Extracts team ID from team object or integer
    # @api private
    # @return [Integer] the team ID
    def self.extract_team_id(team)
      team.instance_of?(Team) ? team.id : team
    end
    private_class_method :extract_team_id
  end
end
