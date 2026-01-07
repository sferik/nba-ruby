require_relative "../test_helper"

module NBA
  class DefensiveShotStatTest < Minitest::Test
    cover DefensiveShotStat

    def test_close_def_person_id
      stat = DefensiveShotStat.new(close_def_person_id: 201_939)

      assert_equal 201_939, stat.close_def_person_id
    end

    def test_gp
      stat = DefensiveShotStat.new(gp: 74)

      assert_equal 74, stat.gp
    end

    def test_g
      stat = DefensiveShotStat.new(g: 74)

      assert_equal 74, stat.g
    end

    def test_defense_category
      stat = DefensiveShotStat.new(defense_category: "Overall")

      assert_equal "Overall", stat.defense_category
    end

    def test_freq
      stat = DefensiveShotStat.new(freq: 0.15)

      assert_in_delta 0.15, stat.freq
    end

    def test_d_fgm
      stat = DefensiveShotStat.new(d_fgm: 3.5)

      assert_in_delta 3.5, stat.d_fgm
    end

    def test_d_fga
      stat = DefensiveShotStat.new(d_fga: 8.2)

      assert_in_delta 8.2, stat.d_fga
    end

    def test_d_fg_pct
      stat = DefensiveShotStat.new(d_fg_pct: 0.427)

      assert_in_delta 0.427, stat.d_fg_pct
    end

    def test_normal_fg_pct
      stat = DefensiveShotStat.new(normal_fg_pct: 0.485)

      assert_in_delta 0.485, stat.normal_fg_pct
    end

    def test_pct_plusminus
      stat = DefensiveShotStat.new(pct_plusminus: -5.8)

      assert_in_delta(-5.8, stat.pct_plusminus)
    end

    def test_player
      stat = DefensiveShotStat.new(close_def_person_id: 201_939)
      stub_request(:get, /commonplayerinfo.*PlayerID=201939/).to_return(body: player_response.to_json)

      result = stat.player

      assert_instance_of Player, result
    end

    def test_equality_by_close_def_person_id_defense_category_and_g
      stat1 = DefensiveShotStat.new(close_def_person_id: 201_939, defense_category: "Overall", g: 74)
      stat2 = DefensiveShotStat.new(close_def_person_id: 201_939, defense_category: "Overall", g: 74)

      assert_equal stat1, stat2
    end

    def test_inequality_by_different_close_def_person_id
      stat1 = DefensiveShotStat.new(close_def_person_id: 201_939, defense_category: "Overall", g: 74)
      stat2 = DefensiveShotStat.new(close_def_person_id: 202_691, defense_category: "Overall", g: 74)

      refute_equal stat1, stat2
    end

    def test_inequality_by_different_defense_category
      stat1 = DefensiveShotStat.new(close_def_person_id: 201_939, defense_category: "Overall", g: 74)
      stat2 = DefensiveShotStat.new(close_def_person_id: 201_939, defense_category: "3 Pointers", g: 74)

      refute_equal stat1, stat2
    end

    def test_inequality_by_different_g
      stat1 = DefensiveShotStat.new(close_def_person_id: 201_939, defense_category: "Overall", g: 74)
      stat2 = DefensiveShotStat.new(close_def_person_id: 201_939, defense_category: "Overall", g: 50)

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
