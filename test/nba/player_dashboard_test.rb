require_relative "../test_helper"

module NBA
  class PlayerDashboardTest < Minitest::Test
    cover PlayerDashboard

    def test_general_splits_parses_identity_attributes
      stat = general_splits_stat

      assert_equal "OverallPlayerDashboard", stat.group_set
      assert_equal "Overall", stat.group_value
      assert_equal 201_939, stat.player_id
      assert_equal 82, stat.gp
      assert_in_delta 34.5, stat.min
    end

    def test_general_splits_parses_record_attributes
      stat = general_splits_stat

      assert_equal 50, stat.w
      assert_equal 32, stat.l
      assert_in_delta 0.610, stat.w_pct
    end

    def test_general_splits_parses_field_goal_attributes
      stat = general_splits_stat

      assert_in_delta 10.5, stat.fgm
      assert_in_delta 21.2, stat.fga
      assert_in_delta 0.495, stat.fg_pct
    end

    def test_general_splits_parses_three_point_attributes
      stat = general_splits_stat

      assert_in_delta 5.5, stat.fg3m
      assert_in_delta 11.8, stat.fg3a
      assert_in_delta 0.466, stat.fg3_pct
    end

    def test_general_splits_parses_free_throw_attributes
      stat = general_splits_stat

      assert_in_delta 5.0, stat.ftm
      assert_in_delta 5.5, stat.fta
      assert_in_delta 0.909, stat.ft_pct
    end

    def test_general_splits_parses_rebound_attributes
      stat = general_splits_stat

      assert_in_delta 0.5, stat.oreb
      assert_in_delta 5.5, stat.dreb
      assert_in_delta 6.0, stat.reb
    end

    def test_general_splits_parses_playmaking_attributes
      stat = general_splits_stat

      assert_in_delta 5.5, stat.ast
      assert_in_delta 2.5, stat.tov
    end

    def test_general_splits_parses_defensive_attributes
      stat = general_splits_stat

      assert_in_delta 1.0, stat.stl
      assert_in_delta 0.5, stat.blk
      assert_in_delta 0.2, stat.blka
    end

    def test_general_splits_parses_foul_attributes
      stat = general_splits_stat

      assert_in_delta 2.0, stat.pf
      assert_in_delta 3.5, stat.pfd
    end

    def test_general_splits_parses_scoring_attributes
      stat = general_splits_stat

      assert_in_delta 31.5, stat.pts
      assert_in_delta 8.5, stat.plus_minus
    end

    private

    def general_splits_stat
      stub_dashboard_request("playerdashboardbygeneralsplits")
      PlayerDashboard.general_splits(player: 201_939).first
    end

    def stub_dashboard_request(endpoint)
      response = {
        resultSets: [{
          name: "OverallPlayerDashboard",
          headers: %w[GROUP_VALUE GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
            FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS],
          rowSet: [["Overall", 82, 50, 32, 0.610, 34.5, 10.5, 21.2, 0.495, 5.5, 11.8, 0.466,
            5.0, 5.5, 0.909, 0.5, 5.5, 6.0, 5.5, 2.5, 1.0, 0.5, 0.2, 2.0, 3.5, 31.5, 8.5]]
        }]
      }
      stub_request(:get, /#{endpoint}.*PlayerID=201939/).to_return(body: response.to_json)
    end
  end
end
