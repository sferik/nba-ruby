require_relative "../../test_helper"

module NBA
  class TeamDashPtPassValuesTest < Minitest::Test
    cover TeamDashPtPass

    def test_extracts_team_id
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_equal 1_610_612_744, result.team_id
    end

    def test_extracts_team_name
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_equal "Golden State Warriors", result.team_name
    end

    def test_extracts_pass_type
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_equal "Made", result.pass_type
    end

    def test_extracts_g
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_equal 82, result.g
    end

    def test_extracts_pass_from
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_equal "Stephen Curry", result.pass_from
    end

    def test_extracts_pass_teammate_player_id
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_equal 201_939, result.pass_teammate_player_id
    end

    def test_extracts_frequency
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_in_delta 0.15, result.frequency
    end

    def test_extracts_pass
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_in_delta 5.2, result.pass
    end

    def test_extracts_ast
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_in_delta 2.1, result.ast
    end

    def test_extracts_fgm
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_in_delta 3.5, result.fgm
    end

    def test_extracts_fga
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_in_delta 7.2, result.fga
    end

    def test_extracts_fg_pct
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_in_delta 0.486, result.fg_pct
    end

    private

    def response
      {resultSets: [{name: "PassesMade", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[TEAM_ID TEAM_NAME PASS_TYPE G PASS_FROM PASS_TEAMMATE_PLAYER_ID FREQUENCY PASS AST
        FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", "Made", 82, "Stephen Curry", 201_939, 0.15, 5.2, 2.1,
        3.5, 7.2, 0.486, 1.5, 3.0, 0.5, 2.0, 4.2, 0.476]
    end
  end
end
