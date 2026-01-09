require_relative "../test_helper"

module NBA
  class VideoStatusEntryModelTest < Minitest::Test
    cover VideoStatusEntry

    def test_objects_with_same_game_id_are_equal
      entry0 = VideoStatusEntry.new(game_id: "0022300001")
      entry1 = VideoStatusEntry.new(game_id: "0022300001")

      assert_equal entry0, entry1
    end

    def test_objects_with_different_game_id_are_not_equal
      entry0 = VideoStatusEntry.new(game_id: "0022300001")
      entry1 = VideoStatusEntry.new(game_id: "0022300002")

      refute_equal entry0, entry1
    end

    def test_available_returns_true_when_is_available_is_one
      entry = VideoStatusEntry.new(is_available: 1)

      assert_predicate entry, :available?
    end

    def test_available_returns_false_when_is_available_is_zero
      entry = VideoStatusEntry.new(is_available: 0)

      refute_predicate entry, :available?
    end

    def test_available_uses_value_equality
      entry = VideoStatusEntry.new(is_available: 1.0)

      assert_predicate entry, :available?
    end

    def test_pt_xyz_available_returns_true_when_pt_xyz_available_is_one
      entry = VideoStatusEntry.new(pt_xyz_available: 1)

      assert_predicate entry, :pt_xyz_available?
    end

    def test_pt_xyz_available_returns_false_when_pt_xyz_available_is_zero
      entry = VideoStatusEntry.new(pt_xyz_available: 0)

      refute_predicate entry, :pt_xyz_available?
    end

    def test_pt_xyz_available_uses_value_equality
      entry = VideoStatusEntry.new(pt_xyz_available: 1.0)

      assert_predicate entry, :pt_xyz_available?
    end

    def test_home_team_returns_nil_when_home_team_id_is_nil
      entry = VideoStatusEntry.new(home_team_id: nil)

      assert_nil entry.home_team
    end

    def test_home_team_returns_team_object_when_home_team_id_valid
      entry = VideoStatusEntry.new(home_team_id: Team::LAL)
      team = entry.home_team

      assert_instance_of Team, team
      assert_equal Team::LAL, team.id
    end

    def test_home_team_uses_home_team_id_attribute
      entry = VideoStatusEntry.new(home_team_id: Team::LAL)

      assert_equal Team::LAL, entry.home_team.id
    end

    def test_visitor_team_returns_nil_when_visitor_team_id_is_nil
      entry = VideoStatusEntry.new(visitor_team_id: nil)

      assert_nil entry.visitor_team
    end

    def test_visitor_team_returns_team_object_when_visitor_team_id_valid
      entry = VideoStatusEntry.new(visitor_team_id: Team::GSW)
      team = entry.visitor_team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_visitor_team_uses_visitor_team_id_attribute
      entry = VideoStatusEntry.new(visitor_team_id: Team::GSW)

      assert_equal Team::GSW, entry.visitor_team.id
    end
  end
end
