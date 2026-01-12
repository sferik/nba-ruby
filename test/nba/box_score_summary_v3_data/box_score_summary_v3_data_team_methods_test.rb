require_relative "../../test_helper"

module NBA
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
end
