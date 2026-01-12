require_relative "draft_combine_non_stationary_shooting_missing_keys_helper"

module NBA
  class DraftCombineNonStationaryShootingMissingOnMoveCollegeKeysTest < Minitest::Test
    include DraftCombineNonStationaryShootingMissingKeysHelper

    cover DraftCombineNonStationaryShooting

    def test_handles_missing_on_move_college_break_left_made_key
      stub_with_headers_except("ON_MOVE_COLLEGE_BREAK_LEFT_MADE")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_left_made
    end

    def test_handles_missing_on_move_college_break_left_attempt_key
      stub_with_headers_except("ON_MOVE_COLLEGE_BREAK_LEFT_ATTEMPT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_left_attempt
    end

    def test_handles_missing_on_move_college_break_left_pct_key
      stub_with_headers_except("ON_MOVE_COLLEGE_BREAK_LEFT_PCT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_left_pct
    end

    def test_handles_missing_on_move_college_top_key_made_key
      stub_with_headers_except("ON_MOVE_COLLEGE_TOP_KEY_MADE")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_top_key_made
    end

    def test_handles_missing_on_move_college_top_key_attempt_key
      stub_with_headers_except("ON_MOVE_COLLEGE_TOP_KEY_ATTEMPT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_top_key_attempt
    end

    def test_handles_missing_on_move_college_top_key_pct_key
      stub_with_headers_except("ON_MOVE_COLLEGE_TOP_KEY_PCT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_top_key_pct
    end

    def test_handles_missing_on_move_college_break_right_made_key
      stub_with_headers_except("ON_MOVE_COLLEGE_BREAK_RIGHT_MADE")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_right_made
    end

    def test_handles_missing_on_move_college_break_right_attempt_key
      stub_with_headers_except("ON_MOVE_COLLEGE_BREAK_RIGHT_ATTEMPT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_right_attempt
    end

    def test_handles_missing_on_move_college_break_right_pct_key
      stub_with_headers_except("ON_MOVE_COLLEGE_BREAK_RIGHT_PCT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_right_pct
    end
  end
end
