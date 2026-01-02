require_relative "../test_helper"

module NBA
  class GameRotationAwayTeamGameIdTest < Minitest::Test
    cover GameRotation

    def test_away_team_sets_game_id_on_entries
      stub_rotation_request

      entries = GameRotation.away_team(game: "0022400999")

      assert_equal "0022400999", entries.first.game_id
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
