require_relative "../test_helper"

module NBA
  class VsPlayerStatTest < Minitest::Test
    cover VsPlayerStat

    def test_player_id
      assert_equal 201_939, VsPlayerStat.new(player_id: 201_939).player_id
    end

    def test_vs_player_id
      assert_equal 201_566, VsPlayerStat.new(vs_player_id: 201_566).vs_player_id
    end

    def test_court_status
      assert_equal "On", VsPlayerStat.new(court_status: "On").court_status
    end

    def test_gp
      assert_equal 24, VsPlayerStat.new(gp: 24).gp
    end

    def test_min
      assert_in_delta 32.5, VsPlayerStat.new(min: 32.5).min
    end

    def test_pts
      assert_in_delta 26.4, VsPlayerStat.new(pts: 26.4).pts
    end

    def test_reb
      assert_in_delta 5.7, VsPlayerStat.new(reb: 5.7).reb
    end

    def test_ast
      assert_in_delta 6.1, VsPlayerStat.new(ast: 6.1).ast
    end

    def test_stl
      assert_in_delta 1.2, VsPlayerStat.new(stl: 1.2).stl
    end

    def test_blk
      assert_in_delta 0.3, VsPlayerStat.new(blk: 0.3).blk
    end

    def test_tov
      assert_in_delta 3.1, VsPlayerStat.new(tov: 3.1).tov
    end

    def test_fg_pct
      assert_in_delta 0.467, VsPlayerStat.new(fg_pct: 0.467).fg_pct
    end

    def test_plus_minus
      assert_in_delta 8.5, VsPlayerStat.new(plus_minus: 8.5).plus_minus
    end

    def test_player
      stat = VsPlayerStat.new(player_id: 201_939)
      stub_request(:get, /commonplayerinfo.*PlayerID=201939/).to_return(body: player_response(201_939).to_json)

      assert_instance_of Player, stat.player
    end

    def test_vs_player
      stat = VsPlayerStat.new(vs_player_id: 201_566)
      stub_request(:get, /commonplayerinfo.*PlayerID=201566/).to_return(body: player_response(201_566).to_json)

      assert_instance_of Player, stat.vs_player
    end

    def test_equality
      stat1 = VsPlayerStat.new(player_id: 201_939, vs_player_id: 201_566)
      stat2 = VsPlayerStat.new(player_id: 201_939, vs_player_id: 201_566)

      assert_equal stat1, stat2
    end

    def test_inequality_by_player_id
      stat1 = VsPlayerStat.new(player_id: 201_939, vs_player_id: 201_566)
      stat2 = VsPlayerStat.new(player_id: 202_691, vs_player_id: 201_566)

      refute_equal stat1, stat2
    end

    def test_on_court_returns_true_when_court_status_is_on
      stat = VsPlayerStat.new(court_status: "On")

      assert_predicate stat, :on_court?
    end

    def test_on_court_returns_false_when_court_status_is_off
      stat = VsPlayerStat.new(court_status: "Off")

      refute_predicate stat, :on_court?
    end

    def test_off_court_returns_true_when_court_status_is_off
      stat = VsPlayerStat.new(court_status: "Off")

      assert_predicate stat, :off_court?
    end

    def test_off_court_returns_false_when_court_status_is_on
      stat = VsPlayerStat.new(court_status: "On")

      refute_predicate stat, :off_court?
    end

    private

    def player_response(id)
      {resultSets: [{name: "CommonPlayerInfo",
                     headers: %w[PERSON_ID DISPLAY_FIRST_LAST TEAM_ID TEAM_NAME TEAM_ABBREVIATION],
                     rowSet: [[id, "Player", 1_610_612_744, "Golden State Warriors", "GSW"]]}]}
    end
  end
end
