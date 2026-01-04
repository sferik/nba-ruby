require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreAdvancedV3PlayerNilHandlingTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreAdvancedV3

    def test_player_stats_nil_for_missing_min_and_offensive_rating_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.min
      assert_nil stat.e_off_rating
      assert_nil stat.off_rating
    end

    def test_player_stats_nil_for_missing_defensive_and_net_rating_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.e_def_rating
      assert_nil stat.def_rating
      assert_nil stat.e_net_rating
      assert_nil stat.net_rating
    end

    def test_player_stats_nil_for_missing_assist_efficiency_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.ast_pct
      assert_nil stat.ast_tov
      assert_nil stat.ast_ratio
    end

    def test_player_stats_nil_for_missing_rebound_efficiency_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.oreb_pct
      assert_nil stat.dreb_pct
      assert_nil stat.reb_pct
      assert_nil stat.tov_pct
    end

    def test_player_stats_nil_for_missing_tempo_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.e_pace
      assert_nil stat.pace
      assert_nil stat.pace_per40
      assert_nil stat.poss
    end

    def test_player_stats_nil_for_missing_usage_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.pie
      assert_nil stat.usg_pct
      assert_nil stat.e_usg_pct
    end

    def test_player_stats_nil_for_missing_shooting_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.efg_pct
      assert_nil stat.ts_pct
    end

    def test_player_stats_nil_for_missing_player_identity_keys
      stat = player_stat_with_minimal_data

      assert_nil stat.team_id
      assert_nil stat.team_abbreviation
      assert_nil stat.team_city
      assert_nil stat.player_id
      assert_equal "", stat.player_name
    end

    def test_player_stats_handles_missing_statistics_key
      stub_player_response({personId: 201_939, firstName: "Stephen", familyName: "Curry"})
      stat = BoxScoreAdvancedV3.player_stats(game: "0022400001").first

      assert_nil stat.min
      assert_nil stat.e_off_rating
    end

    private

    def player_stat_with_empty_stats
      stub_player_response(
        {personId: 201_939, firstName: "Stephen",
         familyName: "Curry", teamId: Team::GSW, statistics: {}}
      )
      BoxScoreAdvancedV3.player_stats(game: "0022400001").first
    end

    def player_stat_with_minimal_data
      stub_player_response({statistics: {minutes: "32:45"}})
      BoxScoreAdvancedV3.player_stats(game: "0022400001").first
    end

    def stub_player_response(player_data)
      response = {
        boxScoreAdvanced: {
          homeTeam: {players: [player_data]},
          awayTeam: {players: []}
        }
      }
      stub_request(:get, /boxscoreadvancedv3/)
        .to_return(body: response.to_json)
    end
  end
end
