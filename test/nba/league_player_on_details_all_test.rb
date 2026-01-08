require_relative "../test_helper"

module NBA
  class LeaguePlayerOnDetailsAllTest < Minitest::Test
    cover LeaguePlayerOnDetails

    def test_all_returns_collection
      stub_player_on_details_request

      result = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_team_id_in_path
      stub_player_on_details_request

      LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024)

      assert_requested :get, /leagueplayerondetails.*TeamID=#{Team::GSW}/o
    end

    def test_all_uses_correct_season_in_path
      stub_player_on_details_request

      LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024)

      assert_requested :get, /leagueplayerondetails.*Season=2024-25/
    end

    def test_all_uses_correct_per_mode_in_path
      stub_player_on_details_request

      LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024, per_mode: LeaguePlayerOnDetails::TOTALS)

      assert_requested :get, /PerMode=Totals/
    end

    def test_all_uses_correct_season_type_in_path
      stub_player_on_details_request

      LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024, season_type: LeaguePlayerOnDetails::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_all_uses_correct_measure_type_in_path
      stub_player_on_details_request

      LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024, measure_type: LeaguePlayerOnDetails::BASE)

      assert_requested :get, /MeasureType=Base/
    end

    def test_all_parses_stats_successfully
      stub_player_on_details_request

      stats = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024)

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_all_accepts_team_object
      team = Team.new(id: Team::GSW)
      stub_player_on_details_request

      LeaguePlayerOnDetails.all(team:, season: 2024)

      assert_requested :get, /TeamID=#{Team::GSW}/o
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, player_on_details_response.to_json, [String]

      LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024, client: mock_client)

      mock_client.verify
    end

    private

    def stub_player_on_details_request
      stub_request(:get, /leagueplayerondetails/).to_return(body: player_on_details_response.to_json)
    end

    def player_on_details_response
      {resultSets: [{name: "PlayersOnCourtLeaguePlayerDetails", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[GROUP_SET TEAM_ID TEAM_ABBREVIATION TEAM_NAME VS_PLAYER_ID VS_PLAYER_NAME COURT_STATUS
        GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS]
    end

    def stat_row
      ["Overall", Team::GSW, "GSW", "Golden State Warriors", 201_939, "Stephen Curry", "On",
        74, 46, 28, 0.622, 32.5, 9.8, 20.2, 0.485, 4.8, 11.7, 0.411, 4.2, 4.6, 0.913,
        0.7, 5.4, 6.1, 6.3, 3.2, 0.9, 0.4, 0.3, 2.0, 3.8, 28.6, 7.4]
    end
  end
end
