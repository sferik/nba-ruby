require_relative "../test_helper"

module NBA
  class GameRotationAllClientPassThroughTest < Minitest::Test
    cover GameRotation

    def test_all_passes_client_to_home_team_and_away_team
      mock_client = Minitest::Mock.new
      mock_client.expect :get, rotation_response.to_json, [String]
      mock_client.expect :get, rotation_response.to_json, [String]

      GameRotation.all(game: "0022400001", client: mock_client)

      mock_client.verify
    end

    private

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
