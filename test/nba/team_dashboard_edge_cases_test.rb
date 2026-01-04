require_relative "../test_helper"

module NBA
  class TeamDashboardEdgeCasesTest < Minitest::Test
    cover TeamDashboard

    def test_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, TeamDashboard.general_splits(team: Team::GSW, client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, TeamDashboard.general_splits(team: Team::GSW).size
    end

    def test_returns_empty_when_headers_nil
      response = {resultSets: [{name: "OverallTeamDashboard", headers: nil, rowSet: [["data"]]}]}
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      assert_equal 0, TeamDashboard.general_splits(team: Team::GSW).size
    end

    def test_returns_empty_when_rows_nil
      response = {resultSets: [{name: "OverallTeamDashboard", headers: ["GP"], rowSet: nil}]}
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      assert_equal 0, TeamDashboard.general_splits(team: Team::GSW).size
    end

    def test_returns_empty_when_result_sets_missing
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: {}.to_json)

      assert_equal 0, TeamDashboard.general_splits(team: Team::GSW).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "OverallTeamDashboard", rowSet: [["data"]]}]}
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      assert_equal 0, TeamDashboard.general_splits(team: Team::GSW).size
    end

    def test_returns_empty_when_rows_key_missing
      response = {resultSets: [{name: "OverallTeamDashboard", headers: ["GP"]}]}
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      assert_equal 0, TeamDashboard.general_splits(team: Team::GSW).size
    end

    def test_handles_missing_name_key
      stub_request(:get, /teamdashboardbygeneralsplits/)
        .to_return(body: response_without_name.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.group_set
    end

    private

    def response_without_name
      {
        resultSets: [{
          headers: team_dashboard_headers,
          rowSet: [team_dashboard_row]
        }]
      }
    end

    def team_dashboard_headers
      %w[GROUP_VALUE GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS]
    end

    def team_dashboard_row
      ["Overall", 82, 50, 32, 0.610, 48.0, 42.5, 88.2, 0.482, 14.5, 38.8, 0.374,
        18.0, 22.5, 0.800, 10.5, 35.5, 46.0, 28.5, 13.5, 8.0, 5.5, 4.0, 19.0, 21.0, 117.5, 5.5]
    end
  end
end
