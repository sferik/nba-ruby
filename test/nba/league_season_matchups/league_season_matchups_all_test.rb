require_relative "../../test_helper"

module NBA
  class LeagueSeasonMatchupsAllTest < Minitest::Test
    cover LeagueSeasonMatchups

    def test_all_returns_collection
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      assert_instance_of Collection, LeagueSeasonMatchups.all(season: 2024)
    end

    def test_all_uses_correct_result_set
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_equal 201_939, result.first.off_player_id
    end

    def test_all_with_season_type_playoffs
      stub = stub_request(:get, /SeasonType=Playoffs/)
        .to_return(body: matchups_response.to_json)

      LeagueSeasonMatchups.all(season: 2024, season_type: LeagueSeasonMatchups::PLAYOFFS)

      assert_requested stub
    end

    def test_all_with_per_mode_totals
      stub = stub_request(:get, /PerMode=Totals/)
        .to_return(body: matchups_response.to_json)

      LeagueSeasonMatchups.all(season: 2024, per_mode: LeagueSeasonMatchups::TOTALS)

      assert_requested stub
    end

    def test_all_with_off_player_id
      stub = stub_request(:get, /OffPlayerID=201939/)
        .to_return(body: matchups_response.to_json)

      LeagueSeasonMatchups.all(season: 2024, off_player: 201_939)

      assert_requested stub
    end

    def test_all_with_off_player_object
      stub = stub_request(:get, /OffPlayerID=201939/)
        .to_return(body: matchups_response.to_json)
      player = Player.new(id: 201_939)

      LeagueSeasonMatchups.all(season: 2024, off_player: player)

      assert_requested stub
    end

    def test_all_with_def_player_id
      stub = stub_request(:get, /DefPlayerID=203507/)
        .to_return(body: matchups_response.to_json)

      LeagueSeasonMatchups.all(season: 2024, def_player: 203_507)

      assert_requested stub
    end

    def test_all_with_def_player_object
      stub = stub_request(:get, /DefPlayerID=203507/)
        .to_return(body: matchups_response.to_json)
      player = Player.new(id: 203_507)

      LeagueSeasonMatchups.all(season: 2024, def_player: player)

      assert_requested stub
    end

    def test_all_with_off_team_id
      stub = stub_request(:get, /OffTeamID=#{Team::GSW}/o)
        .to_return(body: matchups_response.to_json)

      LeagueSeasonMatchups.all(season: 2024, off_team: Team::GSW)

      assert_requested stub
    end

    def test_all_with_off_team_object
      stub = stub_request(:get, /OffTeamID=#{Team::GSW}/o)
        .to_return(body: matchups_response.to_json)
      team = Team.new(id: Team::GSW)

      LeagueSeasonMatchups.all(season: 2024, off_team: team)

      assert_requested stub
    end

    def test_all_with_def_team_id
      stub = stub_request(:get, /DefTeamID=#{Team::MIL}/o)
        .to_return(body: matchups_response.to_json)

      LeagueSeasonMatchups.all(season: 2024, def_team: Team::MIL)

      assert_requested stub
    end

    def test_all_with_def_team_object
      stub = stub_request(:get, /DefTeamID=#{Team::MIL}/o)
        .to_return(body: matchups_response.to_json)
      team = Team.new(id: Team::MIL)

      LeagueSeasonMatchups.all(season: 2024, def_team: team)

      assert_requested stub
    end

    def test_all_with_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, matchups_response.to_json, [String]

      LeagueSeasonMatchups.all(season: 2024, client: mock_client)

      mock_client.verify
    end

    private

    def matchups_response
      {resultSets: [{name: "SeasonMatchups", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[SEASON_ID OFF_PLAYER_ID OFF_PLAYER_NAME DEF_PLAYER_ID DEF_PLAYER_NAME GP
        MATCHUP_MIN PARTIAL_POSS PLAYER_PTS TEAM_PTS MATCHUP_AST MATCHUP_TOV MATCHUP_BLK
        MATCHUP_FGM MATCHUP_FGA MATCHUP_FG_PCT MATCHUP_FG3M MATCHUP_FG3A MATCHUP_FG3_PCT
        HELP_BLK HELP_FGM HELP_FGA HELP_FG_PERC MATCHUP_FTM MATCHUP_FTA SFL]
    end

    def stat_row
      ["22024", 201_939, "Stephen Curry", 203_507, "Giannis Antetokounmpo", 4,
        12.5, 45.2, 18.0, 22.0, 3.0, 1.0, 0.5,
        6.0, 14.0, 0.429, 2.0, 6.0, 0.333,
        0.0, 1.0, 2.0, 0.500, 4.0, 5.0, 2.0]
    end
  end
end
