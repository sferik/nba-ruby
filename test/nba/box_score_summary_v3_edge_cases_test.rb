require_relative "../test_helper"

module NBA
  module BoxScoreSummaryV3BaseTestHelpers
    private

    def home_team_data
      {teamId: Team::GSW, teamName: "Warriors", teamCity: "Golden State", teamTricode: "GSW", teamSlug: "warriors",
       teamWins: 1, teamLosses: 0, score: 118, periods: [{period: 1, score: 28}, {period: 2, score: 32},
         {period: 3, score: 25}, {period: 4, score: 33}]}
    end

    def away_team_data
      {teamId: Team::LAL, teamName: "Lakers", teamCity: "Los Angeles", teamTricode: "LAL", teamSlug: "lakers",
       teamWins: 0, teamLosses: 1, score: 109, periods: [{period: 1, score: 25}, {period: 2, score: 28},
         {period: 3, score: 30}, {period: 4, score: 26}]}
    end

    def arena_data
      {arenaId: 10, arenaName: "Chase Center", arenaCity: "San Francisco", arenaState: "CA",
       arenaCountry: "US", arenaTimezone: "America/Los_Angeles"}
    end

    def base_response
      {boxScoreSummary: {gameId: "0022400001", gameCode: "20241022/LALGSW", gameStatus: 3, gameStatusText: "Final",
                         period: 4, gameClock: "PT00M00.00S", gameTimeUTC: "2024-10-23T02:00:00Z",
                         gameEt: "2024-10-22T22:00:00", duration: 138, attendance: 18_064, sellout: "1",
                         arena: arena_data, homeTeam: home_team_data, awayTeam: away_team_data,
                         leadChanges: 12, timesTied: 8, largestLead: 15, officials: []}}
    end
  end

  class BoxScoreSummaryV3NilResponseTest < Minitest::Test
    include BoxScoreSummaryV3BaseTestHelpers

    cover BoxScoreSummaryV3

    def test_returns_nil_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_nil BoxScoreSummaryV3.find(game: "0022400001", client: mock_client)
    end

    def test_returns_nil_when_box_score_summary_key_missing
      stub_request(:get, /boxscoresummaryv3/).to_return(body: {}.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001")
    end

    def test_returns_nil_when_box_score_summary_is_nil
      stub_request(:get, /boxscoresummaryv3/).to_return(body: {boxScoreSummary: nil}.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001")
    end
  end

  class BoxScoreSummaryV3ArenaTest < Minitest::Test
    include BoxScoreSummaryV3BaseTestHelpers

    cover BoxScoreSummaryV3

    def test_handles_missing_arena_key
      response = base_response
      response[:boxScoreSummary].delete(:arena)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").arena_id
    end

    def test_handles_empty_arena_hash
      response = base_response
      response[:boxScoreSummary][:arena] = {}
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").arena_name
    end

    def test_parses_arena_id
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal 10, BoxScoreSummaryV3.find(game: "0022400001").arena_id
    end

    def test_parses_arena_name
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "Chase Center", BoxScoreSummaryV3.find(game: "0022400001").arena_name
    end

    def test_parses_arena_city
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "San Francisco", BoxScoreSummaryV3.find(game: "0022400001").arena_city
    end

    def test_parses_arena_state
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "CA", BoxScoreSummaryV3.find(game: "0022400001").arena_state
    end

    def test_parses_arena_country
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "US", BoxScoreSummaryV3.find(game: "0022400001").arena_country
    end

    def test_parses_arena_timezone
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "America/Los_Angeles", BoxScoreSummaryV3.find(game: "0022400001").arena_timezone
    end
  end

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
