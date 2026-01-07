require_relative "../test_helper"

module NBA
  class PlayerIndexMissingStatsKeysTest < Minitest::Test
    cover PlayerIndex

    def test_handles_missing_roster_status
      stub_request(:get, /playerindex/).to_return(body: response_without("ROSTER_STATUS").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.roster_status
    end

    def test_handles_missing_pts
      stub_request(:get, /playerindex/).to_return(body: response_without("PTS").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.pts
    end

    def test_handles_missing_reb
      stub_request(:get, /playerindex/).to_return(body: response_without("REB").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.reb
    end

    def test_handles_missing_ast
      stub_request(:get, /playerindex/).to_return(body: response_without("AST").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.ast
    end

    def test_handles_missing_stats_timeframe
      stub_request(:get, /playerindex/).to_return(body: response_without("STATS_TIMEFRAME").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.stats_timeframe
    end

    def test_handles_missing_from_year
      stub_request(:get, /playerindex/).to_return(body: response_without("FROM_YEAR").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.from_year
    end

    def test_handles_missing_to_year
      stub_request(:get, /playerindex/).to_return(body: response_without("TO_YEAR").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.to_year
    end

    def test_handles_missing_is_defunct
      stub_request(:get, /playerindex/).to_return(body: response_without("IS_DEFUNCT").to_json)

      entry = PlayerIndex.all.first

      assert_nil entry.is_defunct
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
