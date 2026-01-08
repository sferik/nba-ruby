require_relative "../test_helper"

module NBA
  class TeamGameStreakFinderKeysTest < Minitest::Test
    cover TeamGameStreakFinder

    def test_handles_missing_team_name_key
      stub_request(:get, /teamgamestreakfinder/).to_return(body: response_missing_key("TEAM_NAME").to_json)

      streak = TeamGameStreakFinder.find.first

      assert_nil streak.team_name
    end

    def test_handles_missing_team_id_key
      stub_request(:get, /teamgamestreakfinder/).to_return(body: response_missing_key("TEAM_ID").to_json)

      streak = TeamGameStreakFinder.find.first

      assert_nil streak.team_id
    end

    def test_handles_missing_abbreviation_key
      stub_request(:get, /teamgamestreakfinder/).to_return(body: response_missing_key("ABBREVIATION").to_json)

      streak = TeamGameStreakFinder.find.first

      assert_nil streak.abbreviation
    end

    def test_handles_missing_gamestreak_key
      stub_request(:get, /teamgamestreakfinder/).to_return(body: response_missing_key("GAMESTREAK").to_json)

      streak = TeamGameStreakFinder.find.first

      assert_nil streak.game_streak
    end

    def test_handles_missing_startdate_key
      stub_request(:get, /teamgamestreakfinder/).to_return(body: response_missing_key("STARTDATE").to_json)

      streak = TeamGameStreakFinder.find.first

      assert_nil streak.start_date
    end

    def test_handles_missing_enddate_key
      stub_request(:get, /teamgamestreakfinder/).to_return(body: response_missing_key("ENDDATE").to_json)

      streak = TeamGameStreakFinder.find.first

      assert_nil streak.end_date
    end

    def test_handles_missing_activestreak_key
      stub_request(:get, /teamgamestreakfinder/).to_return(body: response_missing_key("ACTIVESTREAK").to_json)

      streak = TeamGameStreakFinder.find.first

      assert_nil streak.active_streak
    end

    def test_handles_missing_numseasons_key
      stub_request(:get, /teamgamestreakfinder/).to_return(body: response_missing_key("NUMSEASONS").to_json)

      streak = TeamGameStreakFinder.find.first

      assert_nil streak.num_seasons
    end

    def test_handles_missing_lastseason_key
      stub_request(:get, /teamgamestreakfinder/).to_return(body: response_missing_key("LASTSEASON").to_json)

      streak = TeamGameStreakFinder.find.first

      assert_nil streak.last_season
    end

    def test_handles_missing_firstseason_key
      stub_request(:get, /teamgamestreakfinder/).to_return(body: response_missing_key("FIRSTSEASON").to_json)

      streak = TeamGameStreakFinder.find.first

      assert_nil streak.first_season
    end

    private

    def response_missing_key(key)
      headers = streak_headers.reject { |h| h == key }
      row = streak_row.each_with_index.reject { |_, i| streak_headers[i] == key }.map(&:first)
      {resultSets: [{name: "TeamGameStreakFinderParametersResults", headers: headers, rowSet: [row]}]}
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
