require_relative "../../test_helper"

module NBA
  class PlayerIndexEntryHydrationTest < Minitest::Test
    cover PlayerIndexEntry

    def test_player_fetches_player_by_id
      stub_request(:get, /commonplayerinfo\?PlayerID=201939/).to_return(body: player_response.to_json)

      entry = PlayerIndexEntry.new(id: 201_939)
      player = entry.player

      assert_equal 201_939, player.id
    end

    def test_team_fetches_team_by_id
      stub_request(:get, /teaminfocommon\?TeamID=1610612744/).to_return(body: team_response.to_json)

      entry = PlayerIndexEntry.new(team_id: 1_610_612_744)
      team = entry.team

      assert_equal 1_610_612_744, team.id
    end

    private

    def player_response
      {
        resultSets: [{
          name: "CommonPlayerInfo",
          headers: %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS],
          rowSet: [[201_939, "Stephen Curry", "Stephen", "Curry", "Active"]]
        }]
      }
    end

    def team_response
      {
        resultSets: [{
          name: "TeamInfoCommon",
          headers: %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY],
          rowSet: [[1_610_612_744, "Warriors", "GSW", "Golden State"]]
        }]
      }
    end
  end
end
