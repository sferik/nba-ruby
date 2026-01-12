require_relative "../../test_helper"
require_relative "../box_score/box_score_v3_test_helpers"

module NBA
  class BoxScoreAdvancedV3TeamEfficiencyTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreAdvancedV3

    def test_team_stats_parses_assist_efficiency
      stub_advanced_v3_request

      stat = BoxScoreAdvancedV3.team_stats(game: "0022400001").first

      assert_in_delta 60.0, stat.ast_pct
      assert_in_delta 2.0, stat.ast_tov
      assert_in_delta 20.0, stat.ast_ratio
    end

    def test_team_stats_parses_rebound_efficiency
      stub_advanced_v3_request

      stat = BoxScoreAdvancedV3.team_stats(game: "0022400001").first

      assert_in_delta 25.0, stat.oreb_pct
      assert_in_delta 75.0, stat.dreb_pct
      assert_in_delta 50.0, stat.reb_pct
      assert_in_delta 12.0, stat.tov_pct
    end

    def test_team_stats_parses_shooting_efficiency
      stub_advanced_v3_request

      stat = BoxScoreAdvancedV3.team_stats(game: "0022400001").first

      assert_in_delta 0.55, stat.efg_pct
      assert_in_delta 0.58, stat.ts_pct
      assert_in_delta 50.0, stat.pie
    end

    private

    def stub_advanced_v3_request
      stub_request(:get, /boxscoreadvancedv3.*GameID=0022400001/)
        .to_return(body: advanced_v3_response.to_json)
    end

    def advanced_v3_response
      {boxScoreAdvanced: {homeTeam: home_team_data, awayTeam: away_team_data}}
    end

    def home_team_data
      {teamId: Team::GSW, teamName: "Warriors", teamTricode: "GSW",
       teamCity: "Golden State", statistics: team_advanced_stats,
       players: [player_advanced_data]}
    end

    def away_team_data
      {teamId: Team::LAL, teamName: "Lakers", teamTricode: "LAL",
       teamCity: "Los Angeles", statistics: team_advanced_stats, players: []}
    end
  end
end
