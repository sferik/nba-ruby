require_relative "../test_helper"

module NBA
  class GameStreakTest < Minitest::Test
    cover GameStreak

    def test_active_returns_true_when_active_streak_is_one
      streak = GameStreak.new(active_streak: 1)

      assert_predicate streak, :active?
    end

    def test_active_returns_false_when_active_streak_is_zero
      streak = GameStreak.new(active_streak: 0)

      refute_predicate streak, :active?
    end

    def test_active_returns_false_when_active_streak_is_nil
      streak = GameStreak.new(active_streak: nil)

      refute_predicate streak, :active?
    end

    def test_equality_by_player_id_and_dates
      streak1 = GameStreak.new(player_id: 201_939, start_date: "2020-01-01", end_date: "2020-01-10")
      streak2 = GameStreak.new(player_id: 201_939, start_date: "2020-01-01", end_date: "2020-01-10")

      assert_equal streak1, streak2
    end

    def test_inequality_with_different_player_id
      streak1 = GameStreak.new(player_id: 201_939, start_date: "2020-01-01", end_date: "2020-01-10")
      streak2 = GameStreak.new(player_id: 2544, start_date: "2020-01-01", end_date: "2020-01-10")

      refute_equal streak1, streak2
    end

    def test_player_returns_player_object
      streak = GameStreak.new(player_id: 201_939)
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)

      result = streak.player

      assert_instance_of Player, result
    end

    private

    def player_response
      {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID DISPLAY_FIRST_LAST],
                     rowSet: [[201_939, "Stephen Curry"]]}]}
    end
  end
end
