require_relative "../test_helper"

module NBA
  class ShotStatTest < Minitest::Test
    cover ShotStat

    def test_player_id
      assert_equal 201_939, ShotStat.new(player_id: 201_939).player_id
    end

    def test_player_name_last_first
      assert_equal "Curry, Stephen", ShotStat.new(player_name_last_first: "Curry, Stephen").player_name_last_first
    end

    def test_sort_order
      assert_equal 1, ShotStat.new(sort_order: 1).sort_order
    end

    def test_gp
      assert_equal 74, ShotStat.new(gp: 74).gp
    end

    def test_g
      assert_equal 74, ShotStat.new(g: 74).g
    end

    def test_shot_type
      assert_equal "Overall", ShotStat.new(shot_type: "Overall").shot_type
    end

    def test_fga_frequency
      assert_in_delta 0.15, ShotStat.new(fga_frequency: 0.15).fga_frequency
    end

    def test_fgm
      assert_in_delta 8.5, ShotStat.new(fgm: 8.5).fgm
    end

    def test_fga
      assert_in_delta 18.2, ShotStat.new(fga: 18.2).fga
    end

    def test_fg_pct
      assert_in_delta 0.467, ShotStat.new(fg_pct: 0.467).fg_pct
    end

    def test_efg_pct
      assert_in_delta 0.563, ShotStat.new(efg_pct: 0.563).efg_pct
    end

    def test_fg2a_frequency
      assert_in_delta 0.45, ShotStat.new(fg2a_frequency: 0.45).fg2a_frequency
    end

    def test_fg2m
      assert_in_delta 4.2, ShotStat.new(fg2m: 4.2).fg2m
    end

    def test_fg2a
      assert_in_delta 8.1, ShotStat.new(fg2a: 8.1).fg2a
    end

    def test_fg2_pct
      assert_in_delta 0.519, ShotStat.new(fg2_pct: 0.519).fg2_pct
    end

    def test_fg3a_frequency
      assert_in_delta 0.55, ShotStat.new(fg3a_frequency: 0.55).fg3a_frequency
    end

    def test_fg3m
      assert_in_delta 4.3, ShotStat.new(fg3m: 4.3).fg3m
    end

    def test_fg3a
      assert_in_delta 10.1, ShotStat.new(fg3a: 10.1).fg3a
    end

    def test_fg3_pct
      assert_in_delta 0.426, ShotStat.new(fg3_pct: 0.426).fg3_pct
    end

    def test_player
      stat = ShotStat.new(player_id: 201_939)
      stub_request(:get, /commonplayerinfo.*PlayerID=201939/).to_return(body: player_response.to_json)

      assert_instance_of Player, stat.player
    end

    def test_equality
      stat1 = ShotStat.new(player_id: 201_939, shot_type: "Overall", g: 74)
      stat2 = ShotStat.new(player_id: 201_939, shot_type: "Overall", g: 74)

      assert_equal stat1, stat2
    end

    def test_inequality_by_player_id
      stat1 = ShotStat.new(player_id: 201_939, shot_type: "Overall", g: 74)
      stat2 = ShotStat.new(player_id: 202_691, shot_type: "Overall", g: 74)

      refute_equal stat1, stat2
    end

    private

    def player_response
      {resultSets: [{name: "CommonPlayerInfo",
                     headers: %w[PERSON_ID DISPLAY_FIRST_LAST TEAM_ID TEAM_NAME TEAM_ABBREVIATION],
                     rowSet: [[201_939, "Stephen Curry", 1_610_612_744, "Golden State Warriors", "GSW"]]}]}
    end
  end
end
