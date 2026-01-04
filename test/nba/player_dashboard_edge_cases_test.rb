require_relative "../test_helper"

module NBA
  class PlayerDashboardEdgeCasesTest < Minitest::Test
    cover PlayerDashboard

    def test_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, PlayerDashboard.general_splits(player: 201_939, client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, PlayerDashboard.general_splits(player: 201_939).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: {}.to_json)

      assert_equal 0, PlayerDashboard.general_splits(player: 201_939).size
    end

    def test_returns_empty_when_headers_nil
      response = {resultSets: [{name: "OverallPlayerDashboard", headers: nil, rowSet: [["data"]]}]}
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      assert_equal 0, PlayerDashboard.general_splits(player: 201_939).size
    end

    def test_returns_empty_when_rows_nil
      response = {resultSets: [{name: "OverallPlayerDashboard", headers: ["GP"], rowSet: nil}]}
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      assert_equal 0, PlayerDashboard.general_splits(player: 201_939).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "OverallPlayerDashboard", rowSet: [["data"]]}]}
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      assert_equal 0, PlayerDashboard.general_splits(player: 201_939).size
    end

    def test_returns_empty_when_rows_key_missing
      response = {resultSets: [{name: "OverallPlayerDashboard", headers: ["GP"]}]}
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      assert_equal 0, PlayerDashboard.general_splits(player: 201_939).size
    end

    def test_handles_missing_name_key
      stub_request(:get, /playerdashboardbygeneralsplits/)
        .to_return(body: response_without_name.to_json)

      stat = PlayerDashboard.general_splits(player: 201_939).first

      assert_nil stat.group_set
    end

    private

    def response_without_name
      {
        resultSets: [{
          headers: player_dashboard_headers,
          rowSet: [player_dashboard_row]
        }]
      }
    end

    def player_dashboard_headers
      %w[GROUP_VALUE GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS]
    end

    def player_dashboard_row
      ["Overall", 82, 50, 32, 0.610, 34.5, 10.5, 21.2, 0.495, 5.5, 11.8, 0.466,
        5.0, 5.5, 0.909, 0.5, 5.5, 6.0, 5.5, 2.5, 1.0, 0.5, 0.2, 2.0, 3.5, 31.5, 8.5]
    end
  end
end
