require_relative "../test_helper"

module NBA
  class LeagueSeasonMatchupsShootingParsingTest < Minitest::Test
    cover LeagueSeasonMatchups

    def test_all_parses_matchup_blk
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 0.5, result.first.matchup_blk
    end

    def test_all_parses_matchup_fgm
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 6.0, result.first.matchup_fgm
    end

    def test_all_parses_matchup_fga
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 14.0, result.first.matchup_fga
    end

    def test_all_parses_matchup_fg_pct
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 0.429, result.first.matchup_fg_pct
    end

    def test_all_parses_matchup_fg3m
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 2.0, result.first.matchup_fg3m
    end

    def test_all_parses_matchup_fg3a
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 6.0, result.first.matchup_fg3a
    end

    def test_all_parses_matchup_fg3_pct
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 0.333, result.first.matchup_fg3_pct
    end

    def test_all_parses_help_blk
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 0.0, result.first.help_blk
    end

    def test_all_parses_help_fgm
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 1.0, result.first.help_fgm
    end

    def test_all_parses_help_fga
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 2.0, result.first.help_fga
    end

    def test_all_parses_help_fg_pct
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 0.500, result.first.help_fg_pct
    end

    def test_all_parses_matchup_ftm
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 4.0, result.first.matchup_ftm
    end

    def test_all_parses_matchup_fta
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 5.0, result.first.matchup_fta
    end

    def test_all_parses_sfl
      stub_request(:get, /leagueseasonmatchups/).to_return(body: matchups_response.to_json)

      result = LeagueSeasonMatchups.all(season: 2024)

      assert_in_delta 2.0, result.first.sfl
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
