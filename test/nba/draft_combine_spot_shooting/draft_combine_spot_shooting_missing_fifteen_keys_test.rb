require_relative "draft_combine_spot_shooting_missing_keys_helper"

module NBA
  class DraftCombineSpotShootingMissingFifteenKeysTest < Minitest::Test
    include DraftCombineSpotShootingMissingKeysHelper

    cover DraftCombineSpotShooting

    def test_handles_missing_fifteen_corner_left_made_key
      stub_with_headers_except("FIFTEEN_CORNER_LEFT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_left_made
    end

    def test_handles_missing_fifteen_corner_left_attempt_key
      stub_with_headers_except("FIFTEEN_CORNER_LEFT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_left_attempt
    end

    def test_handles_missing_fifteen_corner_left_pct_key
      stub_with_headers_except("FIFTEEN_CORNER_LEFT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_left_pct
    end

    def test_handles_missing_fifteen_break_left_made_key
      stub_with_headers_except("FIFTEEN_BREAK_LEFT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_left_made
    end

    def test_handles_missing_fifteen_break_left_attempt_key
      stub_with_headers_except("FIFTEEN_BREAK_LEFT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_left_attempt
    end

    def test_handles_missing_fifteen_break_left_pct_key
      stub_with_headers_except("FIFTEEN_BREAK_LEFT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_left_pct
    end

    def test_handles_missing_fifteen_top_key_made_key
      stub_with_headers_except("FIFTEEN_TOP_KEY_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_top_key_made
    end

    def test_handles_missing_fifteen_top_key_attempt_key
      stub_with_headers_except("FIFTEEN_TOP_KEY_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_top_key_attempt
    end

    def test_handles_missing_fifteen_top_key_pct_key
      stub_with_headers_except("FIFTEEN_TOP_KEY_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_top_key_pct
    end

    def test_handles_missing_fifteen_break_right_made_key
      stub_with_headers_except("FIFTEEN_BREAK_RIGHT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_right_made
    end

    def test_handles_missing_fifteen_break_right_attempt_key
      stub_with_headers_except("FIFTEEN_BREAK_RIGHT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_right_attempt
    end

    def test_handles_missing_fifteen_break_right_pct_key
      stub_with_headers_except("FIFTEEN_BREAK_RIGHT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_right_pct
    end

    def test_handles_missing_fifteen_corner_right_made_key
      stub_with_headers_except("FIFTEEN_CORNER_RIGHT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_right_made
    end

    def test_handles_missing_fifteen_corner_right_attempt_key
      stub_with_headers_except("FIFTEEN_CORNER_RIGHT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_right_attempt
    end

    def test_handles_missing_fifteen_corner_right_pct_key
      stub_with_headers_except("FIFTEEN_CORNER_RIGHT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_right_pct
    end
  end
end
