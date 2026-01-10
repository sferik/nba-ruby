require_relative "client"
require_relative "response_parser"
require_relative "cume_stats_player_games_entry"
require_relative "utils"

module NBA
  # Provides methods to retrieve cumulative stats player games
  #
  # @api public
  module CumeStatsPlayerGames
    # Result set name for cumulative stats player games
    # @return [String] the result set name
    RESULTS = "CumeStatsPlayerGames".freeze

    # Retrieves all cumulative stats player games for specified criteria
    #
    # @api public
    # @example
    #   games = NBA::CumeStatsPlayerGames.all(player: 201939, season: 2024, season_type: "Regular Season")
    #   games.each { |game| puts "#{game.matchup} - #{game.game_id}" }
    # @param player [Integer, Player] the player ID or Player object
    # @param season [Integer] the season year
    # @param season_type [String] the season type (Regular Season, Playoffs)
    # @param league [String, League] the league ID or League object (default NBA)
    # @param location [String, nil] filter by location (Home, Road)
    # @param outcome [String, nil] filter by outcome (W, L)
    # @param vs_conference [String, nil] filter by opponent conference
    # @param vs_division [String, nil] filter by opponent division
    # @param vs_team [Integer, Team, nil] filter by opponent team ID or Team object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of cumulative stats player games entries
    def self.all(player:, season:, season_type: "Regular Season", league: League::NBA, location: nil,
      outcome: nil, vs_conference: nil, vs_division: nil, vs_team: nil, client: CLIENT)
      opts = {player: player, season: season, season_type: season_type, league: league,
              location: location, outcome: outcome, vs_conference: vs_conference,
              vs_division: vs_division, vs_team: vs_team}
      path = PathBuilder.build(opts)
      ResponseParser.parse(client.get(path), result_set: RESULTS) { |data| build_entry(data) }
    end

    # Builds an entry from API data
    #
    # @api private
    # @return [CumeStatsPlayerGamesEntry]
    def self.build_entry(data)
      CumeStatsPlayerGamesEntry.new(**entry_attributes(data))
    end
    private_class_method :build_entry

    # Extracts entry attributes from data
    #
    # @api private
    # @param data [Hash] the entry data
    # @return [Hash] the entry attributes
    def self.entry_attributes(data)
      {game_id: data.fetch("GAME_ID", nil), matchup: data.fetch("MATCHUP", nil)}
    end
    private_class_method :entry_attributes

    # Builds API path from options
    # @api private
    module PathBuilder
      # Builds the complete API path from options
      # @api private
      # @param opts [Hash] the options hash
      # @return [String] the complete API path
      def self.build(opts)
        base_path(opts) + optional_params(opts)
      end

      # Builds the base API path from options
      # @api private
      # @param opts [Hash] the options hash
      # @return [String] the base API path
      def self.base_path(opts)
        player_id = Utils.extract_id(opts.fetch(:player))
        league_id = Utils.extract_league_id(opts.fetch(:league))
        season_str = Utils.format_season(opts.fetch(:season))

        "cumestatsplayergames?PlayerID=#{player_id}&LeagueID=#{league_id}" \
          "&Season=#{season_str}&SeasonType=#{opts.fetch(:season_type)}"
      end

      # Builds optional parameters string from options
      # @api private
      # @param opts [Hash] the options hash
      # @return [String] the optional parameters string
      def self.optional_params(opts)
        path = ""
        path += "&Location=#{opts.fetch(:location)}" if opts.fetch(:location)
        path += "&Outcome=#{opts.fetch(:outcome)}" if opts.fetch(:outcome)
        path += "&VsConference=#{opts.fetch(:vs_conference)}" if opts.fetch(:vs_conference)
        path += "&VsDivision=#{opts.fetch(:vs_division)}" if opts.fetch(:vs_division)
        path += "&VsTeamID=#{Utils.extract_id(opts.fetch(:vs_team))}" if opts.fetch(:vs_team)
        path
      end
    end
  end
end
