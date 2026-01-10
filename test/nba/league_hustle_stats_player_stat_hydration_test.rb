require_relative "../test_helper"

module NBA
  class LeagueHustleStatsPlayerStatHydrationTest < Minitest::Test
    cover LeagueHustleStatsPlayerStat

    def test_player_returns_player_object
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)

      stat = LeagueHustleStatsPlayerStat.new(player_id: 201_939)

      assert_instance_of Player, stat.player
    end

    def test_player_uses_player_id_for_lookup
      stub_request(:get, /commonplayerinfo\?PlayerID=201939/).to_return(body: player_response.to_json)

      stat = LeagueHustleStatsPlayerStat.new(player_id: 201_939)
      stat.player

      assert_requested :get, /PlayerID=201939/
    end

    def test_team_returns_team_object
      stat = LeagueHustleStatsPlayerStat.new(team_id: Team::GSW)

      assert_instance_of Team, stat.team
    end

    def test_team_uses_team_id_for_lookup
      stat = LeagueHustleStatsPlayerStat.new(team_id: Team::GSW)

      assert_equal Team::GSW, stat.team.id
    end

    private

    def player_response
      {
        resultSets: [{
          name: "CommonPlayerInfo",
          headers: %w[PERSON_ID DISPLAY_FIRST_LAST],
          rowSet: [[201_939, "Stephen Curry"]]
        }]
      }
    end
  end
end
