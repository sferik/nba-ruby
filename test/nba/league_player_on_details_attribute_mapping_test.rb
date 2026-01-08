require_relative "../test_helper"

module NBA
  class LeaguePlayerOnDetailsAttributeMappingTest < Minitest::Test
    cover LeaguePlayerOnDetails

    def test_maps_group_set_and_team_id
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_equal "Overall", stat.group_set
      assert_equal Team::GSW, stat.team_id
    end

    def test_maps_team_abbreviation_and_name
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Warriors", stat.team_name
    end

    def test_maps_player_identity
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_equal 201_939, stat.vs_player_id
      assert_equal "Stephen Curry", stat.vs_player_name
      assert_equal "On", stat.court_status
    end

    def test_maps_record_attributes
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_equal 74, stat.gp
      assert_equal 46, stat.w
      assert_equal 28, stat.l
      assert_in_delta 0.622, stat.w_pct
      assert_in_delta 32.5, stat.min
    end

    def test_maps_field_goal_attributes
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 9.8, stat.fgm
      assert_in_delta 20.2, stat.fga
      assert_in_delta 0.485, stat.fg_pct
    end

    def test_maps_three_point_attributes
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 4.8, stat.fg3m
      assert_in_delta 11.7, stat.fg3a
      assert_in_delta 0.411, stat.fg3_pct
    end

    def test_maps_free_throw_attributes
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 4.2, stat.ftm
      assert_in_delta 4.6, stat.fta
      assert_in_delta 0.913, stat.ft_pct
    end

    def test_maps_rebound_attributes
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 0.7, stat.oreb
      assert_in_delta 5.4, stat.dreb
      assert_in_delta 6.1, stat.reb
    end

    def test_maps_other_counting_attributes
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 6.3, stat.ast
      assert_in_delta 3.2, stat.tov
      assert_in_delta 0.9, stat.stl
      assert_in_delta 0.4, stat.blk
      assert_in_delta 0.3, stat.blka
    end

    def test_maps_foul_and_score_attributes
      stub_stats_request
      stat = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).first

      assert_in_delta 2.0, stat.pf
      assert_in_delta 3.8, stat.pfd
      assert_in_delta 28.6, stat.pts
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
      ["Overall", Team::GSW, "GSW", "Warriors", 201_939, "Stephen Curry", "On",
        74, 46, 28, 0.622, 32.5, 9.8, 20.2, 0.485, 4.8, 11.7, 0.411, 4.2, 4.6, 0.913,
        0.7, 5.4, 6.1, 6.3, 3.2, 0.9, 0.4, 0.3, 2.0, 3.8, 28.6, 7.4]
    end
  end
end
