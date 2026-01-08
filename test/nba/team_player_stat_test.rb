require_relative "../test_helper"

module NBA
  class TeamPlayerStatTest < Minitest::Test
    cover TeamPlayerStat

    def test_equality_based_on_player_id_and_gp
      stat1 = TeamPlayerStat.new(player_id: 201_939, gp: 74)
      stat2 = TeamPlayerStat.new(player_id: 201_939, gp: 74)

      assert_equal stat1, stat2
    end

    def test_inequality_when_player_id_differs
      stat1 = TeamPlayerStat.new(player_id: 201_939, gp: 74)
      stat2 = TeamPlayerStat.new(player_id: 201_566, gp: 74)

      refute_equal stat1, stat2
    end

    def test_inequality_when_gp_differs
      stat1 = TeamPlayerStat.new(player_id: 201_939, gp: 74)
      stat2 = TeamPlayerStat.new(player_id: 201_939, gp: 82)

      refute_equal stat1, stat2
    end

    def test_group_set_attribute
      stat = TeamPlayerStat.new(group_set: "PlayersSeasonTotals")

      assert_equal "PlayersSeasonTotals", stat.group_set
    end

    def test_player_name_attribute
      stat = TeamPlayerStat.new(player_name: "Stephen Curry")

      assert_equal "Stephen Curry", stat.player_name
    end

    def test_record_attributes
      stat = TeamPlayerStat.new(w: 46, l: 28, w_pct: 0.622)

      assert_equal 46, stat.w
      assert_equal 28, stat.l
      assert_in_delta 0.622, stat.w_pct
    end

    def test_field_goal_attributes
      stat = TeamPlayerStat.new(fgm: 10.0, fga: 19.6, fg_pct: 0.451)

      assert_in_delta 10.0, stat.fgm
      assert_in_delta 19.6, stat.fga
      assert_in_delta 0.451, stat.fg_pct
    end

    def test_three_point_attributes
      stat = TeamPlayerStat.new(fg3m: 4.8, fg3a: 11.7, fg3_pct: 0.408)

      assert_in_delta 4.8, stat.fg3m
      assert_in_delta 11.7, stat.fg3a
      assert_in_delta 0.408, stat.fg3_pct
    end

    def test_free_throw_attributes
      stat = TeamPlayerStat.new(ftm: 4.8, fta: 5.1, ft_pct: 0.921)

      assert_in_delta 4.8, stat.ftm
      assert_in_delta 5.1, stat.fta
      assert_in_delta 0.921, stat.ft_pct
    end

    def test_rebound_attributes
      stat = TeamPlayerStat.new(oreb: 0.7, dreb: 4.5, reb: 5.1)

      assert_in_delta 0.7, stat.oreb
      assert_in_delta 4.5, stat.dreb
      assert_in_delta 5.1, stat.reb
    end

    def test_playmaking_attributes
      stat = TeamPlayerStat.new(ast: 5.1, tov: 2.8, stl: 0.7, blk: 0.4)

      assert_in_delta 5.1, stat.ast
      assert_in_delta 2.8, stat.tov
      assert_in_delta 0.7, stat.stl
      assert_in_delta 0.4, stat.blk
    end

    def test_misc_counting_attributes
      stat = TeamPlayerStat.new(blka: 0.3, pf: 1.6, pfd: 1.9, pts: 26.4)

      assert_in_delta 0.3, stat.blka
      assert_in_delta 1.6, stat.pf
      assert_in_delta 1.9, stat.pfd
      assert_in_delta 26.4, stat.pts
    end

    def test_plus_minus_attribute
      stat = TeamPlayerStat.new(plus_minus: 7.8)

      assert_in_delta 7.8, stat.plus_minus
    end

    def test_bonus_attributes
      stat = TeamPlayerStat.new(nba_fantasy_pts: 45.2, dd2: 10, td3: 2)

      assert_in_delta 45.2, stat.nba_fantasy_pts
      assert_equal 10, stat.dd2
      assert_equal 2, stat.td3
    end

    def test_min_attribute
      stat = TeamPlayerStat.new(min: 32.7)

      assert_in_delta 32.7, stat.min
    end

    def test_player_method_returns_player
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)
      stat = TeamPlayerStat.new(player_id: 201_939)

      result = stat.player

      assert_kind_of Player, result
    end

    private

    def player_response
      {
        resultSets: [{
          name: "CommonPlayerInfo",
          headers: %w[PERSON_ID FIRST_NAME LAST_NAME DISPLAY_FIRST_LAST],
          rowSet: [[201_939, "Stephen", "Curry", "Stephen Curry"]]
        }]
      }
    end
  end
end
