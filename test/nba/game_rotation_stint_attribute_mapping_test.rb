require_relative "../test_helper"

module NBA
  class GameRotationStintAttributeMappingTest < Minitest::Test
    cover GameRotation

    def test_maps_all_stint_attributes
      stub_rotation_request

      rotation = GameRotation.home_team(game: "0022400001").first

      assert_equal 0, rotation.in_time_real
      assert_equal 6000, rotation.out_time_real
      assert_equal 15, rotation.player_pts
      assert_equal 8, rotation.pt_diff
      assert_in_delta 0.28, rotation.usg_pct
    end

    private

    def stub_rotation_request
      stub_request(:get, /gamerotation/).to_return(body: rotation_response.to_json)
    end

    def rotation_response
      {resultSets: [{name: "HomeTeam", headers: rotation_headers, rowSet: [rotation_row]}]}
    end

    def rotation_headers
      %w[TEAM_ID TEAM_CITY TEAM_NAME PERSON_ID PLAYER_FIRST PLAYER_LAST IN_TIME_REAL OUT_TIME_REAL PLAYER_PTS PT_DIFF USG_PCT]
    end

    def rotation_row
      [Team::GSW, "Golden State", "Warriors", 201_939, "Stephen", "Curry", 0, 6000, 15, 8, 0.28]
    end
  end
end
