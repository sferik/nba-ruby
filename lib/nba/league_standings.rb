require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

require_relative "league_standing"

module NBA
  # Provides methods to retrieve league standings with extended data
  module LeagueStandings
    # Result set name for standings
    # @return [String] the result set name
    STANDINGS = "Standings".freeze

    # Season type constant for regular season
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Retrieves all league standings
    #
    # @api public
    # @example
    #   standings = NBA::LeagueStandings.all(season: 2024)
    #   standings.each { |s| puts "#{s.playoff_rank}. #{s.full_name}: #{s.wins}-#{s.losses}" }
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of standings
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      path = build_path(season, season_type, league_id)
      response = client.get(path)
      parse_response(response)
    end

    # Retrieves standings for a specific conference
    #
    # @api public
    # @example
    #   west = NBA::LeagueStandings.conference("West", season: 2024)
    #   west.each { |s| puts "#{s.playoff_rank}. #{s.full_name}" }
    # @param conference_name [String] the conference name ("East" or "West")
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of standings
    def self.conference(conference_name, season: Utils.current_season, season_type: REGULAR_SEASON, league: League::NBA,
      client: CLIENT)
      all_standings = all(season: season, season_type: season_type, league: league, client: client)
      filtered = all_standings.select { |s| s.conference.eql?(conference_name) }
      Collection.new(filtered)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(season, season_type, league_id)
      season_str = Utils.format_season(season)
      encoded_type = season_type
      "leaguestandingsv3?LeagueID=#{league_id}&Season=#{season_str}&SeasonType=#{encoded_type}"
    end
    private_class_method :build_path

    # Parses the API response into standing objects
    # @api private
    # @return [Collection] collection of standings
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      standings = rows.map { |row| build_standing(headers, row) }
      Collection.new(standings)
    end
    private_class_method :parse_response

    # Finds the standings result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(STANDINGS) }
    end
    private_class_method :find_result_set

    # Builds a LeagueStanding object from raw data
    # @api private
    # @return [LeagueStanding] the standing object
    def self.build_standing(headers, row)
      data = headers.zip(row).to_h
      LeagueStanding.new(**standing_attributes(data))
    end
    private_class_method :build_standing

    # Combines all standing attributes
    # @api private
    # @return [Hash] the combined attributes
    def self.standing_attributes(data)
      identity_attributes(data).merge(record_attributes(data), streak_attributes(data), points_attributes(data))
    end
    private_class_method :standing_attributes

    # Extracts identity attributes from data
    # @api private
    # @return [Hash] identity attributes
    def self.identity_attributes(data)
      {league_id: data.fetch("LeagueID"), season_id: data.fetch("SeasonID"),
       team_id: data.fetch("TeamID"), team_city: data.fetch("TeamCity"),
       team_name: data.fetch("TeamName"), team_slug: data.fetch("TeamSlug"),
       conference: data.fetch("Conference"), division: data.fetch("Division"),
       clinch_indicator: data.fetch("ClinchIndicator")}
    end
    private_class_method :identity_attributes

    # Extracts record attributes from data
    # @api private
    # @return [Hash] record attributes
    def self.record_attributes(data)
      {conference_record: data.fetch("ConferenceRecord"), playoff_rank: data.fetch("PlayoffRank"),
       division_record: data.fetch("DivisionRecord"), division_rank: data.fetch("DivisionRank"),
       wins: data.fetch("WINS"), losses: data.fetch("LOSSES"), win_pct: data.fetch("WinPCT"),
       league_rank: data.fetch("LeagueRank"), record: data.fetch("Record"),
       home_record: data.fetch("HOME"), road_record: data.fetch("ROAD"),
       conference_games_back: data.fetch("ConferenceGamesBack")}
    end
    private_class_method :record_attributes

    # Extracts streak attributes from data
    # @api private
    # @return [Hash] streak attributes
    def self.streak_attributes(data)
      {l10_record: data.fetch("L10"), long_win_streak: data.fetch("LongWinStreak"),
       long_loss_streak: data.fetch("LongLossStreak"), current_streak: data.fetch("CurrentStreak"),
       clinched_conference_title: data.fetch("ClinchedConferenceTitle"),
       clinched_playoff_birth: data.fetch("ClinchedPlayoffBirth"),
       eliminated_conference: data.fetch("EliminatedConference")}
    end
    private_class_method :streak_attributes

    # Extracts points attributes from data
    # @api private
    # @return [Hash] points attributes
    def self.points_attributes(data)
      {points_pg: data.fetch("PointsPG"), opp_points_pg: data.fetch("OppPointsPG"),
       diff_points_pg: data.fetch("DiffPointsPG")}
    end
    private_class_method :points_attributes
  end
end
