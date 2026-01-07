require_relative "../test_helper"

module NBA
  class PlayerGameStreakFinderTest < Minitest::Test
    cover PlayerGameStreakFinder

    def test_find_returns_collection
      stub_finder_request

      result = PlayerGameStreakFinder.find

      assert_instance_of Collection, result
    end

    def test_find_sends_correct_endpoint
      stub_finder_request

      PlayerGameStreakFinder.find

      assert_requested :get, /playergamestreakfinder/
    end

    def test_find_parses_streak_data
      stub_finder_request

      streak = PlayerGameStreakFinder.find.first

      assert_equal "Curry, Stephen", streak.player_name
      assert_equal 201_939, streak.player_id
      assert_equal 15, streak.game_streak
    end

    def test_find_with_season_parameter
      stub_finder_request

      PlayerGameStreakFinder.find(season: "2024-25")

      assert_requested :get, /SeasonNullable=2024-25/
    end

    def test_find_with_player_parameter
      stub_finder_request

      PlayerGameStreakFinder.find(player: 201_939)

      assert_requested :get, /PlayerIDNullable=201939/
    end

    def test_find_with_team_parameter
      stub_finder_request

      PlayerGameStreakFinder.find(team: 1_610_612_744)

      assert_requested :get, /TeamIDNullable=1610612744/
    end

    def test_find_with_active_streaks_only
      stub_finder_request

      PlayerGameStreakFinder.find(active_streaks_only: true)

      assert_requested :get, /ActiveStreaksOnly=Y/
    end

    def test_find_with_gt_pts_filter
      stub_finder_request

      PlayerGameStreakFinder.find(gt_pts: 25)

      assert_requested :get, /GtPTS=25/
    end

    def test_find_with_gt_reb_filter
      stub_finder_request

      PlayerGameStreakFinder.find(gt_reb: 10)

      assert_requested :get, /GtREB=10/
    end

    def test_find_with_gt_ast_filter
      stub_finder_request

      PlayerGameStreakFinder.find(gt_ast: 8)

      assert_requested :get, /GtAST=8/
    end

    def test_find_returns_empty_collection_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = PlayerGameStreakFinder.find(client: mock_client)

      assert_instance_of Collection, result
      assert_empty result
      mock_client.verify
    end

    def test_find_parses_correct_result_set
      stub_request(:get, /playergamestreakfinder/).to_return(body: multi_result_response.to_json)

      result = PlayerGameStreakFinder.find

      assert_equal 1, result.size
      assert_equal 201_939, result.first.player_id
    end

    private

    def multi_result_response
      {resultSets: [
        {name: "OtherResultSet", headers: %w[ID], rowSet: [[999]]},
        {name: "PlayerGameStreakFinderResults", headers: finder_headers, rowSet: [streak_row]}
      ]}
    end

    def stub_finder_request
      stub_request(:get, /playergamestreakfinder/).to_return(body: finder_response.to_json)
    end

    def finder_headers
      %w[PLAYER_NAME_LAST_FIRST PLAYER_ID GAMESTREAK STARTDATE ENDDATE ACTIVESTREAK NUMSEASONS LASTSEASON FIRSTSEASON]
    end

    def streak_row
      ["Curry, Stephen", 201_939, 15, "2024-12-01", "2024-12-20", 1, 1, "2024-25", "2024-25"]
    end

    def finder_response
      {resultSets: [{name: "PlayerGameStreakFinderResults", headers: finder_headers, rowSet: [streak_row]}]}
    end
  end
end
