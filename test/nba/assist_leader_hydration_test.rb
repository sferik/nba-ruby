require_relative "../test_helper"

module NBA
  class AssistLeaderPlayerHydrationTest < Minitest::Test
    cover AssistLeader

    def test_player_returns_hydrated_player
      stub_player_info_request
      leader = AssistLeader.new(player_id: 201_566)

      player = leader.player

      assert_instance_of Player, player
    end

    def test_player_returns_nil_when_player_id_nil
      leader = AssistLeader.new(player_id: nil)

      assert_nil leader.player
    end

    private

    def stub_player_info_request
      stub_request(:get, /commonplayerinfo/)
        .to_return(body: player_info_response.to_json)
    end

    def player_info_response
      {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID DISPLAY_FIRST_LAST],
                     rowSet: [[201_566, "Russell Westbrook"]]}]}
    end
  end

  class AssistLeaderTeamHydrationTest < Minitest::Test
    cover AssistLeader

    def test_team_returns_hydrated_team
      stub_team_details_request
      leader = AssistLeader.new(team_id: Team::LAC)

      team = leader.team

      assert_instance_of Team, team
    end

    def test_team_returns_nil_when_team_id_nil
      leader = AssistLeader.new(team_id: nil)

      assert_nil leader.team
    end

    private

    def stub_team_details_request
      stub_request(:get, /teamdetails/)
        .to_return(body: team_details_response.to_json)
    end

    def team_details_response
      {resultSets: [{name: "TeamBackground", headers: %w[TEAM_ID CITY NICKNAME ABBREVIATION],
                     rowSet: [[Team::LAC, "Los Angeles", "Clippers", "LAC"]]}]}
    end
  end
end
