require_relative "../../test_helper"

module NBA
  class TeamGameStreakFinderParamsTest < Minitest::Test
    cover TeamGameStreakFinder

    def test_find_includes_league_id_parameter
      stub_request(:get, /LeagueID=00/).to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find

      assert_requested :get, /LeagueID=00/
    end

    def test_find_includes_min_games_parameter
      stub_request(:get, /MinGames=1/).to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find

      assert_requested :get, /MinGames=1/
    end

    def test_find_includes_season_parameter
      stub_request(:get, /SeasonNullable=2024-25/).to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find(season: "2024-25")

      assert_requested :get, /SeasonNullable=2024-25/
    end

    def test_find_includes_team_id_parameter
      stub_request(:get, /TeamIDNullable=1610612744/).to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find(team: 1_610_612_744)

      assert_requested :get, /TeamIDNullable=1610612744/
    end

    def test_find_extracts_id_from_team_object
      stub_request(:get, /TeamIDNullable=1610612744/).to_return(body: streak_response.to_json)
      team = Team.new(id: 1_610_612_744)

      TeamGameStreakFinder.find(team: team)

      assert_requested :get, /TeamIDNullable=1610612744/
    end

    def test_find_includes_active_streaks_only_parameter
      stub_request(:get, /ActiveStreaksOnly=Y/).to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find(active_streaks_only: true)

      assert_requested :get, /ActiveStreaksOnly=Y/
    end

    def test_find_includes_gt_pts_parameter
      stub_request(:get, /GtPTS=100/).to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find(gt_pts: 100)

      assert_requested :get, /GtPTS=100/
    end

    def test_find_includes_gt_reb_parameter
      stub_request(:get, /GtREB=50/).to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find(gt_reb: 50)

      assert_requested :get, /GtREB=50/
    end

    def test_find_includes_gt_ast_parameter
      stub_request(:get, /GtAST=25/).to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find(gt_ast: 25)

      assert_requested :get, /GtAST=25/
    end

    def test_find_includes_gt_stl_parameter
      stub_request(:get, /GtSTL=10/).to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find(gt_stl: 10)

      assert_requested :get, /GtSTL=10/
    end

    def test_find_includes_gt_blk_parameter
      stub_request(:get, /GtBLK=5/).to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find(gt_blk: 5)

      assert_requested :get, /GtBLK=5/
    end

    def test_find_includes_gt_fg3m_parameter
      stub_request(:get, /GtFG3M=15/).to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find(gt_fg3m: 15)

      assert_requested :get, /GtFG3M=15/
    end

    def test_find_includes_w_streak_parameter
      stub_request(:get, /WStreak=5/).to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find(w_streak: 5)

      assert_requested :get, /WStreak=5/
    end

    def test_find_includes_l_streak_parameter
      stub_request(:get, /LStreak=3/).to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find(l_streak: 3)

      assert_requested :get, /LStreak=3/
    end

    private

    def streak_response
      {resultSets: [{name: "TeamGameStreakFinderParametersResults", headers: streak_headers, rowSet: [streak_row]}]}
    end

    def streak_headers
      %w[TEAM_NAME TEAM_ID ABBREVIATION GAMESTREAK STARTDATE ENDDATE ACTIVESTREAK NUMSEASONS
        LASTSEASON FIRSTSEASON]
    end

    def streak_row
      ["Golden State Warriors", 1_610_612_744, "GSW", 10, "2024-10-22", "2024-11-15", 1, 1, "2024-25", "2024-25"]
    end
  end
end
