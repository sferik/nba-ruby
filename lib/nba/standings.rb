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
      {team_id: data["TeamID"], team_name: data["TeamName"],
       conference: data["Conference"], division: data["Division"]}
    end
    private_class_method :team_info

    # Extracts record information from data
    # @api private
    # @return [Hash]
    def self.record_info(data)
      {wins: data["WINS"], losses: data["LOSSES"], win_pct: data["WinPCT"],
       conference_rank: parse_conference_rank(data["ConferenceRecord"], data["PlayoffRank"]),
       home_record: data["HOME"], road_record: data["ROAD"], streak: data["strCurrentStreak"]}
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
