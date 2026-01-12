require_relative "../../test_helper"

module NBA
  class PlayerDashPtShotsValuesTest < Minitest::Test
    cover PlayerDashPtShots

    def test_overall_parses_player_id
      assert_equal 201_939, overall_stat.player_id
    end

    def test_overall_parses_player_name_last_first
      assert_equal "Curry, Stephen", overall_stat.player_name_last_first
    end

    def test_overall_parses_sort_order
      assert_equal 1, overall_stat.sort_order
    end

    def test_overall_parses_gp
      assert_equal 74, overall_stat.gp
    end

    def test_overall_parses_g
      assert_equal 74, overall_stat.g
    end

    def test_overall_parses_shot_type
      assert_equal "Overall", overall_stat.shot_type
    end

    def test_overall_parses_fga_frequency
      assert_in_delta 1.0, overall_stat.fga_frequency
    end

    def test_overall_parses_fgm
      assert_in_delta 8.5, overall_stat.fgm
    end

    def test_overall_parses_fga
      assert_in_delta 18.2, overall_stat.fga
    end

    def test_overall_parses_fg_pct
      assert_in_delta 0.467, overall_stat.fg_pct
    end

    def test_overall_parses_efg_pct
      assert_in_delta 0.563, overall_stat.efg_pct
    end

    def test_overall_parses_fg2a_frequency
      assert_in_delta 0.45, overall_stat.fg2a_frequency
    end

    def test_overall_parses_fg2m
      assert_in_delta 4.2, overall_stat.fg2m
    end

    def test_overall_parses_fg2a
      assert_in_delta 8.1, overall_stat.fg2a
    end

    def test_overall_parses_fg2_pct
      assert_in_delta 0.519, overall_stat.fg2_pct
    end

    def test_overall_parses_fg3a_frequency
      assert_in_delta 0.55, overall_stat.fg3a_frequency
    end

    def test_overall_parses_fg3m
      assert_in_delta 4.3, overall_stat.fg3m
    end

    def test_overall_parses_fg3a
      assert_in_delta 10.1, overall_stat.fg3a
    end

    def test_overall_parses_fg3_pct
      assert_in_delta 0.426, overall_stat.fg3_pct
    end

    private

    def overall_stat
      stub_request(:get, /playerdashptshots/).to_return(body: overall_response.to_json)
      PlayerDashPtShots.overall(player: 201_939).first
    end

    def overall_response
      {resultSets: [{name: "Overall", headers: headers,
                     rowSet: [[201_939, "Curry, Stephen", 1, 74, 74, "Overall", 1.0, 8.5, 18.2, 0.467,
                       0.563, 0.45, 4.2, 8.1, 0.519, 0.55, 4.3, 10.1, 0.426]]}]}
    end

    def headers
      %w[PLAYER_ID PLAYER_NAME_LAST_FIRST SORT_ORDER GP G SHOT_TYPE FGA_FREQUENCY FGM FGA FG_PCT
        EFG_PCT FG2A_FREQUENCY FG2M FG2A FG2_PCT FG3A_FREQUENCY FG3M FG3A FG3_PCT]
    end
  end
end
