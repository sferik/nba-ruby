require_relative "../test_helper"

module NBA
  class TeamVsPlayerEdgeCasesTest < Minitest::Test
    cover TeamVsPlayer

    def test_handles_missing_result_sets
      stub_request(:get, /teamvsplayer/).to_return(body: {}.to_json)

      assert_empty TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566)
    end

    def test_handles_missing_result_set
      stub_request(:get, /teamvsplayer/).to_return(body: {resultSets: []}.to_json)

      assert_empty TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566)
    end

    def test_handles_missing_headers
      response = {resultSets: [{name: "Overall", rowSet: []}]}
      stub_request(:get, /teamvsplayer/).to_return(body: response.to_json)

      assert_empty TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566)
    end

    def test_handles_missing_row_set
      response = {resultSets: [{name: "Overall", headers: []}]}
      stub_request(:get, /teamvsplayer/).to_return(body: response.to_json)

      assert_empty TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566)
    end

    def test_handles_wrong_result_set_name
      response = {resultSets: [{name: "WrongName", headers: [], rowSet: []}]}
      stub_request(:get, /teamvsplayer/).to_return(body: response.to_json)

      assert_empty TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566)
    end

    def test_on_off_court_returns_empty_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_empty TeamVsPlayer.on_off_court(team: 1_610_612_744, vs_player: 201_566, client: mock_client)
      mock_client.verify
    end

    def test_on_off_court_returns_empty_for_empty_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, "", [String]

      assert_empty TeamVsPlayer.on_off_court(team: 1_610_612_744, vs_player: 201_566, client: mock_client)
      mock_client.verify
    end

    def test_handles_nil_headers_with_rows_present
      response = {resultSets: [{name: "Overall", headers: nil, rowSet: [[1, 2]]}]}
      stub_request(:get, /teamvsplayer/).to_return(body: response.to_json)

      assert_empty TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566)
    end

    def test_handles_result_set_without_name_key
      response = {resultSets: [{headers: [], rowSet: []}]}
      stub_request(:get, /teamvsplayer/).to_return(body: response.to_json)

      assert_empty TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566)
    end
  end
end
