require_relative "../test_helper"

module NBA
  class AssistTrackerEntryPlayerHydrationTest < Minitest::Test
    cover AssistTrackerEntry

    def test_player_returns_hydrated_player
      stub_player_info_request
      entry = AssistTrackerEntry.new(player_id: 201_566)

      player = entry.player

      assert_instance_of Player, player
    end

    def test_player_returns_nil_when_player_id_nil
      entry = AssistTrackerEntry.new(player_id: nil)

      assert_nil entry.player
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

  class AssistTrackerEntryPassToPlayerHydrationTest < Minitest::Test
    cover AssistTrackerEntry

    def test_pass_to_player_returns_hydrated_player
      stub_player_info_request
      entry = AssistTrackerEntry.new(pass_to_player_id: 202_695)

      player = entry.pass_to_player

      assert_instance_of Player, player
    end

    def test_pass_to_player_returns_nil_when_pass_to_player_id_nil
      entry = AssistTrackerEntry.new(pass_to_player_id: nil)

      assert_nil entry.pass_to_player
    end

    private

    def stub_player_info_request
      stub_request(:get, /commonplayerinfo/)
        .to_return(body: player_info_response.to_json)
    end

    def player_info_response
      {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID DISPLAY_FIRST_LAST],
                     rowSet: [[202_695, "Kawhi Leonard"]]}]}
    end
  end

  class AssistTrackerEntryTeamHydrationTest < Minitest::Test
    cover AssistTrackerEntry

    def test_team_returns_hydrated_team
      stub_team_details_request
      entry = AssistTrackerEntry.new(team_id: Team::LAC)

      team = entry.team

      assert_instance_of Team, team
    end

    def test_team_returns_nil_when_team_id_nil
      entry = AssistTrackerEntry.new(team_id: nil)

      assert_nil entry.team
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
