require_relative "box_score_summary_v3_edge_cases_helper"

module NBA
  class BoxScoreSummaryV3TeamTest < Minitest::Test
    include BoxScoreSummaryV3BaseTestHelpers

    cover BoxScoreSummaryV3

    def test_handles_missing_home_team_key
      response = base_response
      response[:boxScoreSummary].delete(:homeTeam)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").home_team_id
    end

    def test_handles_missing_away_team_key
      response = base_response
      response[:boxScoreSummary].delete(:awayTeam)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").away_team_id
    end

    def test_handles_empty_home_team_hash
      response = base_response
      response[:boxScoreSummary][:homeTeam] = {}
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").home_pts
    end

    def test_handles_empty_away_team_hash
      response = base_response
      response[:boxScoreSummary][:awayTeam] = {}
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").away_pts
    end

    def test_parses_home_team_name
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "Warriors", BoxScoreSummaryV3.find(game: "0022400001").home_team_name
    end

    def test_parses_home_team_tricode
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "GSW", BoxScoreSummaryV3.find(game: "0022400001").home_team_tricode
    end

    def test_parses_away_team_name
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "Lakers", BoxScoreSummaryV3.find(game: "0022400001").away_team_name
    end

    def test_parses_away_team_tricode
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "LAL", BoxScoreSummaryV3.find(game: "0022400001").away_team_tricode
    end

    def test_parses_home_team_id
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal Team::GSW, BoxScoreSummaryV3.find(game: "0022400001").home_team_id
    end

    def test_parses_away_team_id
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal Team::LAL, BoxScoreSummaryV3.find(game: "0022400001").away_team_id
    end

    def test_parses_home_team_city
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "Golden State", BoxScoreSummaryV3.find(game: "0022400001").home_team_city
    end

    def test_parses_away_team_city
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "Los Angeles", BoxScoreSummaryV3.find(game: "0022400001").away_team_city
    end

    def test_parses_home_team_slug
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "warriors", BoxScoreSummaryV3.find(game: "0022400001").home_team_slug
    end

    def test_parses_away_team_slug
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "lakers", BoxScoreSummaryV3.find(game: "0022400001").away_team_slug
    end

    def test_parses_home_team_wins
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal 1, BoxScoreSummaryV3.find(game: "0022400001").home_team_wins
    end

    def test_parses_away_team_wins
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal 0, BoxScoreSummaryV3.find(game: "0022400001").away_team_wins
    end

    def test_parses_home_team_losses
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal 0, BoxScoreSummaryV3.find(game: "0022400001").home_team_losses
    end

    def test_parses_away_team_losses
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal 1, BoxScoreSummaryV3.find(game: "0022400001").away_team_losses
    end

    def test_parses_home_pts
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal 118, BoxScoreSummaryV3.find(game: "0022400001").home_pts
    end

    def test_parses_away_pts
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal 109, BoxScoreSummaryV3.find(game: "0022400001").away_pts
    end
  end
end
