require_relative "../test_helper"

module NBA
  class GameRotationMissingKeyTest < Minitest::Test
    cover GameRotation

    def test_raises_key_error_when_in_time_real_missing
      response = {resultSets: [{name: "HomeTeam", headers: headers_without("IN_TIME_REAL"), rowSet: [row_without_in_time]}]}
      stub_request(:get, /gamerotation/).to_return(body: response.to_json)

      assert_raises(KeyError) { GameRotation.home_team(game: "001").first }
    end

    def test_raises_key_error_when_out_time_real_missing
      response = {resultSets: [{name: "HomeTeam", headers: headers_without("OUT_TIME_REAL"), rowSet: [row_without_out_time]}]}
      stub_request(:get, /gamerotation/).to_return(body: response.to_json)

      assert_raises(KeyError) { GameRotation.home_team(game: "001").first }
    end

    def test_raises_key_error_when_player_pts_missing
      response = {resultSets: [{name: "HomeTeam", headers: headers_without("PLAYER_PTS"), rowSet: [row_without_player_pts]}]}
      stub_request(:get, /gamerotation/).to_return(body: response.to_json)

      assert_raises(KeyError) { GameRotation.home_team(game: "001").first }
    end

    def test_raises_key_error_when_pt_diff_missing
      response = {resultSets: [{name: "HomeTeam", headers: headers_without("PT_DIFF"), rowSet: [row_without_pt_diff]}]}
      stub_request(:get, /gamerotation/).to_return(body: response.to_json)

      assert_raises(KeyError) { GameRotation.home_team(game: "001").first }
    end

    def test_raises_key_error_when_usg_pct_missing
      response = {resultSets: [{name: "HomeTeam", headers: headers_without("USG_PCT"), rowSet: [row_without_usg_pct]}]}
      stub_request(:get, /gamerotation/).to_return(body: response.to_json)

      assert_raises(KeyError) { GameRotation.home_team(game: "001").first }
    end

    def test_raises_key_error_when_result_set_name_missing
      response = {resultSets: [{headers: full_headers, rowSet: [full_row]}]}
      stub_request(:get, /gamerotation/).to_return(body: response.to_json)

      assert_raises(KeyError) { GameRotation.home_team(game: "001") }
    end

    def test_finds_correct_result_set_by_name
      response = {resultSets: [
        {name: "OtherSet", headers: full_headers, rowSet: [[Team::BOS, "Boston", "Celtics", 1, "A", "B", 0, 100, 5, 2, 0.1]]},
        {name: "HomeTeam", headers: full_headers, rowSet: [[Team::GSW, "Golden State", "Warriors", 201_939, "Stephen", "Curry", 0, 6000, 15, 8, 0.28]]}
      ]}
      stub_request(:get, /gamerotation/).to_return(body: response.to_json)

      rotations = GameRotation.home_team(game: "001")

      assert_equal "Warriors", rotations.first.team_name
    end

    private

    def full_headers
      %w[TEAM_ID TEAM_CITY TEAM_NAME PERSON_ID PLAYER_FIRST PLAYER_LAST IN_TIME_REAL OUT_TIME_REAL PLAYER_PTS PT_DIFF USG_PCT]
    end

    def full_row
      [Team::GSW, "Golden State", "Warriors", 201_939, "Stephen", "Curry", 0, 6000, 15, 8, 0.28]
    end

    def headers_without(key)
      full_headers.reject { |h| h == key }
    end

    def row_without_in_time
      [Team::GSW, "Golden State", "Warriors", 201_939, "Stephen", "Curry", 6000, 15, 8, 0.28]
    end

    def row_without_out_time
      [Team::GSW, "Golden State", "Warriors", 201_939, "Stephen", "Curry", 0, 15, 8, 0.28]
    end

    def row_without_player_pts
      [Team::GSW, "Golden State", "Warriors", 201_939, "Stephen", "Curry", 0, 6000, 8, 0.28]
    end

    def row_without_pt_diff
      [Team::GSW, "Golden State", "Warriors", 201_939, "Stephen", "Curry", 0, 6000, 15, 0.28]
    end

    def row_without_usg_pct
      [Team::GSW, "Golden State", "Warriors", 201_939, "Stephen", "Curry", 0, 6000, 15, 8]
    end
  end
end
