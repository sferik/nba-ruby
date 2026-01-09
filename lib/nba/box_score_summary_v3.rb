require "json"
require_relative "client"
require_relative "box_score_summary_v3_data"
require_relative "utils"

module NBA
  # Provides methods to retrieve game summary information using V3 API
  module BoxScoreSummaryV3
    # Result set name for box score summary
    # @return [String] the result set name
    BOX_SCORE_SUMMARY = "boxScoreSummary".freeze

    # Retrieves game summary information
    #
    # @api public
    # @example
    #   summary = NBA::BoxScoreSummaryV3.find(game: "0022400001")
    #   puts "#{summary.home_team_name} #{summary.home_pts} - #{summary.away_pts} #{summary.away_team_name}"
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [BoxScoreSummaryV3Data, nil] the game summary
    def self.find(game:, client: CLIENT)
      game_id = Utils.extract_id(game)
      response = client.get("boxscoresummaryv3?GameID=#{game_id}")
      parse_response(response, game_id)
    end

    # Parses the API response
    # @api private
    # @return [BoxScoreSummaryV3Data, nil] the game summary
    def self.parse_response(response, game_id)
      return unless response

      box_score = JSON.parse(response).fetch(BOX_SCORE_SUMMARY, nil)
      build_summary(box_score, game_id) if box_score
    end
    private_class_method :parse_response

    # Builds the summary object
    # @api private
    # @return [BoxScoreSummaryV3Data] the summary
    def self.build_summary(box_score, game_id)
      attrs = game_attributes(box_score, game_id).merge(arena_attributes(box_score))
      attrs.merge!(team_attributes(box_score, "homeTeam", "home"))
      attrs.merge!(team_attributes(box_score, "awayTeam", "away"))
      attrs.merge!(other_stats_attributes(box_score))
      BoxScoreSummaryV3Data.new(**attrs, officials: extract_officials(box_score))
    end
    private_class_method :build_summary

    # Extracts game attributes
    # @api private
    # @return [Hash] game attributes
    def self.game_attributes(data, game_id)
      {game_id: game_id, game_code: data.fetch("gameCode", nil), game_status: data.fetch("gameStatus", nil),
       game_status_text: data.fetch("gameStatusText", nil), period: data.fetch("period", nil),
       game_clock: data.fetch("gameClock", nil), game_time_utc: data.fetch("gameTimeUTC", nil),
       game_et: data.fetch("gameEt", nil), duration: data.fetch("duration", nil),
       attendance: data.fetch("attendance", nil), sellout: data.fetch("sellout", nil)}
    end
    private_class_method :game_attributes

    # Extracts arena attributes
    # @api private
    # @return [Hash] arena attributes
    def self.arena_attributes(data)
      arena = data.fetch("arena", {})
      {arena_id: arena.fetch("arenaId", nil), arena_name: arena.fetch("arenaName", nil),
       arena_city: arena.fetch("arenaCity", nil), arena_state: arena.fetch("arenaState", nil),
       arena_country: arena.fetch("arenaCountry", nil), arena_timezone: arena.fetch("arenaTimezone", nil)}
    end
    private_class_method :arena_attributes

    # Extracts team attributes for home or away team
    # @api private
    # @return [Hash] team attributes
    def self.team_attributes(data, team_key, prefix)
      team = data.fetch(team_key, {})
      {"#{prefix}_team_id": team.fetch("teamId", nil), "#{prefix}_team_name": team.fetch("teamName", nil),
       "#{prefix}_team_city": team.fetch("teamCity", nil), "#{prefix}_team_tricode": team.fetch("teamTricode", nil),
       "#{prefix}_team_slug": team.fetch("teamSlug", nil), "#{prefix}_team_wins": team.fetch("teamWins", nil),
       "#{prefix}_team_losses": team.fetch("teamLosses", nil), "#{prefix}_pts": team.fetch("score", nil),
       "#{prefix}_pts_q1": extract_period_score(team, 1), "#{prefix}_pts_q2": extract_period_score(team, 2),
       "#{prefix}_pts_q3": extract_period_score(team, 3), "#{prefix}_pts_q4": extract_period_score(team, 4)}
    end
    private_class_method :team_attributes

    # Extracts period score from team data
    # @api private
    # @return [Integer, nil] period score
    def self.extract_period_score(team, period)
      periods = team.fetch("periods", nil)
      return unless periods

      period_data = periods.find { |p| p.fetch("period", nil).eql?(period) }
      period_data&.fetch("score", nil)
    end
    private_class_method :extract_period_score

    # Extracts other stats attributes
    # @api private
    # @return [Hash] other stats attributes
    def self.other_stats_attributes(data)
      {lead_changes: data.fetch("leadChanges", nil), times_tied: data.fetch("timesTied", nil),
       largest_lead: data.fetch("largestLead", nil)}
    end
    private_class_method :other_stats_attributes

    # Extracts official names
    # @api private
    # @return [Array<String>] official names
    def self.extract_officials(data)
      officials = data.fetch("officials", nil)
      return [] unless officials

      officials.filter_map { |o| "#{o.fetch("firstName")} #{o.fetch("familyName")}" if o["firstName"] && o["familyName"] }
    end
    private_class_method :extract_officials
  end
end
