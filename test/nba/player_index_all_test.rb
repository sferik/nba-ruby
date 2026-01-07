require_relative "../test_helper"

module NBA
  class PlayerIndexAllTest < Minitest::Test
    cover PlayerIndex

    def test_all_returns_collection
      stub_player_index_request

      result = PlayerIndex.all

      assert_instance_of Collection, result
    end

    def test_all_parses_identity_info
      stub_player_index_request

      entry = PlayerIndex.all.first

      assert_equal 201_939, entry.id
      assert_equal "Curry", entry.last_name
      assert_equal "Stephen", entry.first_name
      assert_equal "stephen-curry", entry.slug
    end

    def test_all_parses_team_info
      stub_player_index_request

      entry = PlayerIndex.all.first

      assert_equal 1_610_612_744, entry.team_id
      assert_equal "warriors", entry.team_slug
      assert_equal "Golden State", entry.team_city
      assert_equal "Warriors", entry.team_name
      assert_equal "GSW", entry.team_abbreviation
    end

    def test_all_parses_player_attributes
      stub_player_index_request

      entry = PlayerIndex.all.first

      assert_equal "30", entry.jersey_number
      assert_equal "G", entry.position
      assert_equal "6-2", entry.height
      assert_equal 185, entry.weight
    end

    def test_all_parses_background_info
      stub_player_index_request

      entry = PlayerIndex.all.first

      assert_equal "Davidson", entry.college
      assert_equal "USA", entry.country
    end

    def test_all_parses_draft_info
      stub_player_index_request

      entry = PlayerIndex.all.first

      assert_equal 2009, entry.draft_year
      assert_equal 1, entry.draft_round
      assert_equal 7, entry.draft_number
      assert_equal 1, entry.roster_status
    end

    def test_all_parses_career_stats
      stub_player_index_request

      entry = PlayerIndex.all.first

      assert_in_delta 24.8, entry.pts
      assert_in_delta 4.7, entry.reb
      assert_in_delta 6.5, entry.ast
      assert_equal "Season", entry.stats_timeframe
    end

    def test_all_parses_career_years
      stub_player_index_request

      entry = PlayerIndex.all.first

      assert_equal 2009, entry.from_year
      assert_equal 2024, entry.to_year
      assert_equal 0, entry.is_defunct
    end

    def test_all_returns_empty_collection_for_nil_response
      stub_request(:get, /playerindex/).to_return(body: nil)

      result = PlayerIndex.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_uses_correct_result_set_name
      stub_request(:get, /playerindex/).to_return(body: wrong_result_set_response.to_json)

      result = PlayerIndex.all

      assert_empty result
    end

    private

    def wrong_result_set_response
      {resultSets: [{name: "WrongResultSet", headers: player_headers, rowSet: [player_row]}]}
    end

    def stub_player_index_request
      stub_request(:get, /playerindex/).to_return(body: player_index_response.to_json)
    end

    def player_headers
      %w[PERSON_ID PLAYER_LAST_NAME PLAYER_FIRST_NAME PLAYER_SLUG
        TEAM_ID TEAM_SLUG TEAM_CITY TEAM_NAME TEAM_ABBREVIATION
        JERSEY_NUMBER POSITION HEIGHT WEIGHT COLLEGE COUNTRY
        DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER ROSTER_STATUS
        PTS REB AST STATS_TIMEFRAME FROM_YEAR TO_YEAR IS_DEFUNCT]
    end

    def player_index_response
      {resultSets: [{name: "PlayerIndex", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_row
      [201_939, "Curry", "Stephen", "stephen-curry",
        1_610_612_744, "warriors", "Golden State", "Warriors", "GSW",
        "30", "G", "6-2", 185, "Davidson", "USA",
        2009, 1, 7, 1,
        24.8, 4.7, 6.5, "Season", 2009, 2024, 0]
    end
  end
end
