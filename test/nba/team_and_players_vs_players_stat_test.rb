require_relative "../test_helper"

module NBA
  class TeamAndPlayersVsPlayersStatTest < Minitest::Test
    cover TeamAndPlayersVsPlayersStat

    def test_team_returns_team_from_teams
      stub_request(:get, /teaminfocommon/).to_return(body: team_response.to_json)
      stat = TeamAndPlayersVsPlayersStat.new(team_id: 1_610_612_744)

      assert_equal 1_610_612_744, stat.team.id
    end

    def test_player_returns_player_from_players
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)
      stat = TeamAndPlayersVsPlayersStat.new(player_id: 201_939)

      assert_equal 201_939, stat.player.id
    end

    def test_vs_player_returns_player_from_players
      stub_request(:get, /commonplayerinfo/).to_return(body: vs_player_response.to_json)
      stat = TeamAndPlayersVsPlayersStat.new(vs_player_id: 2544)

      assert_equal 2544, stat.vs_player.id
    end

    private

    def team_response
      {resultSets: [{name: "TeamInfoCommon", headers: %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION],
                     rowSet: [[1_610_612_744, "Warriors", "GSW"]]}]}
    end

    def player_response
      {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID DISPLAY_FIRST_LAST],
                     rowSet: [[201_939, "Stephen Curry"]]}]}
    end

    def vs_player_response
      {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID DISPLAY_FIRST_LAST],
                     rowSet: [[2544, "LeBron James"]]}]}
    end
  end
end
