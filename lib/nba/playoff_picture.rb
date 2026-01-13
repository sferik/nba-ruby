require "json"
require_relative "client"
require_relative "collection"
require_relative "league"
require_relative "playoff_matchup"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Provides methods to retrieve NBA playoff picture data
  module PlayoffPicture
    # Retrieves playoff matchups for both conferences
    #
    # @api public
    # @example
    #   matchups = NBA::PlayoffPicture.all(season: 2023)
    #   matchups.each { |m| puts "#{m.high_seed_team} vs #{m.low_seed_team}" }
    # @param season [Integer] the season year (defaults to current season)
    # @param league [String, League] the league ID or League object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of playoff matchups
    def self.all(season: Utils.current_season, league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      season_id = Utils.format_season_id(season)
      path = "playoffpicture?LeagueID=#{league_id}&SeasonID=#{season_id}"
      response = client.get(path)
      parse_playoff_picture(response)
    end

    # Parses the playoff picture response
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Collection] a collection of playoff matchups
    def self.parse_playoff_picture(response)
      return Collection.new if response.nil? || response.empty?

      data = JSON.parse(response)
      result_sets = data["resultSets"]
      return Collection.new unless result_sets

      matchups = []
      matchups.concat(parse_conference(result_sets, "EastConfPlayoffPicture", "East"))
      matchups.concat(parse_conference(result_sets, "WestConfPlayoffPicture", "West"))
      Collection.new(matchups)
    end
    private_class_method :parse_playoff_picture

    # Parses a conference result set
    #
    # @api private
    # @param result_sets [Array] all result sets
    # @param name [String] the result set name to find
    # @param conference [String] the conference name
    # @return [Array<PlayoffMatchup>] array of matchups
    def self.parse_conference(result_sets, name, conference)
      result_set = result_sets.find { |rs| rs.fetch("name").eql?(name) }
      return [] unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return [] unless headers && rows

      rows.map { |row| build_matchup(headers.zip(row).to_h, conference) }
    end
    private_class_method :parse_conference

    # Builds a playoff matchup from data
    #
    # @api private
    # @param data [Hash] the row data
    # @param conference [String] the conference name
    # @return [PlayoffMatchup] the matchup object
    def self.build_matchup(data, conference)
      PlayoffMatchup.new(**matchup_attributes(data, conference))
    end
    private_class_method :build_matchup

    # Extracts matchup attributes from data
    #
    # @api private
    # @param data [Hash] the row data
    # @param conference [String] the conference name
    # @return [Hash] matchup attributes
    def self.matchup_attributes(data, conference)
      {conference: conference, high_seed_rank: data["HIGH_SEED_RANK"],
       high_seed_team: data["HIGH_SEED_TEAM"],
       high_seed_team_id: data["HIGH_SEED_TEAM_ID"],
       low_seed_rank: data["LOW_SEED_RANK"],
       low_seed_team: data["LOW_SEED_TEAM"],
       low_seed_team_id: data["LOW_SEED_TEAM_ID"],
       high_seed_series_wins: data["HIGH_SEED_SERIES_W"],
       low_seed_series_wins: data["LOW_SEED_SERIES_W"],
       series_status: data["SERIES_STATUS"]}
    end
    private_class_method :matchup_attributes
  end
end
