require_relative "../test_helper"

module NBA
  class PlayerIndexMissingIdentityKeysTest < Minitest::Test
    cover PlayerIndex

    def test_handles_missing_person_id
      stub_request(:get, /playerindex/).to_return(body: response_without("PERSON_ID").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.id
    end

    def test_handles_missing_player_last_name
      stub_request(:get, /playerindex/).to_return(body: response_without("PLAYER_LAST_NAME").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.last_name
    end

    def test_handles_missing_player_first_name
      stub_request(:get, /playerindex/).to_return(body: response_without("PLAYER_FIRST_NAME").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.first_name
    end

    def test_handles_missing_player_slug
      stub_request(:get, /playerindex/).to_return(body: response_without("PLAYER_SLUG").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.slug
    end

    def test_handles_missing_team_id
      stub_request(:get, /playerindex/).to_return(body: response_without("TEAM_ID").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.team_id
    end

    def test_handles_missing_team_slug
      stub_request(:get, /playerindex/).to_return(body: response_without("TEAM_SLUG").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.team_slug
    end

    def test_handles_missing_team_city
      stub_request(:get, /playerindex/).to_return(body: response_without("TEAM_CITY").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.team_city
    end

    def test_handles_missing_team_name
      stub_request(:get, /playerindex/).to_return(body: response_without("TEAM_NAME").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.team_name
    end

    def test_handles_missing_team_abbreviation
      stub_request(:get, /playerindex/).to_return(body: response_without("TEAM_ABBREVIATION").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.team_abbreviation
    end

    private

    def all_headers
      %w[PERSON_ID PLAYER_LAST_NAME PLAYER_FIRST_NAME PLAYER_SLUG
        TEAM_ID TEAM_SLUG TEAM_CITY TEAM_NAME TEAM_ABBREVIATION
        JERSEY_NUMBER POSITION HEIGHT WEIGHT COLLEGE COUNTRY
        DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER ROSTER_STATUS
        PTS REB AST STATS_TIMEFRAME FROM_YEAR TO_YEAR IS_DEFUNCT]
    end

    def all_values
      [201_939, "Curry", "Stephen", "stephen-curry",
        1_610_612_744, "warriors", "Golden State", "Warriors", "GSW",
        "30", "G", "6-2", 185, "Davidson", "USA",
        2009, 1, 7, 1,
        24.8, 4.7, 6.5, "Season", 2009, 2024, 0]
    end

    def response_without(key)
      index = all_headers.index(key)
      headers = all_headers.reject { |h| h.eql?(key) }
      values = all_values.reject.with_index { |_, i| i.eql?(index) }
      {resultSets: [{name: "PlayerIndex", headers: headers, rowSet: [values]}]}
    end
  end
end
