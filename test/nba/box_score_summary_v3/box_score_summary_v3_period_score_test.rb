require_relative "box_score_summary_v3_edge_cases_helper"

module NBA
  class BoxScoreSummaryV3PeriodScoreTest < Minitest::Test
    include BoxScoreSummaryV3BaseTestHelpers

    cover BoxScoreSummaryV3

    def test_handles_missing_periods_array
      response = base_response
      response[:boxScoreSummary][:homeTeam].delete(:periods)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").home_pts_q1
    end

    def test_handles_empty_periods_array
      response = base_response
      response[:boxScoreSummary][:homeTeam][:periods] = []
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").home_pts_q1
    end

    def test_handles_partial_periods
      response = base_response
      response[:boxScoreSummary][:homeTeam][:periods] = [{period: 1, score: 28}, {period: 2, score: 32}]
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)
      summary = BoxScoreSummaryV3.find(game: "0022400001")

      assert_equal 28, summary.home_pts_q1
      assert_nil summary.home_pts_q3
    end

    def test_parses_home_period_scores
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)
      summary = BoxScoreSummaryV3.find(game: "0022400001")

      assert_equal 28, summary.home_pts_q1
      assert_equal 32, summary.home_pts_q2
    end

    def test_parses_away_period_scores
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)
      summary = BoxScoreSummaryV3.find(game: "0022400001")

      assert_equal 25, summary.away_pts_q1
      assert_equal 28, summary.away_pts_q2
    end

    def test_parses_home_pts_q3
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal 25, BoxScoreSummaryV3.find(game: "0022400001").home_pts_q3
    end

    def test_parses_home_pts_q4
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal 33, BoxScoreSummaryV3.find(game: "0022400001").home_pts_q4
    end

    def test_parses_away_pts_q3
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal 30, BoxScoreSummaryV3.find(game: "0022400001").away_pts_q3
    end

    def test_parses_away_pts_q4
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal 26, BoxScoreSummaryV3.find(game: "0022400001").away_pts_q4
    end

    def test_handles_period_without_period_key
      response = base_response
      response[:boxScoreSummary][:homeTeam][:periods] = [{score: 28}]
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").home_pts_q1
    end

    def test_handles_period_without_score_key
      response = base_response
      response[:boxScoreSummary][:homeTeam][:periods] = [{period: 1}]
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").home_pts_q1
    end
  end
end
