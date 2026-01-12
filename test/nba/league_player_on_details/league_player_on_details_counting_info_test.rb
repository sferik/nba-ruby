require_relative "../../test_helper"

module NBA
  class LeaguePlayerOnDetailsCountingInfoTest < Minitest::Test
    cover LeaguePlayerOnDetails

    def test_fetches_oreb
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 0.7, stat.oreb
    end

    def test_fetches_dreb
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 5.4, stat.dreb
    end

    def test_fetches_reb
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 6.1, stat.reb
    end

    def test_fetches_ast
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 6.3, stat.ast
    end

    def test_fetches_tov
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 3.2, stat.tov
    end

    def test_fetches_stl
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 0.9, stat.stl
    end

    def test_fetches_blk
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 0.4, stat.blk
    end

    def test_fetches_blka
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 0.3, stat.blka
    end

    def test_fetches_pf
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 2.0, stat.pf
    end

    def test_fetches_pfd
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 3.8, stat.pfd
    end

    def test_fetches_pts
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 28.6, stat.pts
    end

    def test_fetches_plus_minus
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 7.4, stat.plus_minus
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
      ["Overall", Team::GSW, "GSW", "Golden State Warriors", 201_939, "Stephen Curry", "On",
        74, 46, 28, 0.622, 32.5, 9.8, 20.2, 0.485, 4.8, 11.7, 0.411, 4.2, 4.6, 0.913,
        0.7, 5.4, 6.1, 6.3, 3.2, 0.9, 0.4, 0.3, 2.0, 3.8, 28.6, 7.4]
    end
  end
end
