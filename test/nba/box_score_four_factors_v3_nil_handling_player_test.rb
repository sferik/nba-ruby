require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreFourFactorsV3NilHandlingPlayerTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreFourFactorsV3

    def test_player_stats_nil_for_missing_basic_stat_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.min
      assert_nil stat.efg_pct
      assert_nil stat.fta_rate
    end

    def test_player_stats_nil_for_missing_factor_stat_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.tov_pct
      assert_nil stat.oreb_pct
    end

    def test_player_stats_nil_for_missing_opponent_efg_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.opp_efg_pct
      assert_nil stat.opp_fta_rate
    end

    def test_player_stats_nil_for_missing_opponent_factor_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.opp_tov_pct
      assert_nil stat.opp_oreb_pct
    end

    def test_player_stats_handles_missing_statistics_key
      stub_player_response({personId: 201_939, firstName: "Stephen", familyName: "Curry"})
      stat = BoxScoreFourFactorsV3.player_stats(game: "0022400001").first

      assert_nil stat.min
      assert_nil stat.efg_pct
    end

    def test_player_stats_nil_for_missing_player_keys
      stat = player_stat_with_minimal_data

      assert_nil stat.team_id
      assert_nil stat.team_abbreviation
      assert_nil stat.team_city
      assert_nil stat.player_id
      assert_equal "", stat.player_name
    end

    private

    def player_stat_with_empty_stats
      stub_player_response(
        {personId: 201_939, firstName: "Stephen",
         familyName: "Curry", teamId: Team::GSW, statistics: {}}
      )
      BoxScoreFourFactorsV3.player_stats(game: "0022400001").first
    end

    def player_stat_with_minimal_data
      stub_player_response({statistics: {minutes: "32:45"}})
      BoxScoreFourFactorsV3.player_stats(game: "0022400001").first
    end

    def stub_player_response(player_data)
      response = {
        boxScoreFourFactors: {
          homeTeam: {players: [player_data]},
          awayTeam: {players: []}
        }
      }
      stub_request(:get, /boxscorefourfactorsv3/)
        .to_return(body: response.to_json)
    end
  end
end
