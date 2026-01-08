require_relative "../test_helper"

module NBA
  class LeagueDashPlayerBioStatTest < Minitest::Test
    cover LeagueDashPlayerBioStat

    def test_equality_based_on_player_id_and_team_id
      stat1 = LeagueDashPlayerBioStat.new(player_id: 201_939, team_id: Team::GSW)
      stat2 = LeagueDashPlayerBioStat.new(player_id: 201_939, team_id: Team::GSW)

      assert_equal stat1, stat2
    end

    def test_inequality_with_different_player_id
      stat1 = LeagueDashPlayerBioStat.new(player_id: 201_939, team_id: Team::GSW)
      stat2 = LeagueDashPlayerBioStat.new(player_id: 201_566, team_id: Team::GSW)

      refute_equal stat1, stat2
    end

    def test_inequality_with_different_team_id
      stat1 = LeagueDashPlayerBioStat.new(player_id: 201_939, team_id: Team::GSW)
      stat2 = LeagueDashPlayerBioStat.new(player_id: 201_939, team_id: Team::LAL)

      refute_equal stat1, stat2
    end

    def test_player_returns_player_object
      stat = LeagueDashPlayerBioStat.new(player_id: 201_939)
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)

      assert_instance_of Player, stat.player
    end

    def test_team_returns_team_object
      stat = LeagueDashPlayerBioStat.new(team_id: Team::GSW)
      stub_request(:get, /teamdetails/).to_return(body: team_response.to_json)

      assert_instance_of Team, stat.team
    end

    private

    def player_response
      {resultSets: [{name: "CommonPlayerInfo",
                     headers: %w[PERSON_ID DISPLAY_FIRST_LAST],
                     rowSet: [[201_939, "Stephen Curry"]]}]}
    end

    def team_response
      {resultSets: [{name: "TeamBackground",
                     headers: %w[TEAM_ID ABBREVIATION NICKNAME CITY ARENA],
                     rowSet: [[Team::GSW, "GSW", "Warriors", "Golden State", "Chase Center"]]}]}
    end
  end
end
