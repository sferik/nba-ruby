require_relative "../../test_helper"
require_relative "team_game_logs_test_helper"

module NBA
  class TeamGameLogsParamsTest < Minitest::Test
    include TeamGameLogsTestHelper

    cover TeamGameLogs

    def test_all_with_season_param
      stub_request(:get, /Season=2023-24/).to_return(body: team_game_logs_response.to_json)

      TeamGameLogs.all(season: 2023)

      assert_requested :get, /Season=2023-24/
    end

    def test_all_with_season_type_param
      stub_request(:get, /SeasonType=Playoffs/).to_return(body: team_game_logs_response.to_json)

      TeamGameLogs.all(season_type: TeamGameLogs::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_all_defaults_to_regular_season
      stub_request(:get, /SeasonType=Regular(%20|\+)Season/).to_return(body: team_game_logs_response.to_json)

      TeamGameLogs.all

      assert_requested :get, /SeasonType=Regular(%20|\+)Season/
    end

    def test_all_with_team_param
      stub_request(:get, /TeamID=1610612744/).to_return(body: team_game_logs_response.to_json)

      TeamGameLogs.all(team: Team::GSW)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_all_with_team_object_extracts_id
      stub_request(:get, /TeamID=1610612744/).to_return(body: team_game_logs_response.to_json)
      team = Team.new(id: Team::GSW)

      TeamGameLogs.all(team: team)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_all_with_per_mode_param
      stub_request(:get, /PerModeSimple=Totals/).to_return(body: team_game_logs_response.to_json)

      TeamGameLogs.all(per_mode: TeamGameLogs::TOTALS)

      assert_requested :get, /PerModeSimple=Totals/
    end

    def test_all_defaults_to_per_game
      stub_request(:get, /PerModeSimple=PerGame/).to_return(body: team_game_logs_response.to_json)

      TeamGameLogs.all

      assert_requested :get, /PerModeSimple=PerGame/
    end

    def test_all_includes_league_id
      stub_request(:get, /LeagueID=00/).to_return(body: team_game_logs_response.to_json)

      TeamGameLogs.all

      assert_requested :get, /LeagueID=00/
    end

    def test_all_parses_from_correct_result_set
      stub_request(:get, /teamgamelogs/).to_return(body: multi_result_response.to_json)

      log = TeamGameLogs.all.first

      assert_equal Team::GSW, log.team_id
    end

    def test_all_with_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, team_game_logs_response.to_json, [String]

      TeamGameLogs.all(season: 2024, client: mock_client)

      mock_client.verify
    end

    private

    def multi_result_response
      {resultSets: [
        {name: "OtherResultSet", headers: ["TEAM_ID"], rowSet: [[12_345]]},
        {name: "TeamGameLogs", headers: stat_headers, rowSet: [stat_row]}
      ]}
    end
  end
end
