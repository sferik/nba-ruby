require_relative "../test_helper"

module NBA
  class MatchupRollupTest < Minitest::Test
    cover MatchupRollup

    def test_season_id
      matchup = MatchupRollup.new(season_id: "22023")

      assert_equal "22023", matchup.season_id
    end

    def test_position
      matchup = MatchupRollup.new(position: "F")

      assert_equal "F", matchup.position
    end

    def test_percent_of_time
      matchup = MatchupRollup.new(percent_of_time: 0.25)

      assert_in_delta 0.25, matchup.percent_of_time
    end

    def test_def_player_id
      matchup = MatchupRollup.new(def_player_id: 1_628_369)

      assert_equal 1_628_369, matchup.def_player_id
    end

    def test_def_player_name
      matchup = MatchupRollup.new(def_player_name: "Jayson Tatum")

      assert_equal "Jayson Tatum", matchup.def_player_name
    end

    def test_gp
      matchup = MatchupRollup.new(gp: 82)

      assert_equal 82, matchup.gp
    end

    def test_matchup_fg_pct
      matchup = MatchupRollup.new(matchup_fg_pct: 0.425)

      assert_in_delta 0.425, matchup.matchup_fg_pct
    end

    def test_matchup_fg3_pct
      matchup = MatchupRollup.new(matchup_fg3_pct: 0.352)

      assert_in_delta 0.352, matchup.matchup_fg3_pct
    end

    def test_equality
      matchup1 = MatchupRollup.new(season_id: "22023", def_player_id: 1_628_369, position: "F")
      matchup2 = MatchupRollup.new(season_id: "22023", def_player_id: 1_628_369, position: "F")

      assert_equal matchup1, matchup2
    end

    def test_inequality_different_player
      matchup1 = MatchupRollup.new(season_id: "22023", def_player_id: 1_628_369, position: "F")
      matchup2 = MatchupRollup.new(season_id: "22023", def_player_id: 201_566, position: "F")

      refute_equal matchup1, matchup2
    end
  end
end
