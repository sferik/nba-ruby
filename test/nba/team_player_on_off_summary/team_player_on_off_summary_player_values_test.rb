require_relative "../../test_helper"

module NBA
  class TeamPlayerOnOffSummaryPlayerValuesTest < Minitest::Test
    cover TeamPlayerOnOffSummary

    def setup
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response.to_json)
      @result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744).first
    end

    def test_extracts_group_set
      assert_equal "On", @result.group_set
    end

    def test_extracts_team_id
      assert_equal 1_610_612_744, @result.team_id
    end

    def test_extracts_team_abbreviation
      assert_equal "GSW", @result.team_abbreviation
    end

    def test_extracts_team_name
      assert_equal "Warriors", @result.team_name
    end

    def test_extracts_vs_player_id
      assert_equal 201_566, @result.vs_player_id
    end

    def test_extracts_vs_player_name
      assert_equal "Russell Westbrook", @result.vs_player_name
    end

    def test_extracts_court_status
      assert_equal "On", @result.court_status
    end

    def test_extracts_gp
      assert_equal 20, @result.gp
    end

    def test_extracts_min
      assert_in_delta 48.0, @result.min
    end

    def test_extracts_plus_minus
      assert_in_delta 5.5, @result.plus_minus
    end

    def test_extracts_off_rating
      assert_in_delta 115.2, @result.off_rating
    end

    def test_extracts_def_rating
      assert_in_delta 108.7, @result.def_rating
    end

    def test_extracts_net_rating
      assert_in_delta 6.5, @result.net_rating
    end

    private

    def response
      {resultSets: [{name: "PlayersOnCourtTeamPlayerOnOffSummary", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[GROUP_SET TEAM_ID TEAM_ABBREVIATION TEAM_NAME VS_PLAYER_ID VS_PLAYER_NAME
        COURT_STATUS GP MIN PLUS_MINUS OFF_RATING DEF_RATING NET_RATING]
    end

    def row
      ["On", 1_610_612_744, "GSW", "Warriors", 201_566, "Russell Westbrook", "On",
        20, 48.0, 5.5, 115.2, 108.7, 6.5]
    end
  end
end
