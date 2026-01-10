require "json"
require_relative "client"
require_relative "collection"
require_relative "ist_standing"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Provides methods to retrieve NBA In-Season Tournament standings
  module IstStandings
    # Result set name for IST standings
    # @return [String] the result set name
    RESULT_SET = "Standings".freeze

    # Retrieves In-Season Tournament standings for a season
    #
    # @api public
    # @example
    #   standings = NBA::IstStandings.all(season: 2023)
    #   standings.each { |s| puts "#{s.team_name}: #{s.wins}-#{s.losses}" }
    # @param season [Integer] the season year (defaults to current season)
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of IST standings
    def self.all(season: Utils.current_season, league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      path = build_path(season, league_id)
      ResponseParser.parse(client.get(path), result_set: RESULT_SET) { |data| build_standing(data) }
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(season, league_id)
      "iststandings?LeagueID=#{league_id}&Season=#{Utils.format_season(season)}"
    end
    private_class_method :build_path

    # Builds an IstStanding object from raw data
    # @api private
    # @param data [Hash] the row data
    # @return [IstStanding] the standing object
    def self.build_standing(data)
      IstStanding.new(**team_attrs(data), **record_attrs(data), **pts_attrs(data))
    end
    private_class_method :build_standing

    # Extracts team attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] team attributes
    def self.team_attrs(data)
      {season_id: data.fetch("SEASON_ID", nil), team_id: data.fetch("TEAM_ID", nil),
       team_city: data.fetch("TEAM_CITY", nil), team_name: data.fetch("TEAM_NAME", nil),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil), team_slug: data.fetch("TEAM_SLUG", nil),
       conference: data.fetch("CONFERENCE", nil), ist_group: data.fetch("IST_GROUP", nil)}
    end
    private_class_method :team_attrs

    # Extracts record attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] record attributes
    def self.record_attrs(data)
      {ist_group_rank: data.fetch("IST_GROUP_RANK", nil), wins: data.fetch("WINS", nil),
       losses: data.fetch("LOSSES", nil), win_pct: data.fetch("WIN_PCT", nil),
       clinch_indicator: data.fetch("CLINCH_INDICATOR", nil)}
    end
    private_class_method :record_attrs

    # Extracts point attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] point attributes
    def self.pts_attrs(data)
      {pts_for: data.fetch("PTS_FOR", nil), pts_against: data.fetch("PTS_AGAINST", nil),
       pts_diff: data.fetch("PTS_DIFF", nil)}
    end
    private_class_method :pts_attrs
  end
end
