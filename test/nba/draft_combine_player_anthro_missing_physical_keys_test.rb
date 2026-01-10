require_relative "draft_combine_player_anthro_missing_keys_helper"

module NBA
  class DraftCombinePlayerAnthroMissingPhysicalKeysTest < Minitest::Test
    include DraftCombinePlayerAnthroMissingKeysHelper

    cover DraftCombinePlayerAnthro

    def test_handles_missing_weight_key
      stub_with_headers_except("WEIGHT")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.weight
    end

    def test_handles_missing_wingspan_key
      stub_with_headers_except("WINGSPAN")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.wingspan
    end

    def test_handles_missing_wingspan_ft_in_key
      stub_with_headers_except("WINGSPAN_FT_IN")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.wingspan_ft_in
    end

    def test_handles_missing_standing_reach_key
      stub_with_headers_except("STANDING_REACH")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.standing_reach
    end

    def test_handles_missing_standing_reach_ft_in_key
      stub_with_headers_except("STANDING_REACH_FT_IN")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.standing_reach_ft_in
    end

    def test_handles_missing_body_fat_pct_key
      stub_with_headers_except("BODY_FAT_PCT")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.body_fat_pct
    end

    def test_handles_missing_hand_length_key
      stub_with_headers_except("HAND_LENGTH")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.hand_length
    end

    def test_handles_missing_hand_width_key
      stub_with_headers_except("HAND_WIDTH")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.hand_width
    end
  end
end
