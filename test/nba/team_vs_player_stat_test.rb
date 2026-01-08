require_relative "../test_helper"

module NBA
  class TeamVsPlayerStatTest < Minitest::Test
    cover TeamVsPlayerStat

    def test_team_returns_team_from_teams
      stub_request(:get, /teaminfocommon/).to_return(body: team_response.to_json)
      stat = TeamVsPlayerStat.new(team_id: 1_610_612_744)

      assert_equal 1_610_612_744, stat.team.id
    end

    def test_vs_player_returns_player_from_players
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)
      stat = TeamVsPlayerStat.new(vs_player_id: 201_566)

      assert_equal 201_566, stat.vs_player.id
    end

    private

    def team_response
      {resultSets: [{name: "TeamInfoCommon", headers: %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION],
                     rowSet: [[1_610_612_744, "Warriors", "GSW"]]}]}
    end

    def player_response
      {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID DISPLAY_FIRST_LAST],
                     rowSet: [[201_566, "Russell Westbrook"]]}]}
    end
  end
end
