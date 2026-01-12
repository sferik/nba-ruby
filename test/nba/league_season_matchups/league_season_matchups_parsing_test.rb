require_relative "../../test_helper"

module NBA
  class LeagueSeasonMatchupsParsingTest < Minitest::Test
    cover LeagueSeasonMatchups

    def test_all_parses_season_id
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_equal "22024", result.first.season_id
    end

    def test_all_parses_off_player_id
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_equal 201_939, result.first.off_player_id
    end

    def test_all_parses_off_player_name
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_equal "Stephen Curry", result.first.off_player_name
    end

    def test_all_parses_def_player_id
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_equal 203_507, result.first.def_player_id
    end

    def test_all_parses_def_player_name
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_equal "Giannis Antetokounmpo", result.first.def_player_name
    end

    def test_all_parses_gp
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_equal 4, result.first.gp
    end

    def test_all_parses_matchup_min
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 12.5, result.first.matchup_min
    end

    def test_all_parses_partial_poss
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 45.2, result.first.partial_poss
    end

    def test_all_parses_player_pts
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 18.0, result.first.player_pts
    end

    def test_all_parses_team_pts
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 22.0, result.first.team_pts
    end

    def test_all_parses_matchup_ast
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 3.0, result.first.matchup_ast
    end

    def test_all_parses_matchup_tov
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 1.0, result.first.matchup_tov
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
