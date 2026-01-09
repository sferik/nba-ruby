require "json"
require_relative "client"
require_relative "collection"
require_relative "cume_stats_team_games_entry"
require_relative "utils"

module NBA
  # Provides methods to retrieve cumulative stats team games
  module CumeStatsTeamGames
    # Result set name
    # @return [String] the result set name
    RESULTS = "CumeStatsTeamGames".freeze

    # Regular season type
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Playoffs season type
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Retrieves cumulative stats team games
    #
    # @api public
    # @example
    #   games = NBA::CumeStatsTeamGames.all(team: 1610612747, season: 2023)
    #   games.each { |g| puts "#{g.matchup}: #{g.game_id}" }
    # @param team [Integer, String, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type (Regular Season, Playoffs)
    # @param league [String, League] the league ID or League object (default NBA)
    # @param location [String, nil] the location filter (Home, Road)
    # @param outcome [String, nil] the outcome filter (W, L)
    # @param season_id [String, nil] the season ID
    # @param vs_conference [String, nil] the vs conference filter (East, West)
    # @param vs_division [String, nil] the vs division filter
    # @param vs_team [Integer, String, Team, nil] the vs team ID or Team object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of cumulative stats team games entries
    def self.all(team:, season:, season_type: REGULAR_SEASON, league: League::NBA, location: nil, outcome: nil,
      season_id: nil, vs_conference: nil, vs_division: nil, vs_team: nil, client: CLIENT)
      opts = {team: team, season: season, season_type: season_type, league: league, location: location,
              outcome: outcome, season_id: season_id, vs_conference: vs_conference,
              vs_division: vs_division, vs_team: vs_team}
      path = PathBuilder.build(opts)
      response = client.get(path)
      parse_response(response)
    end

    # Builds API path from options
    # @api private
    module PathBuilder
      # Builds the complete API path from options
      # @api private
      # @param opts [Hash] the options hash
      # @return [String] the complete API path
      def self.build(opts)
        "cumestatsteamgames?#{Utils.build_query(**build_params(opts))}"
      end

      # Builds all parameters from options
      # @api private
      # @param opts [Hash] the options hash
      # @return [Hash] the merged parameters
      def self.build_params(opts)
        required_params(opts).merge(optional_params(opts))
      end

      # Builds required parameters from options
      # @api private
      # @param opts [Hash] the options hash
      # @return [Hash] the required parameters
      def self.required_params(opts)
        {
          TeamID: Utils.extract_id(opts[:team]),
          LeagueID: CumeStatsTeamGames.send(:extract_league_id, opts[:league]),
          Season: Utils.format_season(opts[:season]),
          SeasonType: opts[:season_type]
        }
      end

      # Builds optional parameters from options
      # @api private
      # @param opts [Hash] the options hash
      # @return [Hash] the optional parameters
      def self.optional_params(opts)
        {
          Location: opts[:location], Outcome: opts[:outcome], SeasonID: opts[:season_id],
          VsConference: opts[:vs_conference], VsDivision: opts[:vs_division],
          VsTeamID: Utils.extract_id(opts[:vs_team])
        }
      end
    end

    # Parses the API response into entry objects
    # @api private
    # @return [Collection] collection of entries
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      entries = rows.map { |row| build_entry(headers, row) }
      Collection.new(entries)
    end
    private_class_method :parse_response

    # Finds the result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(RESULTS) }
    end
    private_class_method :find_result_set

    # Builds a CumeStatsTeamGamesEntry object from raw data
    # @api private
    # @return [CumeStatsTeamGamesEntry] the entry object
    def self.build_entry(headers, row)
      data = headers.zip(row).to_h
      CumeStatsTeamGamesEntry.new(**entry_attributes(data))
    end
    private_class_method :build_entry

    # Extracts entry attributes from data
    # @api private
    # @return [Hash] the entry attributes
    def self.entry_attributes(data)
      {
        matchup: data.fetch("MATCHUP", nil),
        game_id: data.fetch("GAME_ID", nil)
      }
    end
    private_class_method :entry_attributes

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
