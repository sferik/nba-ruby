require_relative "../test_helper"

module NBA
  class LeagueDashPlayerShotLocationStatTest < Minitest::Test
    cover LeagueDashPlayerShotLocationStat

    def test_equality_based_on_player_id_and_team_id
      stat1 = LeagueDashPlayerShotLocationStat.new(player_id: 201_939, team_id: Team::GSW)
      stat2 = LeagueDashPlayerShotLocationStat.new(player_id: 201_939, team_id: Team::GSW)

      assert_equal stat1, stat2
    end

    def test_inequality_when_player_id_differs
      stat1 = LeagueDashPlayerShotLocationStat.new(player_id: 201_939, team_id: Team::GSW)
      stat2 = LeagueDashPlayerShotLocationStat.new(player_id: 203_110, team_id: Team::GSW)

      refute_equal stat1, stat2
    end

    def test_inequality_when_team_id_differs
      stat1 = LeagueDashPlayerShotLocationStat.new(player_id: 201_939, team_id: Team::GSW)
      stat2 = LeagueDashPlayerShotLocationStat.new(player_id: 201_939, team_id: Team::LAL)

      refute_equal stat1, stat2
    end

    def test_player_lazy_hydration
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)
      stat = LeagueDashPlayerShotLocationStat.new(player_id: 201_939)

      player = stat.player

      assert_equal 201_939, player.id
    end

    def test_team_lazy_hydration
      stub_request(:get, /commonteaminfo/).to_return(body: team_response.to_json)
      stat = LeagueDashPlayerShotLocationStat.new(team_id: Team::GSW)

      team = stat.team

      assert_equal Team::GSW, team.id
    end

    private

    def player_response
      {resultSets: [{name: "CommonPlayerInfo",
                     headers: %w[PERSON_ID DISPLAY_FIRST_LAST],
                     rowSet: [[201_939, "Stephen Curry"]]}]}
    end

    def team_response
      {resultSets: [{name: "TeamInfoCommon",
                     headers: %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY TEAM_CONFERENCE
                       TEAM_DIVISION],
                     rowSet: [[Team::GSW, "Warriors", "GSW", "Golden State", "West", "Pacific"]]}]}
    end
  end
end
