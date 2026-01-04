require_relative "../test_helper"

module NBA
  class TeamDashboardTest < Minitest::Test
    cover TeamDashboard

    def test_general_splits_parses_identity_attributes
      stat = general_splits_stat

      assert_equal "OverallTeamDashboard", stat.group_set
      assert_equal "Overall", stat.group_value
      assert_equal Team::GSW, stat.team_id
      assert_equal 82, stat.gp
      assert_in_delta 48.0, stat.min
    end

    def test_general_splits_parses_record_attributes
      stat = general_splits_stat

      assert_equal 50, stat.w
      assert_equal 32, stat.l
      assert_in_delta 0.610, stat.w_pct
    end

    def test_general_splits_parses_field_goal_attributes
      stat = general_splits_stat

      assert_in_delta 42.5, stat.fgm
      assert_in_delta 88.2, stat.fga
      assert_in_delta 0.482, stat.fg_pct
    end

    def test_general_splits_parses_three_point_attributes
      stat = general_splits_stat

      assert_in_delta 14.5, stat.fg3m
      assert_in_delta 38.8, stat.fg3a
      assert_in_delta 0.374, stat.fg3_pct
    end

    def test_general_splits_parses_free_throw_attributes
      stat = general_splits_stat

      assert_in_delta 18.0, stat.ftm
      assert_in_delta 22.5, stat.fta
      assert_in_delta 0.800, stat.ft_pct
    end

    def test_general_splits_parses_rebound_attributes
      stat = general_splits_stat

      assert_in_delta 10.5, stat.oreb
      assert_in_delta 35.5, stat.dreb
      assert_in_delta 46.0, stat.reb
    end

    def test_general_splits_parses_playmaking_attributes
      stat = general_splits_stat

      assert_in_delta 28.5, stat.ast
      assert_in_delta 13.5, stat.tov
    end

    def test_general_splits_parses_defensive_attributes
      stat = general_splits_stat

      assert_in_delta 8.0, stat.stl
      assert_in_delta 5.5, stat.blk
      assert_in_delta 4.0, stat.blka
    end

    def test_general_splits_parses_foul_attributes
      stat = general_splits_stat

      assert_in_delta 19.0, stat.pf
      assert_in_delta 21.0, stat.pfd
    end

    def test_general_splits_parses_scoring_attributes
      stat = general_splits_stat

      assert_in_delta 117.5, stat.pts
      assert_in_delta 5.5, stat.plus_minus
    end

    private

    def general_splits_stat
      stub_dashboard_request("teamdashboardbygeneralsplits")
      TeamDashboard.general_splits(team: Team::GSW).first
    end

    def stub_dashboard_request(endpoint)
      response = {
        resultSets: [{
          name: "OverallTeamDashboard",
          headers: %w[GROUP_VALUE GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
            FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS],
          rowSet: [["Overall", 82, 50, 32, 0.610, 48.0, 42.5, 88.2, 0.482, 14.5, 38.8, 0.374,
            18.0, 22.5, 0.800, 10.5, 35.5, 46.0, 28.5, 13.5, 8.0, 5.5, 4.0, 19.0, 21.0, 117.5, 5.5]]
        }]
      }
      stub_request(:get, /#{endpoint}.*TeamID=#{Team::GSW}/).to_return(body: response.to_json)
    end
  end
end
