require_relative "../../test_helper"

module NBA
  class PlayerIndexMissingPhysicalKeysTest < Minitest::Test
    cover PlayerIndex

    def test_handles_missing_jersey_number
      stub_request(:get, /playerindex/).to_return(body: response_without("JERSEY_NUMBER").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.jersey_number
    end

    def test_handles_missing_position
      stub_request(:get, /playerindex/).to_return(body: response_without("POSITION").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.position
    end

    def test_handles_missing_height
      stub_request(:get, /playerindex/).to_return(body: response_without("HEIGHT").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.height
    end

    def test_handles_missing_weight
      stub_request(:get, /playerindex/).to_return(body: response_without("WEIGHT").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.weight
    end

    def test_handles_missing_college
      stub_request(:get, /playerindex/).to_return(body: response_without("COLLEGE").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.college
    end

    def test_handles_missing_country
      stub_request(:get, /playerindex/).to_return(body: response_without("COUNTRY").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.country
    end

    def test_handles_missing_draft_year
      stub_request(:get, /playerindex/).to_return(body: response_without("DRAFT_YEAR").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.draft_year
    end

    def test_handles_missing_draft_round
      stub_request(:get, /playerindex/).to_return(body: response_without("DRAFT_ROUND").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.draft_round
    end

    def test_handles_missing_draft_number
      stub_request(:get, /playerindex/).to_return(body: response_without("DRAFT_NUMBER").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.draft_number
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
