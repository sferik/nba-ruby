require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreTraditionalV3EdgeCasesStatsTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreTraditionalV3

    def test_player_stats_with_period_params
      verify_period_params(:player_stats, traditional_v3_response)
    end

    def test_player_stats_uses_default_period_params
      verify_default_period_params(:player_stats, traditional_v3_response)
    end

    def test_team_stats_with_period_params
      verify_period_params(:team_stats, traditional_v3_response)
    end

    def test_team_stats_uses_default_period_params
      verify_default_period_params(:team_stats, traditional_v3_response)
    end

    def test_starter_bench_stats_with_period_params
      verify_period_params(:starter_bench_stats, starter_bench_response)
    end

    def test_starter_bench_stats_uses_default_period_params
      verify_default_period_params(:starter_bench_stats, starter_bench_response)
    end

    def test_player_stats_returns_empty_when_response_is_nil
      verify_empty_when_nil_response(:player_stats)
    end

    def test_team_stats_returns_empty_when_response_is_nil
      verify_empty_when_nil_response(:team_stats)
    end

    def test_starter_bench_stats_returns_empty_when_response_is_nil
      verify_empty_when_nil_response(:starter_bench_stats)
    end

    def test_player_stats_returns_empty_when_no_box_score
      verify_empty_when_no_box_score(:player_stats)
    end

    def test_team_stats_returns_empty_when_no_box_score
      verify_empty_when_no_box_score(:team_stats)
    end

    def test_starter_bench_stats_returns_empty_when_no_box_score
      verify_empty_when_no_box_score(:starter_bench_stats)
    end

    private

    def verify_period_params(method_name, response)
      stub_request(:get, /boxscoretraditionalv3.*GameID=0022400001/)
        .to_return(body: response.to_json)
      BoxScoreTraditionalV3.send(method_name, game: "0022400001", start_period: 1, end_period: 2)

      assert_requested :get, /boxscoretraditionalv3.*StartPeriod=1/
      assert_requested :get, /boxscoretraditionalv3.*EndPeriod=2/
    end

    def verify_default_period_params(method_name, response)
      stub_request(:get, /boxscoretraditionalv3/)
        .to_return(body: response.to_json)
      BoxScoreTraditionalV3.send(method_name, game: "0022400001")

      assert_requested :get, /boxscoretraditionalv3\?.*GameID=0022400001/
      assert_requested :get, /boxscoretraditionalv3\?.*StartPeriod=0/
      assert_requested :get, /boxscoretraditionalv3\?.*EndPeriod=0/
    end

    def verify_empty_when_nil_response(method_name)
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]
      result = BoxScoreTraditionalV3.send(method_name, game: "0022400001", client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def verify_empty_when_no_box_score(method_name)
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreTraditionalV3.send(method_name, game: "0022400001").size
    end

    def traditional_v3_response
      {boxScoreTraditional: {homeTeam: home_team_data, awayTeam: away_team_data}}
    end

    def home_team_data
      {teamId: Team::GSW, teamName: "Warriors", teamTricode: "GSW",
       teamCity: "Golden State", statistics: traditional_team_stats,
       players: [traditional_player_data]}
    end

    def away_team_data
      {teamId: Team::LAL, teamName: "Lakers", teamTricode: "LAL",
       teamCity: "Los Angeles", statistics: traditional_team_stats, players: []}
    end

    def starter_bench_response
      {boxScoreTraditional: {homeTeam: home_team_with_starter_bench, awayTeam: nil}}
    end

    def home_team_with_starter_bench
      {teamId: Team::GSW, teamName: "Warriors", teamTricode: "GSW",
       teamCity: "Golden State",
       statistics: {starters: starter_bench_stats, bench: starter_bench_stats}}
    end
  end
end
