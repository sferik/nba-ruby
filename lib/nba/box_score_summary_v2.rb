require "json"
require_relative "client"
require_relative "box_score_summary"
require_relative "utils"

module NBA
  # Provides methods to retrieve game summary information
  module BoxScoreSummaryV2
    # Result set name for game summary
    # @return [String] the result set name
    GAME_SUMMARY = "GameSummary".freeze

    # Result set name for line score
    # @return [String] the result set name
    LINE_SCORE = "LineScore".freeze

    # Result set name for officials
    # @return [String] the result set name
    OFFICIALS = "Officials".freeze

    # Result set name for other stats
    # @return [String] the result set name
    OTHER_STATS = "OtherStats".freeze

    # Retrieves game summary information
    #
    # @api public
    # @example
    #   summary = NBA::BoxScoreSummaryV2.find(game: "0022400001")
    #   puts "#{summary.home_team.full_name} #{summary.home_pts} - #{summary.visitor_pts} #{summary.visitor_team.full_name}"
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [BoxScoreSummary, nil] the game summary
    def self.find(game:, client: CLIENT)
      game_id = Utils.extract_id(game)
      path = "boxscoresummaryv2?GameID=#{game_id}"
      response = client.get(path)
      parse_response(response, game_id)
    end

    # Parses the API response
    # @api private
    # @param response [String, nil] the JSON response
    # @param game_id [String] the game ID
    # @return [BoxScoreSummary, nil] the game summary
    def self.parse_response(response, game_id)
      return unless response

      data = JSON.parse(response)
      game_summary = find_result_set(data, GAME_SUMMARY)
      return unless game_summary

      line_scores = find_result_set(data, LINE_SCORE)
      officials = find_result_set(data, OFFICIALS)
      other_stats = find_result_set(data, OTHER_STATS)

      build_summary(game_summary, line_scores, officials, other_stats, game_id)
    end
    private_class_method :parse_response

    # Finds a result set by name
    # @api private
    # @param data [Hash] the parsed JSON
    # @param name [String] the result set name
    # @return [Hash, nil] the result set
    def self.find_result_set(data, name)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name").eql?(name) }
    end
    private_class_method :find_result_set

    # Builds the summary object
    # @api private
    # @param game_summary [Hash] game summary result set
    # @param line_scores [Hash] line score result set
    # @param officials [Hash] officials result set
    # @param other_stats [Hash] other stats result set
    # @param game_id [String] the game ID
    # @return [BoxScoreSummary, nil] the summary
    def self.build_summary(game_summary, line_scores, officials, other_stats, game_id)
      summary_row = extract_first_row(game_summary)
      return unless summary_row

      home_line, visitor_line = extract_line_scores(line_scores)
      attrs = game_attributes(summary_row, game_id)
      attrs = attrs.merge(home_score_attributes(home_line))
      attrs = attrs.merge(visitor_score_attributes(visitor_line))
      attrs = attrs.merge(officials: extract_officials(officials))
      attrs = attrs.merge(other_attributes(extract_other_stats(other_stats)))
      BoxScoreSummary.new(**attrs)
    end
    private_class_method :build_summary

    # Extracts the first row from a result set
    # @api private
    # @param result_set [Hash] the result set
    # @return [Hash, nil] the first row as a hash
    def self.extract_first_row(result_set)
      headers = result_set["headers"]
      row = result_set.dig("rowSet", 0)
      return unless headers && row

      headers.zip(row).to_h
    end
    private_class_method :extract_first_row

    # Extracts line scores for home and visitor
    # @api private
    # @param line_scores [Hash] line score result set
    # @return [Array<Hash, Hash>] home and visitor line scores
    def self.extract_line_scores(line_scores)
      return [{}, {}] unless line_scores

      headers = line_scores["headers"]
      rows = line_scores["rowSet"]
      return [{}, {}] unless headers && rows && rows.size >= 2

      [headers.zip(rows.fetch(1)).to_h, headers.zip(rows.fetch(0)).to_h]
    end
    private_class_method :extract_line_scores

    # Extracts official names
    # @api private
    # @param officials [Hash] officials result set
    # @return [Array<String>] official names
    def self.extract_officials(officials)
      return [] unless officials

      headers = officials["headers"]
      rows = officials["rowSet"]
      return [] unless headers && rows

      first_name_idx = headers.index("FIRST_NAME")
      last_name_idx = headers.index("LAST_NAME")
      return [] unless first_name_idx && last_name_idx

      rows.map { |row| "#{row.fetch(first_name_idx)} #{row.fetch(last_name_idx)}" }
    end
    private_class_method :extract_officials

    # Extracts other stats
    # @api private
    # @param other_stats [Hash] other stats result set
    # @return [Hash] other stats hash
    def self.extract_other_stats(other_stats)
      return {} unless other_stats

      headers = other_stats["headers"]
      row = other_stats.dig("rowSet", 0)
      return {} unless headers && row

      headers.zip(row).to_h
    end
    private_class_method :extract_other_stats

    # Extracts game attributes
    # @api private
    # @param data [Hash] the summary data
    # @param game_id [String] the game ID
    # @return [Hash] game attributes
    def self.game_attributes(data, game_id)
      {game_id: game_id, game_date: data.fetch("GAME_DATE_EST"), game_status_id: data.fetch("GAME_STATUS_ID"),
       game_status_text: data.fetch("GAME_STATUS_TEXT"), home_team_id: data.fetch("HOME_TEAM_ID"),
       visitor_team_id: data.fetch("VISITOR_TEAM_ID"), season: data.fetch("SEASON"),
       live_period: data.fetch("LIVE_PERIOD"), live_pc_time: data.fetch("LIVE_PC_TIME"),
       attendance: data.fetch("ATTENDANCE"), game_time: data.fetch("GAME_TIME")}
    end
    private_class_method :game_attributes

    # Extracts home score attributes
    # @api private
    # @param data [Hash] the line score data
    # @return [Hash] home score attributes
    def self.home_score_attributes(data)
      {home_pts_q1: data["PTS_QTR1"], home_pts_q2: data["PTS_QTR2"], home_pts_q3: data["PTS_QTR3"],
       home_pts_q4: data["PTS_QTR4"], home_pts_ot: data["PTS_OT1"], home_pts: data["PTS"]}
    end
    private_class_method :home_score_attributes

    # Extracts visitor score attributes
    # @api private
    # @param data [Hash] the line score data
    # @return [Hash] visitor score attributes
    def self.visitor_score_attributes(data)
      {visitor_pts_q1: data["PTS_QTR1"], visitor_pts_q2: data["PTS_QTR2"],
       visitor_pts_q3: data["PTS_QTR3"], visitor_pts_q4: data["PTS_QTR4"],
       visitor_pts_ot: data["PTS_OT1"], visitor_pts: data["PTS"]}
    end
    private_class_method :visitor_score_attributes

    # Extracts other stats attributes
    # @api private
    # @param data [Hash] the other stats data
    # @return [Hash] other stats attributes
    def self.other_attributes(data)
      {lead_changes: data["LEAD_CHANGES"], times_tied: data["TIMES_TIED"], arena: data["ARENA"]}
    end
    private_class_method :other_attributes
  end
end
