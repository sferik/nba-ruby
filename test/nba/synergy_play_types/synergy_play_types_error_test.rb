require_relative "../../test_helper"

module NBA
  class SynergyPlayTypesErrorTest < Minitest::Test
    cover SynergyPlayTypes

    def test_player_stats_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, SynergyPlayTypes.player_stats(play_type: "Isolation", client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /synergyplaytypes/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, SynergyPlayTypes.player_stats(play_type: "Isolation").size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /synergyplaytypes/).to_return(body: {otherKey: "value"}.to_json)

      assert_equal 0, SynergyPlayTypes.player_stats(play_type: "Isolation").size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "OtherResultSet", headers: [], rowSet: []}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)

      assert_equal 0, SynergyPlayTypes.player_stats(play_type: "Isolation").size
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: [], rowSet: []}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)

      assert_equal 0, SynergyPlayTypes.player_stats(play_type: "Isolation").size
    end

    def test_returns_empty_when_multiple_result_sets_but_none_match
      response = {
        resultSets: [
          {name: "FirstResultSet", headers: ["PLAYER_ID"], rowSet: [[1]]},
          {name: "SecondResultSet", headers: ["TEAM_ID"], rowSet: [[2]]},
          {name: "ThirdResultSet", headers: ["GAME_ID"], rowSet: [[3]]}
        ]
      }
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)

      assert_equal 0, SynergyPlayTypes.player_stats(play_type: "Isolation").size
    end

    def test_finds_correct_result_set_among_multiple
      stub_request(:get, /synergyplaytypes/)
        .to_return(body: response_with_multiple_result_sets.to_json)

      stats = SynergyPlayTypes.player_stats(play_type: "Isolation")

      assert_equal 1, stats.size
      assert_equal "Stephen Curry", stats.first.player_name
    end

    def test_returns_empty_when_headers_nil
      response = {resultSets: [{name: "SynergyPlayType", headers: nil, rowSet: [["data"]]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)

      assert_equal 0, SynergyPlayTypes.player_stats(play_type: "Isolation").size
    end

    def test_returns_empty_when_rows_nil
      response = {resultSets: [{name: "SynergyPlayType", headers: ["PLAYER_ID"], rowSet: nil}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)

      assert_equal 0, SynergyPlayTypes.player_stats(play_type: "Isolation").size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "SynergyPlayType", rowSet: [["data"]]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)

      assert_equal 0, SynergyPlayTypes.player_stats(play_type: "Isolation").size
    end

    def test_returns_empty_when_rows_key_missing
      response = {resultSets: [{name: "SynergyPlayType", headers: ["PLAYER_ID"]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)

      assert_equal 0, SynergyPlayTypes.player_stats(play_type: "Isolation").size
    end

    private

    def response_with_multiple_result_sets
      {
        resultSets: [
          {name: "FirstResultSet", headers: ["PLAYER_ID"], rowSet: [[1]]},
          synergy_play_type_result_set,
          {name: "ThirdResultSet", headers: ["GAME_ID"], rowSet: [[3]]}
        ]
      }
    end

    def synergy_play_type_result_set
      {
        name: "SynergyPlayType",
        headers: synergy_headers,
        rowSet: [synergy_row_data]
      }
    end

    def synergy_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION GP
        POSS POSS_PCT PTS PTS_PCT FGM FGA FG_PCT EFG_PCT
        FT_POSS_PCT TOV_POSS_PCT SF_POSS_PCT PPP PERCENTILE]
    end

    def synergy_row_data
      [201_939, "Stephen Curry", 1_610_612_744, "GSW", 82,
        250, 0.085, 300, 0.095, 100, 200, 0.500, 0.575,
        0.120, 0.080, 0.140, 1.20, 95.0]
    end
  end
end
