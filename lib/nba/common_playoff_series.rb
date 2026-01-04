require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

module NBA
  # Represents a playoff series
  class PlayoffSeries < Shale::Mapper
    include Equalizer.new(:game_id, :series_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     series.game_id #=> "0042400101"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] home_team_id
    #   Returns the home team ID
    #   @api public
    #   @example
    #     series.home_team_id #=> 1610612744
    #   @return [Integer] the home team ID
    attribute :home_team_id, Shale::Type::Integer

    # @!attribute [rw] visitor_team_id
    #   Returns the visitor team ID
    #   @api public
    #   @example
    #     series.visitor_team_id #=> 1610612747
    #   @return [Integer] the visitor team ID
    attribute :visitor_team_id, Shale::Type::Integer

    # @!attribute [rw] series_id
    #   Returns the series ID
    #   @api public
    #   @example
    #     series.series_id #=> "0042400101"
    #   @return [String] the series ID
    attribute :series_id, Shale::Type::String

    # @!attribute [rw] game_num
    #   Returns the game number in the series
    #   @api public
    #   @example
    #     series.game_num #=> 1
    #   @return [Integer] the game number
    attribute :game_num, Shale::Type::Integer

    # Returns the home team object
    #
    # @api public
    # @example
    #   series.home_team #=> #<NBA::Team>
    # @return [Team, nil] the home team object
    def home_team
      Teams.find(home_team_id)
    end

    # Returns the visitor team object
    #
    # @api public
    # @example
    #   series.visitor_team #=> #<NBA::Team>
    # @return [Team, nil] the visitor team object
    def visitor_team
      Teams.find(visitor_team_id)
    end

    # Returns the game object
    #
    # @api public
    # @example
    #   series.game #=> #<NBA::Game>
    # @return [Game, nil] the game object
    def game
      Games.find(game_id)
    end
  end

  # Provides methods to retrieve playoff series data
  module CommonPlayoffSeries
    # Result set name for playoff series
    # @return [String] the result set name
    PLAYOFF_SERIES = "PlayoffSeries".freeze

    # Retrieves all playoff series for a season
    #
    # @api public
    # @example
    #   series = NBA::CommonPlayoffSeries.all(season: 2024)
    #   series.each { |s| puts "Game #{s.game_num}: #{s.home_team_id} vs #{s.visitor_team_id}" }
    # @param season [Integer] the season year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of playoff series
    def self.all(season: Utils.current_season, league: League::NBA, client: CLIENT)
      league_id = extract_league_id(league)
      path = build_path(season, league_id)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(season, league_id)
      season_str = "#{season}-#{(season + 1).to_s[-2..]}"
      "commonplayoffseries?LeagueID=#{league_id}&Season=#{season_str}"
    end
    private_class_method :build_path

    # Parses the API response into playoff series objects
    # @api private
    # @return [Collection] collection of playoff series
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      series = rows.map { |row| build_series(headers, row) }
      Collection.new(series)
    end
    private_class_method :parse_response

    # Finds the playoff series result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(PLAYOFF_SERIES) }
    end
    private_class_method :find_result_set

    # Builds a PlayoffSeries object from raw data
    # @api private
    # @return [PlayoffSeries] the playoff series object
    def self.build_series(headers, row)
      data = headers.zip(row).to_h
      PlayoffSeries.new(**series_attributes(data))
    end
    private_class_method :build_series

    # Extracts series attributes from data
    # @api private
    # @return [Hash] series attributes
    def self.series_attributes(data)
      {game_id: data.fetch("GAME_ID", nil), home_team_id: data.fetch("HOME_TEAM_ID", nil),
       visitor_team_id: data.fetch("VISITOR_TEAM_ID", nil), series_id: data.fetch("SERIES_ID", nil),
       game_num: data.fetch("GAME_NUM", nil)}
    end
    private_class_method :series_attributes

    # Extracts the league ID from a League object or string
    #
    # @api private
    # @param league [String, League] the league ID or League object
    # @return [String] the league ID string
    def self.extract_league_id(league)
      case league
      when League then league.id
      else league
      end
    end
    private_class_method :extract_league_id
  end
end
