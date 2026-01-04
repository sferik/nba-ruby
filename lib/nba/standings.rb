require_relative "client"
require_relative "response_parser"
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
      path = "leaguestandings?LeagueID=00&Season=#{Utils.format_season(season)}&SeasonType=Regular+Season"
      ResponseParser.parse(client.get(path)) { |data| build_standing(data) }
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
      Collection.new(all(season: season, client: client).select { |s| s.conference.eql?(conference_name) })
    end

    # Builds a standing from API data
    # @api private
    # @return [Standing]
    def self.build_standing(data)
      Standing.new(**team_info(data), **record_info(data))
    end
    private_class_method :build_standing

    # Extracts team information from data
    # @api private
    # @return [Hash]
    def self.team_info(data)
      {team_id: data.fetch("TeamID", nil), team_name: data.fetch("TeamName", nil),
       conference: data.fetch("Conference", nil), division: data.fetch("Division", nil)}
    end
    private_class_method :team_info

    # Extracts record information from data
    # @api private
    # @return [Hash]
    def self.record_info(data)
      {wins: data.fetch("WINS", nil), losses: data.fetch("LOSSES", nil), win_pct: data.fetch("WinPCT", nil),
       conference_rank: parse_conference_rank(data.fetch("ConferenceRecord", nil), data.fetch("PlayoffRank", nil)),
       home_record: data.fetch("HOME", nil), road_record: data.fetch("ROAD", nil), streak: data.fetch("strCurrentStreak", nil)}
    end
    private_class_method :record_info

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
