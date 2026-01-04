require_relative "../test_helper"

module NBA
  # rubocop:disable Metrics/ClassLength
  class LeagueHustleStatsTest < Minitest::Test
    cover LeagueHustleStats

    def test_player_stats_returns_collection
      stub_player_hustle_request

      assert_instance_of Collection, LeagueHustleStats.player_stats
    end

    def test_player_stats_parses_player_identity
      stat = player_stat

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
      assert_equal 36, stat.age
    end

    def test_player_stats_parses_game_stats
      stat = player_stat

      assert_equal 82, stat.gp
      assert_equal 50, stat.w
      assert_equal 32, stat.l
      assert_in_delta 34.5, stat.min
    end

    def test_player_stats_parses_contested_shots
      stat = player_stat

      assert_in_delta 5.5, stat.contested_shots
      assert_in_delta 3.5, stat.contested_shots_2pt
      assert_in_delta 2.0, stat.contested_shots_3pt
    end

    def test_player_stats_parses_deflections_charges
      stat = player_stat

      assert_in_delta 2.5, stat.deflections
      assert_in_delta 0.2, stat.charges_drawn
    end

    def test_player_stats_parses_screen_assists
      stat = player_stat

      assert_in_delta 3.0, stat.screen_assists
      assert_in_delta 7.5, stat.screen_ast_pts
    end

    def test_player_stats_parses_loose_balls
      stat = player_stat

      assert_in_delta 1.0, stat.loose_balls_recovered
      assert_in_delta 0.5, stat.off_loose_balls_recovered
      assert_in_delta 0.5, stat.def_loose_balls_recovered
    end

    def test_player_stats_parses_box_outs
      stat = player_stat

      assert_in_delta 2.0, stat.box_outs
      assert_in_delta 0.5, stat.off_box_outs
      assert_in_delta 1.5, stat.def_box_outs
    end

    def test_team_stats_returns_collection
      stub_team_hustle_request

      assert_instance_of Collection, LeagueHustleStats.team_stats
    end

    def test_team_stats_parses_team_identity
      stat = team_stat

      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
    end

    def test_team_stats_parses_game_stats
      stat = team_stat

      assert_equal 82, stat.gp
      assert_equal 50, stat.w
      assert_equal 32, stat.l
      assert_in_delta 48.0, stat.min
    end

    def test_team_stats_parses_contested_shots
      stat = team_stat

      assert_in_delta 55.0, stat.contested_shots
      assert_in_delta 35.0, stat.contested_shots_2pt
      assert_in_delta 20.0, stat.contested_shots_3pt
    end

    def test_team_stats_parses_deflections
      stat = team_stat

      assert_in_delta 15.0, stat.deflections
    end

    def test_player_stats_accepts_season_param
      stub_request(:get, /leaguehustlestatsplayer.*Season=2023-24/).to_return(body: player_hustle_response.to_json)
      LeagueHustleStats.player_stats(season: 2023)

      assert_requested :get, /leaguehustlestatsplayer.*Season=2023-24/
    end

    def test_player_stats_accepts_season_type_param
      stub_request(:get, /leaguehustlestatsplayer.*SeasonType=Playoffs/).to_return(body: player_hustle_response.to_json)
      LeagueHustleStats.player_stats(season_type: LeagueHustleStats::PLAYOFFS)

      assert_requested :get, /leaguehustlestatsplayer.*SeasonType=Playoffs/
    end

    def test_player_stats_accepts_per_mode_param
      stub_request(:get, /leaguehustlestatsplayer.*PerMode=Totals/).to_return(body: player_hustle_response.to_json)
      LeagueHustleStats.player_stats(per_mode: LeagueHustleStats::TOTALS)

      assert_requested :get, /leaguehustlestatsplayer.*PerMode=Totals/
    end

    def test_returns_empty_for_nil_responses
      assert_equal 0, LeagueHustleStats.player_stats(client: nil_client).size
      assert_equal 0, LeagueHustleStats.team_stats(client: nil_client).size
    end

    def test_player_returns_empty_for_invalid_responses
      stub_player_response({resultSets: nil})

      assert_equal 0, LeagueHustleStats.player_stats.size

      stub_player_response({resultSets: [{name: "OtherResultSet", headers: [], rowSet: []}]})

      assert_equal 0, LeagueHustleStats.player_stats.size

      stub_player_response({resultSets: [{name: "HustleStatsPlayer", headers: nil, rowSet: [["data"]]}]})

      assert_equal 0, LeagueHustleStats.player_stats.size

      stub_player_response({resultSets: [{name: "HustleStatsPlayer", headers: ["PLAYER_ID"], rowSet: nil}]})

      assert_equal 0, LeagueHustleStats.player_stats.size
    end

    def test_team_returns_empty_for_invalid_responses
      stub_team_response({resultSets: [{name: "OtherResultSet", headers: [], rowSet: []}]})

      assert_equal 0, LeagueHustleStats.team_stats.size

      stub_team_response({resultSets: [{name: "HustleStatsTeam", headers: nil, rowSet: [["data"]]}]})

      assert_equal 0, LeagueHustleStats.team_stats.size

      stub_team_response({resultSets: [{name: "HustleStatsTeam", headers: ["TEAM_ID"], rowSet: nil}]})

      assert_equal 0, LeagueHustleStats.team_stats.size
    end

    def test_result_set_constants
      assert_equal "PlayerHustleStats", LeagueHustleStats::PLAYER_HUSTLE_STATS
      assert_equal "TeamHustleStats", LeagueHustleStats::TEAM_HUSTLE_STATS
    end

    def test_season_type_constants
      assert_equal "Regular Season", LeagueHustleStats::REGULAR_SEASON
      assert_equal "Playoffs", LeagueHustleStats::PLAYOFFS
    end

    def test_per_mode_constants
      assert_equal "PerGame", LeagueHustleStats::PER_GAME
      assert_equal "Totals", LeagueHustleStats::TOTALS
    end

    private

    def player_stat
      stub_player_hustle_request
      LeagueHustleStats.player_stats.first
    end

    def team_stat
      stub_team_hustle_request
      LeagueHustleStats.team_stats.first
    end

    def nil_client
      mock = Minitest::Mock.new
      mock.expect :get, nil, [String]
      mock
    end

    def stub_player_response(body)
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: body.to_json)
    end

    def stub_team_response(body)
      stub_request(:get, /leaguehustlestatsteam/).to_return(body: body.to_json)
    end

    def stub_player_hustle_request
      stub_player_response(player_hustle_response)
    end

    def stub_team_hustle_request
      stub_team_response(team_hustle_response)
    end

    def player_hustle_response
      {resultSets: [{
        name: "HustleStatsPlayer",
        headers: %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE G W L MIN CONTESTED_SHOTS
          CONTESTED_SHOTS_2PT CONTESTED_SHOTS_3PT DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS
          SCREEN_AST_PTS LOOSE_BALLS_RECOVERED OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED
          BOX_OUTS OFF_BOX_OUTS DEF_BOX_OUTS],
        rowSet: [[201_939, "Stephen Curry", Team::GSW, "GSW", 36, 82, 50, 32, 34.5,
          5.5, 3.5, 2.0, 2.5, 0.2, 3.0, 7.5, 1.0, 0.5, 0.5, 2.0, 0.5, 1.5]]
      }]}
    end

    def team_hustle_response
      {resultSets: [{
        name: "HustleStatsTeam",
        headers: %w[TEAM_ID TEAM_NAME G W L MIN CONTESTED_SHOTS CONTESTED_SHOTS_2PT
          CONTESTED_SHOTS_3PT DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS SCREEN_AST_PTS
          LOOSE_BALLS_RECOVERED OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED BOX_OUTS
          OFF_BOX_OUTS DEF_BOX_OUTS],
        rowSet: [[Team::GSW, "Warriors", 82, 50, 32, 48.0,
          55.0, 35.0, 20.0, 15.0, 1.5, 18.0, 45.0, 6.5, 3.0, 3.5, 12.0, 3.5, 8.5]]
      }]}
    end
  end
  # rubocop:enable Metrics/ClassLength
end
