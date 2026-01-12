require_relative "../../test_helper"

module NBA
  class TeamGameStreakFinderTest < Minitest::Test
    cover TeamGameStreakFinder

    def test_find_returns_collection
      stub_request(:get, /teamgamestreakfinder/).to_return(body: streak_response.to_json)

      result = TeamGameStreakFinder.find

      assert_instance_of Collection, result
    end

    def test_find_returns_team_game_streaks
      stub_request(:get, /teamgamestreakfinder/).to_return(body: streak_response.to_json)

      result = TeamGameStreakFinder.find

      assert_instance_of TeamGameStreak, result.first
    end

    def test_result_set_name_constant
      assert_equal "TeamGameStreakFinderParametersResults", TeamGameStreakFinder::RESULT_SET_NAME
    end

    def test_find_uses_correct_result_set
      response_with_multiple_sets = {
        resultSets: [
          {name: "OtherSet", headers: %w[ID], rowSet: [[999]]},
          {name: "TeamGameStreakFinderParametersResults", headers: streak_headers, rowSet: [streak_row]}
        ]
      }
      stub_request(:get, /teamgamestreakfinder/).to_return(body: response_with_multiple_sets.to_json)

      result = TeamGameStreakFinder.find

      assert_equal 1_610_612_744, result.first.team_id
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
