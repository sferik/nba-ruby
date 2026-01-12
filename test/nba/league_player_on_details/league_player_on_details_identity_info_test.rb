require_relative "../../test_helper"

module NBA
  class LeaguePlayerOnDetailsIdentityInfoTest < Minitest::Test
    cover LeaguePlayerOnDetails

    def test_fetches_group_set
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_equal "Overall", stat.group_set
    end

    def test_fetches_team_id
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_equal Team::GSW, stat.team_id
    end

    def test_fetches_team_abbreviation
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_equal "GSW", stat.team_abbreviation
    end

    def test_fetches_team_name
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_equal "Golden State Warriors", stat.team_name
    end

    def test_fetches_vs_player_id
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_equal 201_939, stat.vs_player_id
    end

    def test_fetches_vs_player_name
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_equal "Stephen Curry", stat.vs_player_name
    end

    def test_fetches_court_status
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_equal "On", stat.court_status
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
