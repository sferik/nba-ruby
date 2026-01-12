require_relative "../../test_helper"

module NBA
  class PlayerGameStreakFinderParamsTest < Minitest::Test
    cover PlayerGameStreakFinder

    def test_includes_league_id_parameter
      stub_finder_request

      PlayerGameStreakFinder.find

      assert_requested :get, /LeagueID=00/
    end

    def test_includes_min_games_parameter
      stub_finder_request

      PlayerGameStreakFinder.find

      assert_requested :get, /MinGames=1/
    end

    def test_find_with_gt_stl_filter
      stub_finder_request

      PlayerGameStreakFinder.find(gt_stl: 3)

      assert_requested :get, /GtSTL=3/
    end

    def test_find_with_gt_blk_filter
      stub_finder_request

      PlayerGameStreakFinder.find(gt_blk: 4)

      assert_requested :get, /GtBLK=4/
    end

    def test_find_with_gt_fg3m_filter
      stub_finder_request

      PlayerGameStreakFinder.find(gt_fg3m: 5)

      assert_requested :get, /GtFG3M=5/
    end

    def test_find_with_multiple_filters
      stub_finder_request

      PlayerGameStreakFinder.find(gt_pts: 20, gt_reb: 10)

      assert_requested :get, /GtPTS=20/
      assert_requested :get, /GtREB=10/
    end

    def test_omits_nil_filters
      stub_finder_request

      PlayerGameStreakFinder.find(gt_pts: 25)

      assert_requested :get, /GtPTS=25/
      assert_not_requested :get, /GtREB/
    end

    def test_omits_season_when_nil
      stub_finder_request

      PlayerGameStreakFinder.find

      assert_not_requested :get, /SeasonNullable/
    end

    def test_omits_player_when_nil
      stub_finder_request

      PlayerGameStreakFinder.find

      assert_not_requested :get, /PlayerIDNullable/
    end

    def test_omits_team_when_nil
      stub_finder_request

      PlayerGameStreakFinder.find

      assert_not_requested :get, /TeamIDNullable/
    end

    def test_omits_active_streaks_when_nil
      stub_finder_request

      PlayerGameStreakFinder.find

      assert_not_requested :get, /ActiveStreaksOnly/
    end

    def test_find_sets_result_set_name
      stub_finder_request

      PlayerGameStreakFinder.find

      assert_equal "PlayerGameStreakFinderResults", PlayerGameStreakFinder::RESULT_SET_NAME
    end

    def test_find_with_player_object
      player = Player.new(id: 201_939)
      stub_finder_request

      PlayerGameStreakFinder.find(player: player)

      assert_requested :get, /PlayerIDNullable=201939/
    end

    def test_find_with_team_object
      team = Team.new(id: 1_610_612_744)
      stub_finder_request

      PlayerGameStreakFinder.find(team: team)

      assert_requested :get, /TeamIDNullable=1610612744/
    end

    private

    def stub_finder_request
      stub_request(:get, /playergamestreakfinder/).to_return(body: finder_response.to_json)
    end

    def finder_response
      {resultSets: [{name: "PlayerGameStreakFinderResults", headers: [], rowSet: []}]}
    end
  end
end
