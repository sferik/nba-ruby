require_relative "../../test_helper"

module NBA
  class LeaguePlayerOnDetailsShootingInfoTest < Minitest::Test
    cover LeaguePlayerOnDetails

    def test_fetches_fgm
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 9.8, stat.fgm
    end

    def test_fetches_fga
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 20.2, stat.fga
    end

    def test_fetches_fg_pct
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 0.485, stat.fg_pct
    end

    def test_fetches_fg3m
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 4.8, stat.fg3m
    end

    def test_fetches_fg3a
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 11.7, stat.fg3a
    end

    def test_fetches_fg3_pct
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 0.411, stat.fg3_pct
    end

    def test_fetches_ftm
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 4.2, stat.ftm
    end

    def test_fetches_fta
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 4.6, stat.fta
    end

    def test_fetches_ft_pct
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 0.913, stat.ft_pct
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
