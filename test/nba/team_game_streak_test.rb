require_relative "../test_helper"

module NBA
  class TeamGameStreakTest < Minitest::Test
    cover TeamGameStreak

    def test_equality_based_on_team_id_and_dates
      streak1 = TeamGameStreak.new(team_id: 1_610_612_744, start_date: "2024-10-22", end_date: "2024-11-15")
      streak2 = TeamGameStreak.new(team_id: 1_610_612_744, start_date: "2024-10-22", end_date: "2024-11-15")

      assert_equal streak1, streak2
    end

    def test_inequality_based_on_different_team_id
      streak1 = TeamGameStreak.new(team_id: 1_610_612_744, start_date: "2024-10-22", end_date: "2024-11-15")
      streak2 = TeamGameStreak.new(team_id: 1_610_612_745, start_date: "2024-10-22", end_date: "2024-11-15")

      refute_equal streak1, streak2
    end

    def test_active_returns_true_when_active_streak_is_one
      streak = TeamGameStreak.new(active_streak: 1)

      assert_predicate streak, :active?
    end

    def test_active_returns_false_when_active_streak_is_zero
      streak = TeamGameStreak.new(active_streak: 0)

      refute_predicate streak, :active?
    end

    def test_team_returns_team_from_teams_find
      stub_request(:get, /commonteamroster/).to_return(body: team_response.to_json)
      streak = TeamGameStreak.new(team_id: 1_610_612_744)

      result = streak.team

      assert_instance_of Team, result
    end

    private

    def team_response
      {resultSets: [{name: "CommonTeamRoster", headers: %w[TeamID PLAYER_ID], rowSet: [[1_610_612_744, 201_939]]}]}
    end
  end
end
