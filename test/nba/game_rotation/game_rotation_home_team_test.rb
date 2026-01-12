require_relative "../../test_helper"

module NBA
  class GameRotationHomeTeamTest < Minitest::Test
    cover GameRotation

    def test_home_team_returns_collection
      stub_rotation_request

      assert_instance_of Collection, GameRotation.home_team(game: "0022400001")
    end

    def test_home_team_uses_correct_game_id_in_path
      stub_rotation_request

      GameRotation.home_team(game: "0022400001")

      assert_requested :get, /gamerotation.*GameID=0022400001/
    end

    def test_home_team_parses_rotations_successfully
      stub_rotation_request

      rotations = GameRotation.home_team(game: "0022400001")

      assert_equal 1, rotations.size
      assert_equal "Stephen Curry", rotations.first.player_name
    end

    private

    def stub_rotation_request
      stub_request(:get, /gamerotation/).to_return(body: rotation_response.to_json)
    end

    def rotation_response
      {resultSets: [
        {name: "HomeTeam", headers: rotation_headers, rowSet: [home_row]},
        {name: "AwayTeam", headers: rotation_headers, rowSet: []}
      ]}
    end

    def rotation_headers
      %w[TEAM_ID TEAM_CITY TEAM_NAME PERSON_ID PLAYER_FIRST PLAYER_LAST IN_TIME_REAL OUT_TIME_REAL PLAYER_PTS PT_DIFF USG_PCT]
    end

    def home_row
      [Team::GSW, "Golden State", "Warriors", 201_939, "Stephen", "Curry", 0, 6000, 15, 8, 0.28]
    end
  end
end
