require_relative "../../test_helper"

module NBA
  class PlayerDashPtPassApiParamsTest < Minitest::Test
    cover PlayerDashPtPass

    def test_passes_made_uses_correct_result_set
      stub_request(:get, /playerdashptpass/).to_return(body: response_with_both_result_sets.to_json)

      assert_equal "Made", PlayerDashPtPass.passes_made(player: 201_939).first.pass_type
    end

    def test_passes_received_uses_correct_result_set
      stub_request(:get, /playerdashptpass/).to_return(body: response_with_both_result_sets.to_json)

      assert_equal "Received", PlayerDashPtPass.passes_received(player: 201_939).first.pass_type
    end

    def test_includes_player_id_in_path
      request = stub_request(:get, /playerdashptpass.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_made(player: 201_939)

      assert_requested request
    end

    def test_extracts_id_from_player_object
      player = Minitest::Mock.new
      player.expect :id, 201_939
      request = stub_request(:get, /playerdashptpass.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_made(player: player)

      assert_requested request
      player.verify
    end

    def test_extracts_id_from_team_object
      team = Minitest::Mock.new
      team.expect :id, 1_610_612_744
      request = stub_request(:get, /playerdashptpass.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_made(player: 201_939, team: team)

      assert_requested request
      team.verify
    end

    def test_includes_team_id_in_path
      request = stub_request(:get, /playerdashptpass.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_made(player: 201_939, team: 1_610_612_744)

      assert_requested request
    end

    def test_includes_season_in_path
      request = stub_request(:get, /playerdashptpass.*Season=2023-24/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_made(player: 201_939, season: 2023)

      assert_requested request
    end

    def test_includes_season_type_in_path
      request = stub_request(:get, /playerdashptpass.*SeasonType=Playoffs/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_made(player: 201_939, season_type: "Playoffs")

      assert_requested request
    end

    def test_includes_per_mode_in_path
      request = stub_request(:get, /playerdashptpass.*PerMode=Totals/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_made(player: 201_939, per_mode: "Totals")

      assert_requested request
    end

    def test_includes_league_id_in_path
      request = stub_request(:get, /playerdashptpass.*LeagueID=00/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_made(player: 201_939)

      assert_requested request
    end

    private

    def response_with_both_result_sets
      {resultSets: [
        {name: "PassesMade", headers: headers, rowSet: [made_row]},
        {name: "PassesReceived", headers: headers, rowSet: [received_row]}
      ]}
    end

    def headers
      %w[PLAYER_ID PLAYER_NAME_LAST_FIRST TEAM_ID TEAM_ABBREVIATION PASS_TEAMMATE_PLAYER_ID
        PASS_TO GP G PASS_TYPE FREQUENCY PASS AST FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT]
    end

    def made_row
      [201_939, "Curry, Stephen", 1_610_612_744, "GSW", 202_691, "Klay Thompson", 74, 74, "Made",
        0.25, 5.2, 2.1, 3.5, 7.2, 0.486, 1.5, 3.0, 0.500, 2.0, 4.2, 0.476]
    end

    def received_row
      [201_939, "Curry, Stephen", 1_610_612_744, "GSW", 203_110, "Draymond Green", 74, 74, "Received",
        0.20, 3.8, 1.5, 2.8, 5.5, 0.509, 1.2, 2.5, 0.480, 1.6, 3.0, 0.533]
    end

    def empty_response
      {resultSets: [{name: "PassesMade", headers: [], rowSet: []}]}
    end
  end
end
