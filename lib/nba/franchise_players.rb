require "json"
require_relative "client"
require_relative "collection"
require_relative "franchise_player"

module NBA
  # Provides methods to retrieve franchise player statistics
  module FranchisePlayers
    # Result set name for franchise players
    # @return [String] the result set name
    RESULTS = "FranchisePlayers".freeze

    # Per mode constant for per game stats
    # @return [String] the per game mode
    PER_GAME = "PerGame".freeze

    # Per mode constant for totals stats
    # @return [String] the totals mode
    TOTALS = "Totals".freeze

    # Retrieves all franchise player statistics
    #
    # @api public
    # @example
    #   players = NBA::FranchisePlayers.all(team: 1610612744)
    #   players.each { |p| puts "#{p.player}: #{p.pts} PPG" }
    # @param team [Integer, String, Team] the team ID or Team object
    # @param season_type [String] the season type (default "Regular Season")
    # @param per_mode [String] the per mode (default PER_GAME)
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of franchise players
    def self.all(team:, season_type: "Regular Season", per_mode: PER_GAME, league: League::NBA, client: CLIENT)
      team_id = Utils.extract_id(team)
      return Collection.new unless team_id

      league_id = Utils.extract_league_id(league)
      path = "franchiseplayers?TeamID=#{team_id}&SeasonType=#{season_type}&PerMode=#{per_mode}&LeagueID=#{league_id}"
      response = client.get(path)
      parse_response(response)
    end

    # Parses the API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Collection] a collection of franchise players
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, RESULTS)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      players = rows.map { |row| build_player(headers, row) }
      Collection.new(players)
    end
    private_class_method :parse_response

    # Finds a result set by name
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @param name [String] the result set name
    # @return [Hash, nil] the result set
    def self.find_result_set(data, name)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(name) }
    end
    private_class_method :find_result_set

    # Builds a franchise player from a row
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [FranchisePlayer] the franchise player object
    def self.build_player(headers, row)
      data = headers.zip(row).to_h
      FranchisePlayer.new(**player_attributes(data))
    end
    private_class_method :build_player

    # Extracts player attributes from row data
    #
    # @api private
    # @param data [Hash] the player row data
    # @return [Hash] the player attributes
    def self.player_attributes(data)
      identity_attributes(data).merge(stats_attributes(data), shooting_attributes(data), rebound_attributes(data))
    end
    private_class_method :player_attributes

    # Extracts identity attributes
    #
    # @api private
    # @param data [Hash] the player data
    # @return [Hash] the identity attributes
    def self.identity_attributes(data)
      {league_id: data.fetch("LEAGUE_ID", nil), team_id: data.fetch("TEAM_ID", nil),
       team: data.fetch("TEAM", nil), person_id: data.fetch("PERSON_ID", nil),
       player: data.fetch("PLAYER", nil), season_type: data.fetch("SEASON_TYPE", nil),
       active_with_team: data.fetch("ACTIVE_WITH_TEAM", nil)}
    end
    private_class_method :identity_attributes

    # Extracts basic stats attributes
    #
    # @api private
    # @param data [Hash] the player data
    # @return [Hash] the stats attributes
    def self.stats_attributes(data)
      {gp: data.fetch("GP", nil), ast: data.fetch("AST", nil), pf: data.fetch("PF", nil),
       stl: data.fetch("STL", nil), tov: data.fetch("TOV", nil), blk: data.fetch("BLK", nil),
       pts: data.fetch("PTS", nil)}
    end
    private_class_method :stats_attributes

    # Extracts shooting attributes
    #
    # @api private
    # @param data [Hash] the player data
    # @return [Hash] the shooting attributes
    def self.shooting_attributes(data)
      {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
       fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
       ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)}
    end
    private_class_method :shooting_attributes

    # Extracts rebound attributes
    #
    # @api private
    # @param data [Hash] the player data
    # @return [Hash] the rebound attributes
    def self.rebound_attributes(data)
      {oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), reb: data.fetch("REB", nil)}
    end
    private_class_method :rebound_attributes
  end
end
