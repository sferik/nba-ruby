require "json"
require_relative "client"
require_relative "collection"
require_relative "standing"
require_relative "utils"

module NBA
  # Provides methods to retrieve NBA standings
  module Standings
    # Retrieves all team standings
    #
    # @api public
    # @example
    #   standings = NBA::Standings.all
    #   standings.each { |s| puts "#{s.conference_rank}. #{s.team_name}: #{s.wins}-#{s.losses}" }
    # @param season [Integer] the season year (defaults to current season)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of standings
    def self.all(season: Utils.current_season, client: CLIENT)
      season_str = "#{season}-#{(season + 1).to_s[-2..]}"
      path = "leaguestandings?LeagueID=00&Season=#{season_str}&SeasonType=Regular+Season"
      response = client.get(path)
      parse_standings_response(response)
    end

    # Retrieves standings for a specific conference
    #
    # @api public
    # @example
    #   western = NBA::Standings.conference("West")
    # @param conference_name [String] the conference name (East or West)
    # @param season [Integer] the season year
    # @param client [Client] the API client to use
    # @return [Collection] a collection of standings for the conference
    def self.conference(conference_name, season: Utils.current_season, client: CLIENT)
      standings = all(season: season, client: client)
      filtered = standings.select { |s| s.conference.eql?(conference_name) }
      Collection.new(filtered)
    end

    # Parses the standings API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Collection] a collection of standings
    def self.parse_standings_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = data.dig("resultSets", 0)
      return Collection.new unless result_set

      headers = result_set.fetch("headers")
      rows = result_set.fetch("rowSet")
      return Collection.new unless headers && rows

      standings = rows.map { |row| build_standing_from_row(headers, row) }
      Collection.new(standings)
    end
    private_class_method :parse_standings_response

    # Builds a standing from a row of data
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [Standing] the standing object
    def self.build_standing_from_row(headers, row)
      data = headers.zip(row).to_h
      Standing.new(**standing_attributes(data))
    end
    private_class_method :build_standing_from_row

    # Extracts standing attributes from row data
    #
    # @api private
    # @param data [Hash] the standing row data
    # @return [Hash] the standing attributes
    def self.standing_attributes(data)
      {
        team_id: data.fetch("TeamID"), team_name: data.fetch("TeamName"),
        conference: data.fetch("Conference"), division: data.fetch("Division"),
        wins: data.fetch("WINS"), losses: data.fetch("LOSSES"), win_pct: data.fetch("WinPCT"),
        conference_rank: parse_conference_rank(data.fetch("ConferenceRecord", nil), data.fetch("PlayoffRank")),
        home_record: data.fetch("HOME"), road_record: data.fetch("ROAD"),
        streak: data.fetch("strCurrentStreak")
      }
    end
    private_class_method :standing_attributes

    # Parses conference rank from conference record or playoff rank
    #
    # @api private
    # @param conference_record [String, Integer, nil] the conference record
    # @param playoff_rank [Integer, nil] the playoff rank
    # @return [Integer, nil] the conference rank
    def self.parse_conference_rank(conference_record, playoff_rank)
      wins = conference_record.to_s.split("-").first
      (wins.nil? || wins.empty?) ? playoff_rank : wins.to_i
    end
    private_class_method :parse_conference_rank
  end
end
