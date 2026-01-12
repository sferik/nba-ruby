require_relative "../../test_helper"

module NBA
  class GameRotationAwayTeamTest < Minitest::Test
    cover GameRotation

    def test_away_team_returns_collection
      stub_rotation_request

      assert_instance_of Collection, GameRotation.away_team(game: "0022400001")
    end

    def test_away_team_uses_correct_game_id_in_path
      stub_rotation_request

      GameRotation.away_team(game: "0022400999")

      assert_requested :get, /gamerotation.*GameID=0022400999/
    end

    def test_away_team_parses_rotations_successfully
      stub_rotation_request

      rotations = GameRotation.away_team(game: "0022400001")

      assert_equal 1, rotations.size
      assert_equal "LeBron James", rotations.first.player_name
    end

    def test_away_team_uses_default_client
      stub_rotation_request

      GameRotation.away_team(game: "0022400001")

      assert_requested :get, %r{stats\.nba\.com/stats/gamerotation}
    end

    private

    def stub_rotation_request
      stub_request(:get, /gamerotation/).to_return(body: rotation_response.to_json)
    end

    def rotation_response
      {resultSets: [
        {name: "HomeTeam", headers: rotation_headers, rowSet: []},
        {name: "AwayTeam", headers: rotation_headers, rowSet: [away_row]}
      ]}
    end

    def rotation_headers
      %w[TEAM_ID TEAM_CITY TEAM_NAME PERSON_ID PLAYER_FIRST PLAYER_LAST IN_TIME_REAL OUT_TIME_REAL PLAYER_PTS PT_DIFF USG_PCT]
    end

    def away_row
      [Team::LAL, "Los Angeles", "Lakers", 2544, "LeBron", "James", 0, 7200, 20, -5, 0.32]
    end
  end
end
