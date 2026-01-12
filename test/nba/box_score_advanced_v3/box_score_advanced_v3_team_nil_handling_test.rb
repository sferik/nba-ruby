require_relative "../../test_helper"
require_relative "../box_score/box_score_v3_test_helpers"

module NBA
  class BoxScoreAdvancedV3TeamNilHandlingTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreAdvancedV3

    def test_team_stats_nil_for_missing_rating_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.min
      assert_nil stat.e_off_rating
      assert_nil stat.off_rating
      assert_nil stat.e_def_rating
      assert_nil stat.def_rating
    end

    def test_team_stats_nil_for_missing_efficiency_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.ast_pct
      assert_nil stat.ast_tov
      assert_nil stat.ast_ratio
      assert_nil stat.oreb_pct
      assert_nil stat.dreb_pct
    end

    def test_team_stats_nil_for_missing_tempo_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.e_pace
      assert_nil stat.pace
      assert_nil stat.pace_per40
      assert_nil stat.poss
      assert_nil stat.pie
    end

    def test_team_stats_nil_for_missing_shooting_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.efg_pct
      assert_nil stat.ts_pct
    end

    def test_team_stats_nil_for_missing_rebound_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.reb_pct
      assert_nil stat.tov_pct
    end

    def test_team_stats_nil_for_missing_net_rating_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.e_net_rating
      assert_nil stat.net_rating
    end

    def test_team_stats_handles_missing_statistics_key
      stub_team_response({teamId: Team::GSW, teamName: "Warriors"})
      stat = BoxScoreAdvancedV3.team_stats(game: "0022400001").first

      assert_nil stat.min
      assert_nil stat.e_off_rating
    end

    def test_team_stats_nil_for_missing_team_identity_keys
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
      BoxScoreAdvancedV3.team_stats(game: "0022400001").first
    end

    def team_stat_with_minimal_data
      stub_team_response({statistics: {minutes: "240:00"}})
      BoxScoreAdvancedV3.team_stats(game: "0022400001").first
    end

    def stub_team_response(team_data)
      response = {
        boxScoreAdvanced: {homeTeam: team_data, awayTeam: nil}
      }
      stub_request(:get, /boxscoreadvancedv3/)
        .to_return(body: response.to_json)
    end
  end
end
