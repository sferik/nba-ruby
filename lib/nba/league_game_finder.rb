require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

require_relative "found_game"

module NBA
  # Provides methods to find games based on criteria
  module LeagueGameFinder
    # Result set name for team games
    # @return [String] the result set name
    TEAM_GAMES = "TeamGameFinderResults".freeze

    # Result set name for player games
    # @return [String] the result set name
    PLAYER_GAMES = "PlayerGameFinderResults".freeze

    # Season type constant for regular season
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Season type constant for playoffs
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Finds games for a team
    #
    # @api public
    # @example
    #   games = NBA::LeagueGameFinder.by_team(team: NBA::Team::GSW)
    #   games.each { |g| puts "#{g.game_date}: #{g.matchup} - #{g.wl}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer, nil] the season year (nil for all seasons)
    # @param season_type [String] the season type
    # @param client [Client] the API client to use
    # @return [Collection] a collection of found games
    def self.by_team(team:, season: nil, season_type: REGULAR_SEASON, client: CLIENT)
      team_id = Utils.extract_id(team)
      path = build_team_path(team_id, season, season_type)
      response = client.get(path)
      parse_response(response, TEAM_GAMES)
    end

    # Finds games for a player
    #
    # @api public
    # @example
    #   games = NBA::LeagueGameFinder.by_player(player: 201939)
    #   games.each { |g| puts "#{g.game_date}: #{g.matchup} - #{g.pts} pts" }
    # @param player [Integer, Player] the player ID or Player object
    # @param season [Integer, nil] the season year (nil for all seasons)
    # @param season_type [String] the season type
    # @param client [Client] the API client to use
    # @return [Collection] a collection of found games
    def self.by_player(player:, season: nil, season_type: REGULAR_SEASON, client: CLIENT)
      player_id = Utils.extract_id(player)
      path = build_player_path(player_id, season, season_type)
      response = client.get(path)
      parse_response(response, PLAYER_GAMES)
    end

    # Builds the API path for team game finder
    #
    # @api private
    # @return [String] the request path
    def self.build_team_path(team_id, season, season_type)
      path = "leaguegamefinder?TeamID=#{team_id}&SeasonType=#{season_type}&LeagueID=00"
      path += "&Season=#{Utils.format_season(season)}" if season
      path
    end
    private_class_method :build_team_path

    # Builds the API path for player game finder
    #
    # @api private
    # @return [String] the request path
    def self.build_player_path(player_id, season, season_type)
      path = "leaguegamefinder?PlayerID=#{player_id}&SeasonType=#{season_type}&LeagueID=00"
      path += "&Season=#{Utils.format_season(season)}" if season
      path
    end
    private_class_method :build_player_path

    # Parses the API response into found game objects
    #
    # @api private
    # @return [Collection] collection of found games
    def self.parse_response(response, result_set_name)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, result_set_name)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      games = rows.map { |row| build_found_game(headers, row) }
      Collection.new(games)
    end
    private_class_method :parse_response

    # Finds the result set in the response
    #
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data, name)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(name) }
    end
    private_class_method :find_result_set

    # Builds a FoundGame object from raw data
    #
    # @api private
    # @return [FoundGame] the found game object
    def self.build_found_game(headers, row)
      data = headers.zip(row).to_h
      FoundGame.new(**found_game_attributes(data))
    end
    private_class_method :build_found_game

    # Combines all found game attributes
    #
    # @api private
    # @return [Hash] the combined attributes
    def self.found_game_attributes(data)
      identity_attributes(data).merge(shooting_attributes(data), counting_attributes(data))
    end
    private_class_method :found_game_attributes

    # Extracts identity attributes from data
    #
    # @api private
    # @return [Hash] identity attributes
    def self.identity_attributes(data)
      {season_id: data["SEASON_ID"], team_id: data["TEAM_ID"],
       team_abbreviation: data["TEAM_ABBREVIATION"], team_name: data["TEAM_NAME"],
       game_id: data["GAME_ID"], game_date: data["GAME_DATE"],
       matchup: data["MATCHUP"], wl: data["WL"], min: data["MIN"]}
    end
    private_class_method :identity_attributes

    # Extracts shooting attributes from data
    #
    # @api private
    # @return [Hash] shooting attributes
    def self.shooting_attributes(data)
      {fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"],
       fg3m: data["FG3M"], fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"],
       ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]}
    end
    private_class_method :shooting_attributes

    # Extracts counting stats attributes from data
    #
    # @api private
    # @return [Hash] counting attributes
    def self.counting_attributes(data)
      {pts: data["PTS"], oreb: data["OREB"], dreb: data["DREB"], reb: data["REB"],
       ast: data["AST"], stl: data["STL"], blk: data["BLK"],
       tov: data["TOV"], pf: data["PF"], plus_minus: data["PLUS_MINUS"]}
    end
    private_class_method :counting_attributes
  end
end
