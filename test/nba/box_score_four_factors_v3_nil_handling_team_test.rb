require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreFourFactorsV3NilHandlingTeamTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreFourFactorsV3

    def test_team_stats_nil_for_missing_basic_stat_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.min
      assert_nil stat.efg_pct
      assert_nil stat.fta_rate
    end

    def test_team_stats_nil_for_missing_factor_stat_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.tov_pct
      assert_nil stat.oreb_pct
    end

    def test_team_stats_nil_for_missing_opponent_efg_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.opp_efg_pct
      assert_nil stat.opp_fta_rate
    end

    def test_team_stats_nil_for_missing_opponent_factor_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.opp_tov_pct
      assert_nil stat.opp_oreb_pct
    end

    def test_team_stats_handles_missing_statistics_key
      stub_team_response({teamId: Team::GSW, teamName: "Warriors"})
      stat = BoxScoreFourFactorsV3.team_stats(game: "0022400001").first

      assert_nil stat.min
      assert_nil stat.efg_pct
    end

    def test_team_stats_nil_for_missing_team_keys
      stat = team_stat_with_minimal_data

      assert_nil stat.team_id
      assert_nil stat.team_name
      assert_nil stat.team_abbreviation
      assert_nil stat.team_city
    end

    private

    def team_stat_with_empty_stats
      stub_team_response(
        {teamId: Team::GSW, teamName: "Warriors", statistics: {}}
      )
      BoxScoreFourFactorsV3.team_stats(game: "0022400001").first
    end

    def team_stat_with_minimal_data
      stub_team_response({statistics: {minutes: "240:00"}})
      BoxScoreFourFactorsV3.team_stats(game: "0022400001").first
    end

    def stub_team_response(team_data)
      response = {
        boxScoreFourFactors: {homeTeam: team_data, awayTeam: nil}
      }
      stub_request(:get, /boxscorefourfactorsv3/)
        .to_return(body: response.to_json)
    end
  end
end
