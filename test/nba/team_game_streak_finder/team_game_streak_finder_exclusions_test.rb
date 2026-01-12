require_relative "../../test_helper"

module NBA
  class TeamGameStreakFinderExclusionsTest < Minitest::Test
    cover TeamGameStreakFinder

    def test_find_without_season_excludes_season_param
      stub = stub_request(:get, /teamgamestreakfinder/)
        .with { |req| !req.uri.to_s.include?("SeasonNullable") }
        .to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find

      assert_requested stub
    end

    def test_find_without_team_excludes_team_id_param
      stub = stub_request(:get, /teamgamestreakfinder/)
        .with { |req| !req.uri.to_s.include?("TeamIDNullable") }
        .to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find

      assert_requested stub
    end

    def test_find_without_active_only_excludes_active_streaks_param
      stub = stub_request(:get, /teamgamestreakfinder/)
        .with { |req| !req.uri.to_s.include?("ActiveStreaksOnly") }
        .to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find

      assert_requested stub
    end

    def test_find_without_gt_pts_excludes_gt_pts_param
      stub = stub_request(:get, /teamgamestreakfinder/)
        .with { |req| !req.uri.to_s.include?("GtPTS") }
        .to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find

      assert_requested stub
    end

    def test_find_without_gt_reb_excludes_gt_reb_param
      stub = stub_request(:get, /teamgamestreakfinder/)
        .with { |req| !req.uri.to_s.include?("GtREB") }
        .to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find

      assert_requested stub
    end

    def test_find_without_gt_ast_excludes_gt_ast_param
      stub = stub_request(:get, /teamgamestreakfinder/)
        .with { |req| !req.uri.to_s.include?("GtAST") }
        .to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find

      assert_requested stub
    end

    def test_find_without_gt_stl_excludes_gt_stl_param
      stub = stub_request(:get, /teamgamestreakfinder/)
        .with { |req| !req.uri.to_s.include?("GtSTL") }
        .to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find

      assert_requested stub
    end

    def test_find_without_gt_blk_excludes_gt_blk_param
      stub = stub_request(:get, /teamgamestreakfinder/)
        .with { |req| !req.uri.to_s.include?("GtBLK") }
        .to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find

      assert_requested stub
    end

    def test_find_without_gt_fg3m_excludes_gt_fg3m_param
      stub = stub_request(:get, /teamgamestreakfinder/)
        .with { |req| !req.uri.to_s.include?("GtFG3M") }
        .to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find

      assert_requested stub
    end

    def test_find_without_w_streak_excludes_w_streak_param
      stub = stub_request(:get, /teamgamestreakfinder/)
        .with { |req| !req.uri.to_s.include?("WStreak") }
        .to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find

      assert_requested stub
    end

    def test_find_without_l_streak_excludes_l_streak_param
      stub = stub_request(:get, /teamgamestreakfinder/)
        .with { |req| !req.uri.to_s.include?("LStreak") }
        .to_return(body: streak_response.to_json)

      TeamGameStreakFinder.find

      assert_requested stub
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
