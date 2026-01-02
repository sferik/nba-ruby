require_relative "../test_helper"

module NBA
  class TeamHistoricalRecordModelTest < Minitest::Test
    cover TeamHistoricalRecord

    def test_objects_with_same_team_id_and_season_id_are_equal
      record0 = TeamHistoricalRecord.new(team_id: Team::GSW, season_id: "22024")
      record1 = TeamHistoricalRecord.new(team_id: Team::GSW, season_id: "22024")

      assert_equal record0, record1
    end

    def test_objects_with_different_season_id_are_not_equal
      record0 = TeamHistoricalRecord.new(team_id: Team::GSW, season_id: "22024")
      record1 = TeamHistoricalRecord.new(team_id: Team::GSW, season_id: "22023")

      refute_equal record0, record1
    end

    def test_team_returns_nil_when_team_id_is_nil
      record = TeamHistoricalRecord.new(team_id: nil)

      assert_nil record.team
    end

    def test_team_returns_team_object_when_team_id_valid
      record = TeamHistoricalRecord.new(team_id: Team::GSW)

      result = record.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end
  end
end
