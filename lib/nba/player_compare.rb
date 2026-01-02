require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

module NBA
  # Represents a player comparison stat line
  class PlayerComparisonStat < Shale::Mapper
    include Equalizer.new(:player_id, :season_id)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] first_name
    #   Returns the player's first name
    #   @api public
    #   @example
    #     stat.first_name #=> "Stephen"
    #   @return [String] the first name
    attribute :first_name, Shale::Type::String

    # @!attribute [rw] last_name
    #   Returns the player's last name
    #   @api public
    #   @example
    #     stat.last_name #=> "Curry"
    #   @return [String] the last name
    attribute :last_name, Shale::Type::String

    # @!attribute [rw] season_id
    #   Returns the season ID
    #   @api public
    #   @example
    #     stat.season_id #=> "2024-25"
    #   @return [String] the season ID
    attribute :season_id, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 74
    #   @return [Integer] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] min
    #   Returns minutes per game
    #   @api public
    #   @example
    #     stat.min #=> 32.5
    #   @return [Float] minutes per game
    attribute :min, Shale::Type::Float

    # @!attribute [rw] fgm
    #   Returns field goals made per game
    #   @api public
    #   @example
    #     stat.fgm #=> 8.5
    #   @return [Float] field goals made
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns field goals attempted per game
    #   @api public
    #   @example
    #     stat.fga #=> 17.2
    #   @return [Float] field goals attempted
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.494
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
    #     stat.fg3a #=> 11.5
    #   @return [Float] three-pointers attempted
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     stat.fg3_pct #=> 0.417
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made per game
    #   @api public
    #   @example
    #     stat.ftm #=> 4.2
    #   @return [Float] free throws made
    attribute :ftm, Shale::Type::Float

    # @!attribute [rw] fta
    #   Returns free throws attempted per game
    #   @api public
    #   @example
    #     stat.fta #=> 4.6
    #   @return [Float] free throws attempted
    attribute :fta, Shale::Type::Float

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stat.ft_pct #=> 0.913
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds per game
    #   @api public
    #   @example
    #     stat.oreb #=> 0.5
    #   @return [Float] offensive rebounds
    attribute :oreb, Shale::Type::Float

    # @!attribute [rw] dreb
    #   Returns defensive rebounds per game
    #   @api public
    #   @example
    #     stat.dreb #=> 4.3
    #   @return [Float] defensive rebounds
    attribute :dreb, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns total rebounds per game
    #   @api public
    #   @example
    #     stat.reb #=> 4.8
    #   @return [Float] total rebounds
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists per game
    #   @api public
    #   @example
    #     stat.ast #=> 6.1
    #   @return [Float] assists
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns steals per game
    #   @api public
    #   @example
    #     stat.stl #=> 0.9
    #   @return [Float] steals
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns blocks per game
    #   @api public
    #   @example
    #     stat.blk #=> 0.3
    #   @return [Float] blocks
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns turnovers per game
    #   @api public
    #   @example
    #     stat.tov #=> 2.8
    #   @return [Float] turnovers
    attribute :tov, Shale::Type::Float

    # @!attribute [rw] pf
    #   Returns personal fouls per game
    #   @api public
    #   @example
    #     stat.pf #=> 1.8
    #   @return [Float] personal fouls
    attribute :pf, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points per game
    #   @api public
    #   @example
    #     stat.pts #=> 26.4
    #   @return [Float] points
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] eff
    #   Returns efficiency
    #   @api public
    #   @example
    #     stat.eff #=> 24.5
    #   @return [Float] efficiency
    attribute :eff, Shale::Type::Float

    # @!attribute [rw] ast_tov
    #   Returns assist to turnover ratio
    #   @api public
    #   @example
    #     stat.ast_tov #=> 2.18
    #   @return [Float] assist to turnover ratio
    attribute :ast_tov, Shale::Type::Float

    # @!attribute [rw] stl_tov
    #   Returns steal to turnover ratio
    #   @api public
    #   @example
    #     stat.stl_tov #=> 0.32
    #   @return [Float] steal to turnover ratio
    attribute :stl_tov, Shale::Type::Float

    # Returns the player object
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns the full name
    #
    # @api public
    # @example
    #   stat.full_name #=> "Stephen Curry"
    # @return [String] the full name
    def full_name
      "#{first_name} #{last_name}".strip
    end
  end

  # Provides methods to compare two players
  module PlayerCompare
    # Result set name for overall comparison
    # @return [String] the result set name
    OVERALL_COMPARE = "OverallCompare".freeze

    # Season type constant for regular season
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Season type constant for playoffs
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Compares two players overall stats
    #
    # @api public
    # @example
    #   stats = NBA::PlayerCompare.compare(
    #     player: 201939,
    #     vs_player: 2544,
    #     season: 2024
    #   )
    #   stats.each { |s| puts "#{s.full_name}: #{s.pts} ppg" }
    # @param player [Integer, Player] the first player ID or Player object
    # @param vs_player [Integer, Player] the second player ID or Player object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param client [Client] the API client to use
    # @return [Collection] a collection of comparison stats
    def self.compare(player:, vs_player:, season: Utils.current_season, season_type: REGULAR_SEASON, client: CLIENT)
      player_id = extract_player_id(player)
      vs_player_id = extract_player_id(vs_player)
      path = build_path(player_id, vs_player_id, season, season_type)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(player_id, vs_player_id, season, season_type)
      season_str = "#{season}-#{(season + 1).to_s[-2..]}"
      encoded_type = season_type
      "playercompare?PlayerIDList=#{player_id}&VsPlayerIDList=#{vs_player_id}" \
        "&Season=#{season_str}&SeasonType=#{encoded_type}&PerMode=PerGame&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response into comparison stat objects
    # @api private
    # @return [Collection] collection of comparison stats
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_comparison_stat(headers, row) }
      Collection.new(stats)
    end
    private_class_method :parse_response

    # Finds the overall compare result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name").eql?(OVERALL_COMPARE) }
    end
    private_class_method :find_result_set

    # Builds a PlayerComparisonStat object from raw data
    # @api private
    # @return [PlayerComparisonStat] the comparison stat object
    def self.build_comparison_stat(headers, row)
      data = headers.zip(row).to_h
      PlayerComparisonStat.new(**comparison_attributes(data))
    end
    private_class_method :build_comparison_stat

    # Combines all comparison attributes
    # @api private
    # @return [Hash] the combined attributes
    def self.comparison_attributes(data)
      identity_attributes(data).merge(shooting_attributes(data), counting_attributes(data), advanced_attributes(data))
    end
    private_class_method :comparison_attributes

    # Extracts identity attributes from data
    # @api private
    # @return [Hash] identity attributes
    def self.identity_attributes(data)
      {player_id: data.fetch("PLAYER_ID"), first_name: data.fetch("FIRST_NAME"),
       last_name: data.fetch("LAST_NAME"), season_id: data.fetch("SEASON_ID"),
       gp: data.fetch("GP"), min: data.fetch("MIN")}
    end
    private_class_method :identity_attributes

    # Extracts shooting attributes from data
    # @api private
    # @return [Hash] shooting attributes
    def self.shooting_attributes(data)
      {fgm: data.fetch("FGM"), fga: data.fetch("FGA"), fg_pct: data.fetch("FG_PCT"),
       fg3m: data.fetch("FG3M"), fg3a: data.fetch("FG3A"), fg3_pct: data.fetch("FG3_PCT"),
       ftm: data.fetch("FTM"), fta: data.fetch("FTA"), ft_pct: data.fetch("FT_PCT")}
    end
    private_class_method :shooting_attributes

    # Extracts counting stats attributes from data
    # @api private
    # @return [Hash] counting attributes
    def self.counting_attributes(data)
      {oreb: data.fetch("OREB"), dreb: data.fetch("DREB"), reb: data.fetch("REB"),
       ast: data.fetch("AST"), stl: data.fetch("STL"), blk: data.fetch("BLK"),
       tov: data.fetch("TOV"), pf: data.fetch("PF"), pts: data.fetch("PTS")}
    end
    private_class_method :counting_attributes

    # Extracts advanced stats attributes from data
    # @api private
    # @return [Hash] advanced attributes
    def self.advanced_attributes(data)
      {eff: data.fetch("EFF"), ast_tov: data.fetch("AST_TOV"), stl_tov: data.fetch("STL_TOV")}
    end
    private_class_method :advanced_attributes

    # Extracts player ID from a Player object or returns the integer
    #
    # @api private
    # @param player [Player, Integer] the player or player ID
    # @return [Integer] the player ID
    def self.extract_player_id(player)
      case player
      when Player then player.id
      else player
      end
    end
    private_class_method :extract_player_id
  end
end
