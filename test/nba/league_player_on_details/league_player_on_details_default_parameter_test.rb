require_relative "../../test_helper"

module NBA
  class LeaguePlayerOnDetailsDefaultParameterTest < Minitest::Test
    cover LeaguePlayerOnDetails

    def test_uses_default_season_when_not_provided
      stub_stats_request
      LeaguePlayerOnDetails.all(team: Team::GSW)
      expected_season = Utils.format_season(Utils.current_season)

      assert_requested :get, /Season=#{expected_season}/
    end

    def test_uses_default_season_type_when_not_provided
      stub_stats_request

      LeaguePlayerOnDetails.all(team: Team::GSW)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_uses_default_per_mode_when_not_provided
      stub_stats_request

      LeaguePlayerOnDetails.all(team: Team::GSW)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_uses_default_measure_type_when_not_provided
      stub_stats_request

      LeaguePlayerOnDetails.all(team: Team::GSW)

      assert_requested :get, /MeasureType=Base/
    end

    def test_includes_league_id_in_path
      stub_stats_request

      LeaguePlayerOnDetails.all(team: Team::GSW)

      assert_requested :get, /LeagueID=00/
    end

    def test_includes_pace_adjust_in_path
      stub_stats_request

      LeaguePlayerOnDetails.all(team: Team::GSW)

      assert_requested :get, /PaceAdjust=N/
    end

    def test_includes_plus_minus_in_path
      stub_stats_request

      LeaguePlayerOnDetails.all(team: Team::GSW)

      assert_requested :get, /PlusMinus=N/
    end

    def test_includes_rank_in_path
      stub_stats_request

      LeaguePlayerOnDetails.all(team: Team::GSW)

      assert_requested :get, /Rank=N/
    end

    def test_includes_last_n_games_in_path
      stub_stats_request

      LeaguePlayerOnDetails.all(team: Team::GSW)

      assert_requested :get, /LastNGames=0/
    end

    def test_includes_month_in_path
      stub_stats_request

      LeaguePlayerOnDetails.all(team: Team::GSW)

      assert_requested :get, /Month=0/
    end

    def test_includes_opponent_team_id_in_path
      stub_stats_request

      LeaguePlayerOnDetails.all(team: Team::GSW)

      assert_requested :get, /OpponentTeamID=0/
    end

    def test_includes_period_in_path
      stub_stats_request

      LeaguePlayerOnDetails.all(team: Team::GSW)

      assert_requested :get, /Period=0/
    end

    private

    def stub_stats_request
      stub_request(:get, /leagueplayerondetails/).to_return(body: stats_response.to_json)
    end

    def stats_response
      {resultSets: [{name: "PlayersOnCourtLeaguePlayerDetails", headers: stats_headers, rowSet: [stats_row]}]}
    end

    def stats_headers
      %w[GROUP_SET TEAM_ID TEAM_ABBREVIATION TEAM_NAME VS_PLAYER_ID VS_PLAYER_NAME COURT_STATUS
        GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS]
    end

    def stats_row
      ["Overall", Team::GSW, "GSW", "Warriors", 201_939, "Stephen Curry", "On",
        74, 46, 28, 0.622, 32.5, 9.8, 20.2, 0.485, 4.8, 11.7, 0.411, 4.2, 4.6, 0.913,
        0.7, 5.4, 6.1, 6.3, 3.2, 0.9, 0.4, 0.3, 2.0, 3.8, 28.6, 7.4]
    end
  end
end
