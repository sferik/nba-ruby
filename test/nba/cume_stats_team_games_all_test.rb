require_relative "../test_helper"

module NBA
  class CumeStatsTeamGamesBasicTest < Minitest::Test
    cover CumeStatsTeamGames

    HEADERS = %w[MATCHUP GAME_ID].freeze
    ROW = ["LAL @ DEN", 22_300_001].freeze

    def test_all_returns_collection
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      result = CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_team_id_in_path
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_requested :get, /TeamID=1610612747/
    end

    def test_all_uses_correct_season_in_path
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_requested :get, /Season=2023-24/
    end

    def test_all_uses_correct_season_type_in_path
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_all_uses_default_season_type_when_not_specified
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_all_uses_correct_league_in_path
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, league: "10")

      assert_requested :get, /LeagueID=10/
    end

    def test_all_uses_default_league_when_not_specified
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_requested :get, /LeagueID=00/
    end

    def test_all_parses_entries_successfully
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      entries = CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_equal 1, entries.size
      assert_equal 22_300_001, entries.first.game_id
      assert_equal "LAL @ DEN", entries.first.matchup
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, response.to_json, [String]

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, client: mock_client)

      mock_client.verify
    end

    def test_all_accepts_league_object
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)
      league = League.new(id: "10")

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, league: league)

      assert_requested :get, /LeagueID=10/
    end

    def test_all_accepts_team_object
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)
      team = Team.new(id: 1_610_612_747)

      CumeStatsTeamGames.all(team: team, season: 2023)

      assert_requested :get, /TeamID=1610612747/
    end

    private

    def response
      {resultSets: [{name: "CumeStatsTeamGames", headers: HEADERS, rowSet: [ROW]}]}
    end
  end

  class CumeStatsTeamGamesOptionalParamsTest < Minitest::Test
    cover CumeStatsTeamGames

    def test_all_with_location_parameter
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, location: "Home")

      assert_requested :get, /Location=Home/
    end

    def test_all_with_outcome_parameter
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, outcome: "W")

      assert_requested :get, /Outcome=W/
    end

    def test_all_with_season_id_parameter
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, season_id: "22023")

      assert_requested :get, /SeasonID=22023/
    end

    def test_all_with_vs_conference_parameter
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, vs_conference: "East")

      assert_requested :get, /VsConference=East/
    end

    def test_all_with_vs_division_parameter
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, vs_division: "Pacific")

      assert_requested :get, /VsDivision=Pacific/
    end

    def test_all_with_vs_team_parameter
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, vs_team: 1_610_612_743)

      assert_requested :get, /VsTeamID=1610612743/
    end

    def test_all_with_vs_team_object
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)
      vs_team = Team.new(id: 1_610_612_743)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, vs_team: vs_team)

      assert_requested :get, /VsTeamID=1610612743/
    end

    def test_all_includes_all_params_when_specified
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)
      call_with_all_params

      assert_requested :get, /LeagueID=10.*SeasonType=Playoffs.*TeamID=1610612747/
    end

    def test_all_without_location_omits_location_param
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_not_requested :get, /Location=/
    end

    def test_all_without_outcome_omits_outcome_param
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_not_requested :get, /Outcome=/
    end

    def test_all_without_season_id_omits_season_id_param
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_not_requested :get, /SeasonID=/
    end

    def test_all_without_vs_conference_omits_vs_conference_param
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_not_requested :get, /VsConference=/
    end

    def test_all_without_vs_division_omits_vs_division_param
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_not_requested :get, /VsDivision=/
    end

    def test_all_without_vs_team_omits_vs_team_id_param
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_not_requested :get, /VsTeamID=/
    end

    private

    def call_with_all_params
      CumeStatsTeamGames.all(
        team: 1_610_612_747, season: 2023, season_type: "Playoffs", league: "10",
        location: "Home", outcome: "W", season_id: "22023",
        vs_conference: "East", vs_division: "Pacific", vs_team: 1_610_612_743
      )
    end

    def response
      {resultSets: [{name: "CumeStatsTeamGames", headers: %w[MATCHUP GAME_ID], rowSet: [["LAL @ DEN", 22_300_001]]}]}
    end
  end

  class CumeStatsTeamGamesAttributeTest < Minitest::Test
    cover CumeStatsTeamGames

    def test_parses_matchup
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      assert_equal "LAL @ DEN", CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023).first.matchup
    end

    def test_parses_game_id
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      assert_equal 22_300_001, CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023).first.game_id
    end

    private

    def response
      headers = %w[MATCHUP GAME_ID]
      row = ["LAL @ DEN", 22_300_001]
      {resultSets: [{name: "CumeStatsTeamGames", headers: headers, rowSet: [row]}]}
    end
  end
end
