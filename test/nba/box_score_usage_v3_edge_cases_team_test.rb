require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreUsageV3EdgeCasesTeamTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreUsageV3

    def test_team_stats_with_period_params
      stub_request(:get, /boxscoreusagev3.*GameID=0022400001/)
        .to_return(body: usage_v3_response.to_json)

      BoxScoreUsageV3.team_stats(game: "0022400001", start_period: 1, end_period: 2)

      assert_requested :get, /boxscoreusagev3.*StartPeriod=1/
      assert_requested :get, /boxscoreusagev3.*EndPeriod=2/
    end

    def test_team_stats_uses_default_period_params
      stub_request(:get, /boxscoreusagev3.*GameID=0022400001/)
        .to_return(body: usage_v3_response.to_json)

      BoxScoreUsageV3.team_stats(game: "0022400001")

      assert_requested :get, /boxscoreusagev3.*StartPeriod=0/
      assert_requested :get, /boxscoreusagev3.*EndPeriod=0/
    end

    def test_team_stats_accepts_game_object
      stub_request(:get, /boxscoreusagev3.*GameID=0022400001/)
        .to_return(body: usage_v3_response.to_json)
      game = Game.new(id: "0022400001")

      BoxScoreUsageV3.team_stats(game: game)

      assert_requested :get, /boxscoreusagev3.*GameID=0022400001/
    end

    def test_team_stats_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, BoxScoreUsageV3.team_stats(game: "0022400001", client: mock_client).size
      mock_client.verify
    end

    def test_team_stats_returns_empty_when_no_box_score
      stub_request(:get, /boxscoreusagev3/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreUsageV3.team_stats(game: "0022400001").size
    end

    def test_handles_nil_away_team
      home_team = {teamId: Team::GSW, teamName: "Warriors", statistics: usage_team_stats}
      response = {boxScoreUsage: {homeTeam: home_team, awayTeam: nil}}
      stub_request(:get, /boxscoreusagev3/).to_return(body: response.to_json)

      assert_equal 1, BoxScoreUsageV3.team_stats(game: "0022400001").size
    end

    def test_handles_missing_home_team_for_teams
      away_team = {teamId: Team::LAL, teamName: "Lakers", statistics: usage_team_stats}
      response = {boxScoreUsage: {awayTeam: away_team}}
      stub_request(:get, /boxscoreusagev3/).to_return(body: response.to_json)

      assert_equal 1, BoxScoreUsageV3.team_stats(game: "0022400001").size
    end

    private

    def usage_v3_response
      {boxScoreUsage: {homeTeam: home_team_data, awayTeam: away_team_data}}
    end

    def home_team_data
      {teamId: Team::GSW, teamName: "Warriors", teamTricode: "GSW",
       teamCity: "Golden State", statistics: usage_team_stats,
       players: [usage_player_data]}
    end

    def away_team_data
      {teamId: Team::LAL, teamName: "Lakers", teamTricode: "LAL",
       teamCity: "Los Angeles", statistics: usage_team_stats, players: []}
    end
  end
end
