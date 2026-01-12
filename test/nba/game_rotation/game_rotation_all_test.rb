require_relative "../../test_helper"

module NBA
  class GameRotationAllTest < Minitest::Test
    cover GameRotation

    def test_all_returns_collection
      stub_rotation_request

      assert_instance_of Collection, GameRotation.all(game: "0022400001")
    end

    def test_all_uses_correct_game_id_in_path
      stub_rotation_request

      GameRotation.all(game: "0022400888")

      assert_requested :get, /gamerotation.*GameID=0022400888/, times: 2
    end

    def test_all_combines_home_and_away
      stub_rotation_request

      rotations = GameRotation.all(game: "0022400001")

      assert_equal 2, rotations.size
    end

    def test_all_uses_default_client
      stub_rotation_request

      GameRotation.all(game: "0022400001")

      assert_requested :get, %r{stats\.nba\.com/stats/gamerotation}, times: 2
    end

    private

    def stub_rotation_request
      stub_request(:get, /gamerotation/).to_return(body: rotation_response.to_json)
    end

    def rotation_response
      {resultSets: [
        {name: "HomeTeam", headers: rotation_headers, rowSet: [home_row]},
        {name: "AwayTeam", headers: rotation_headers, rowSet: [away_row]}
      ]}
    end

    def rotation_headers
      %w[TEAM_ID TEAM_CITY TEAM_NAME PERSON_ID PLAYER_FIRST PLAYER_LAST IN_TIME_REAL OUT_TIME_REAL PLAYER_PTS PT_DIFF USG_PCT]
    end

    def home_row
      [Team::GSW, "Golden State", "Warriors", 201_939, "Stephen", "Curry", 0, 6000, 15, 8, 0.28]
    end

    def away_row
      [Team::LAL, "Los Angeles", "Lakers", 2544, "LeBron", "James", 0, 7200, 20, -5, 0.32]
    end
  end
end
