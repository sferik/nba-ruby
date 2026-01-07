require_relative "../test_helper"

module NBA
  class PassStatTest < Minitest::Test
    cover PassStat

    def test_player_returns_player_object
      stub_player_request
      stat = PassStat.new(player_id: 201_939)

      assert_instance_of Player, stat.player
    end

    def test_teammate_returns_player_object
      stub_teammate_request
      stat = PassStat.new(pass_teammate_player_id: 202_691)

      assert_instance_of Player, stat.teammate
    end

    def test_team_returns_team_object
      stub_team_request
      stat = PassStat.new(team_id: 1_610_612_744)

      assert_instance_of Team, stat.team
    end

    private

    def stub_player_request
      stub_request(:get, /commonplayerinfo.*PlayerID=201939/)
        .to_return(body: player_response.to_json)
    end

    def stub_teammate_request
      stub_request(:get, /commonplayerinfo.*PlayerID=202691/)
        .to_return(body: player_response(202_691).to_json)
    end

    def stub_team_request
      stub_request(:get, /teaminfocommon.*TeamID=1610612744/)
        .to_return(body: team_response.to_json)
    end

    def player_response(id = 201_939)
      {resultSets: [{name: "CommonPlayerInfo",
                     headers: %w[PERSON_ID DISPLAY_FIRST_LAST],
                     rowSet: [[id, "Stephen Curry"]]}]}
    end

    def team_response
      {resultSets: [{name: "TeamInfoCommon",
                     headers: %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY],
                     rowSet: [[1_610_612_744, "Warriors", "GSW", "Golden State"]]}]}
    end
  end
end
