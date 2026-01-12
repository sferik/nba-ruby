require_relative "../../test_helper"

module NBA
  class PlayerGameStreakFinderValuesTest < Minitest::Test
    cover PlayerGameStreakFinder

    def test_parses_player_name
      stub_finder_request

      streak = PlayerGameStreakFinder.find.first

      assert_equal "Curry, Stephen", streak.player_name
    end

    def test_parses_player_id
      stub_finder_request

      streak = PlayerGameStreakFinder.find.first

      assert_equal 201_939, streak.player_id
    end

    def test_parses_game_streak
      stub_finder_request

      streak = PlayerGameStreakFinder.find.first

      assert_equal 15, streak.game_streak
    end

    def test_parses_start_date
      stub_finder_request

      streak = PlayerGameStreakFinder.find.first

      assert_equal "2024-12-01", streak.start_date
    end

    def test_parses_end_date
      stub_finder_request

      streak = PlayerGameStreakFinder.find.first

      assert_equal "2024-12-20", streak.end_date
    end

    def test_parses_active_streak
      stub_finder_request

      streak = PlayerGameStreakFinder.find.first

      assert_equal 1, streak.active_streak
    end

    def test_parses_num_seasons
      stub_finder_request

      streak = PlayerGameStreakFinder.find.first

      assert_equal 2, streak.num_seasons
    end

    def test_parses_last_season
      stub_finder_request

      streak = PlayerGameStreakFinder.find.first

      assert_equal "2024-25", streak.last_season
    end

    def test_parses_first_season
      stub_finder_request

      streak = PlayerGameStreakFinder.find.first

      assert_equal "2023-24", streak.first_season
    end

    private

    def stub_finder_request
      stub_request(:get, /playergamestreakfinder/).to_return(body: finder_response.to_json)
    end

    def finder_headers
      %w[PLAYER_NAME_LAST_FIRST PLAYER_ID GAMESTREAK STARTDATE ENDDATE ACTIVESTREAK NUMSEASONS LASTSEASON FIRSTSEASON]
    end

    def streak_row
      ["Curry, Stephen", 201_939, 15, "2024-12-01", "2024-12-20", 1, 2, "2024-25", "2023-24"]
    end

    def finder_response
      {resultSets: [{name: "PlayerGameStreakFinderResults", headers: finder_headers, rowSet: [streak_row]}]}
    end
  end
end
