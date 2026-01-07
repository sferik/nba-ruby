require_relative "../test_helper"

module NBA
  class PlayerGameStreakFinderMissingKeysTest < Minitest::Test
    cover PlayerGameStreakFinder

    def test_handles_missing_player_name
      stub_request(:get, /playergamestreakfinder/).to_return(body: response_without("PLAYER_NAME_LAST_FIRST").to_json)

      assert_nil PlayerGameStreakFinder.find.first.player_name
    end

    def test_handles_missing_player_id
      stub_request(:get, /playergamestreakfinder/).to_return(body: response_without("PLAYER_ID").to_json)

      assert_nil PlayerGameStreakFinder.find.first.player_id
    end

    def test_handles_missing_game_streak
      stub_request(:get, /playergamestreakfinder/).to_return(body: response_without("GAMESTREAK").to_json)

      assert_nil PlayerGameStreakFinder.find.first.game_streak
    end

    def test_handles_missing_start_date
      stub_request(:get, /playergamestreakfinder/).to_return(body: response_without("STARTDATE").to_json)

      assert_nil PlayerGameStreakFinder.find.first.start_date
    end

    def test_handles_missing_end_date
      stub_request(:get, /playergamestreakfinder/).to_return(body: response_without("ENDDATE").to_json)

      assert_nil PlayerGameStreakFinder.find.first.end_date
    end

    def test_handles_missing_active_streak
      stub_request(:get, /playergamestreakfinder/).to_return(body: response_without("ACTIVESTREAK").to_json)

      assert_nil PlayerGameStreakFinder.find.first.active_streak
    end

    def test_handles_missing_num_seasons
      stub_request(:get, /playergamestreakfinder/).to_return(body: response_without("NUMSEASONS").to_json)

      assert_nil PlayerGameStreakFinder.find.first.num_seasons
    end

    def test_handles_missing_last_season
      stub_request(:get, /playergamestreakfinder/).to_return(body: response_without("LASTSEASON").to_json)

      assert_nil PlayerGameStreakFinder.find.first.last_season
    end

    def test_handles_missing_first_season
      stub_request(:get, /playergamestreakfinder/).to_return(body: response_without("FIRSTSEASON").to_json)

      assert_nil PlayerGameStreakFinder.find.first.first_season
    end

    private

    def all_headers
      %w[PLAYER_NAME_LAST_FIRST PLAYER_ID GAMESTREAK STARTDATE ENDDATE ACTIVESTREAK NUMSEASONS LASTSEASON FIRSTSEASON]
    end

    def all_values
      ["Curry, Stephen", 201_939, 15, "2024-12-01", "2024-12-20", 1, 2, "2024-25", "2023-24"]
    end

    def response_without(key)
      index = all_headers.index(key)
      headers = all_headers.reject { |h| h.eql?(key) }
      values = all_values.reject.with_index { |_, i| i.eql?(index) }
      {resultSets: [{name: "PlayerGameStreakFinderResults", headers: headers, rowSet: [values]}]}
    end
  end
end
