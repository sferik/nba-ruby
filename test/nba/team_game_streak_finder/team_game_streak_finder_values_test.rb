require_relative "../../test_helper"

module NBA
  class TeamGameStreakFinderValuesTest < Minitest::Test
    cover TeamGameStreakFinder

    def test_extracts_team_name
      stub_request(:get, /teamgamestreakfinder/).to_return(body: streak_response.to_json)

      streak = TeamGameStreakFinder.find.first

      assert_equal "Golden State Warriors", streak.team_name
    end

    def test_extracts_team_id
      stub_request(:get, /teamgamestreakfinder/).to_return(body: streak_response.to_json)

      streak = TeamGameStreakFinder.find.first

      assert_equal 1_610_612_744, streak.team_id
    end

    def test_extracts_abbreviation
      stub_request(:get, /teamgamestreakfinder/).to_return(body: streak_response.to_json)

      streak = TeamGameStreakFinder.find.first

      assert_equal "GSW", streak.abbreviation
    end

    def test_extracts_game_streak
      stub_request(:get, /teamgamestreakfinder/).to_return(body: streak_response.to_json)

      streak = TeamGameStreakFinder.find.first

      assert_equal 10, streak.game_streak
    end

    def test_extracts_start_date
      stub_request(:get, /teamgamestreakfinder/).to_return(body: streak_response.to_json)

      streak = TeamGameStreakFinder.find.first

      assert_equal "2024-10-22", streak.start_date
    end

    def test_extracts_end_date
      stub_request(:get, /teamgamestreakfinder/).to_return(body: streak_response.to_json)

      streak = TeamGameStreakFinder.find.first

      assert_equal "2024-11-15", streak.end_date
    end

    def test_extracts_active_streak
      stub_request(:get, /teamgamestreakfinder/).to_return(body: streak_response.to_json)

      streak = TeamGameStreakFinder.find.first

      assert_equal 1, streak.active_streak
    end

    def test_extracts_num_seasons
      stub_request(:get, /teamgamestreakfinder/).to_return(body: streak_response.to_json)

      streak = TeamGameStreakFinder.find.first

      assert_equal 1, streak.num_seasons
    end

    def test_extracts_last_season
      stub_request(:get, /teamgamestreakfinder/).to_return(body: streak_response.to_json)

      streak = TeamGameStreakFinder.find.first

      assert_equal "2024-25", streak.last_season
    end

    def test_extracts_first_season
      stub_request(:get, /teamgamestreakfinder/).to_return(body: streak_response.to_json)

      streak = TeamGameStreakFinder.find.first

      assert_equal "2024-25", streak.first_season
    end

    private

    def streak_response
      {resultSets: [{name: "TeamGameStreakFinderParametersResults", headers: streak_headers, rowSet: [streak_row]}]}
    end

    def streak_headers
      %w[TEAM_NAME TEAM_ID ABBREVIATION GAMESTREAK STARTDATE ENDDATE ACTIVESTREAK NUMSEASONS
        LASTSEASON FIRSTSEASON]
    end

    def streak_row
      ["Golden State Warriors", 1_610_612_744, "GSW", 10, "2024-10-22", "2024-11-15", 1, 1, "2024-25", "2024-25"]
    end
  end
end
