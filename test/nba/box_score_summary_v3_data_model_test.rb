require_relative "../test_helper"

module NBA
  class BoxScoreSummaryV3DataEqualityTest < Minitest::Test
    cover BoxScoreSummaryV3Data

    def test_objects_with_same_game_id_are_equal
      summary0 = BoxScoreSummaryV3Data.new(game_id: "0022400001")
      summary1 = BoxScoreSummaryV3Data.new(game_id: "0022400001")

      assert_equal summary0, summary1
    end

    def test_objects_with_different_game_id_are_not_equal
      summary0 = BoxScoreSummaryV3Data.new(game_id: "0022400001")
      summary1 = BoxScoreSummaryV3Data.new(game_id: "0022400002")

      refute_equal summary0, summary1
    end
  end

  class BoxScoreSummaryV3DataTeamMethodsTest < Minitest::Test
    cover BoxScoreSummaryV3Data

    def test_home_team_returns_nil_when_home_team_id_is_nil
      assert_nil BoxScoreSummaryV3Data.new(home_team_id: nil).home_team
    end

    def test_away_team_returns_nil_when_away_team_id_is_nil
      assert_nil BoxScoreSummaryV3Data.new(away_team_id: nil).away_team
    end

    def test_home_team_returns_team_object_when_home_team_id_valid
      result = BoxScoreSummaryV3Data.new(home_team_id: Team::GSW).home_team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end

    def test_away_team_returns_team_object_when_away_team_id_valid
      result = BoxScoreSummaryV3Data.new(away_team_id: Team::LAL).away_team

      assert_instance_of Team, result
      assert_equal Team::LAL, result.id
    end
  end

  class BoxScoreSummaryV3DataPredicatesTest < Minitest::Test
    cover BoxScoreSummaryV3Data

    def test_final_returns_true_when_game_status_is_final
      assert_predicate BoxScoreSummaryV3Data.new(game_status: 3), :final?
    end

    def test_final_returns_false_when_game_status_is_in_progress
      refute_predicate BoxScoreSummaryV3Data.new(game_status: 2), :final?
    end

    def test_final_returns_false_when_game_status_is_nil
      refute_predicate BoxScoreSummaryV3Data.new(game_status: nil), :final?
    end

    def test_in_progress_returns_true_when_game_status_is_live
      assert_predicate BoxScoreSummaryV3Data.new(game_status: 2), :in_progress?
    end

    def test_in_progress_returns_false_when_game_status_is_final
      refute_predicate BoxScoreSummaryV3Data.new(game_status: 3), :in_progress?
    end

    def test_in_progress_returns_false_when_game_status_is_nil
      refute_predicate BoxScoreSummaryV3Data.new(game_status: nil), :in_progress?
    end

    def test_scheduled_returns_true_when_game_status_is_not_started
      assert_predicate BoxScoreSummaryV3Data.new(game_status: 1), :scheduled?
    end

    def test_scheduled_returns_false_when_game_status_is_final
      refute_predicate BoxScoreSummaryV3Data.new(game_status: 3), :scheduled?
    end

    def test_scheduled_returns_false_when_game_status_is_nil
      refute_predicate BoxScoreSummaryV3Data.new(game_status: nil), :scheduled?
    end
  end

  class BoxScoreSummaryV3DataDefaultsTest < Minitest::Test
    cover BoxScoreSummaryV3Data

    def test_default_officials_is_empty_array
      assert_empty BoxScoreSummaryV3Data.new.officials
    end
  end
end
