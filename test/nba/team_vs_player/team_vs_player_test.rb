require_relative "../../test_helper"

module NBA
  class TeamVsPlayerTest < Minitest::Test
    cover TeamVsPlayer

    def test_overall_returns_collection
      stub_request(:get, /teamvsplayer/).to_return(body: overall_response.to_json)

      assert_instance_of Collection, TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566)
    end

    def test_overall_uses_correct_result_set
      stub_request(:get, /teamvsplayer/).to_return(body: response_with_both_result_sets.to_json)

      assert_equal "Overall", TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566).first.court_status
    end

    def test_on_off_court_returns_collection
      stub_request(:get, /teamvsplayer/).to_return(body: on_off_court_response.to_json)

      assert_instance_of Collection, TeamVsPlayer.on_off_court(team: 1_610_612_744, vs_player: 201_566)
    end

    def test_on_off_court_uses_correct_result_set
      stub_request(:get, /teamvsplayer/).to_return(body: response_with_both_result_sets.to_json)

      assert_equal "On", TeamVsPlayer.on_off_court(team: 1_610_612_744, vs_player: 201_566).first.court_status
    end

    def test_returns_empty_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_empty TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566, client: mock_client)
      mock_client.verify
    end

    def test_returns_empty_for_empty_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, "", [String]

      assert_empty TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566, client: mock_client)
      mock_client.verify
    end

    private

    def overall_response
      {resultSets: [{name: "Overall", headers: headers, rowSet: [row_data("Overall")]}]}
    end

    def on_off_court_response
      {resultSets: [{name: "OnOffCourt", headers: headers, rowSet: [row_data("On")]}]}
    end

    def response_with_both_result_sets
      {resultSets: [
        {name: "Overall", headers: headers, rowSet: [row_data("Overall")]},
        {name: "OnOffCourt", headers: headers, rowSet: [row_data("On")]}
      ]}
    end

    def row_data(status)
      [1_610_612_744, 201_566, status, 24, 32.5, 106.4, 45.7, 26.1, 8.2, 5.3, 13.1, 0.467, 8.5]
    end

    def headers
      %w[TEAM_ID VS_PLAYER_ID COURT_STATUS GP MIN PTS REB AST STL BLK TOV FG_PCT PLUS_MINUS]
    end
  end
end
