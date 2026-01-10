require_relative "draft_combine_player_anthro_missing_keys_helper"

module NBA
  class DraftCombinePlayerAnthroMissingHeightKeysTest < Minitest::Test
    include DraftCombinePlayerAnthroMissingKeysHelper

    cover DraftCombinePlayerAnthro

    def test_handles_missing_height_wo_shoes_key
      stub_with_headers_except("HEIGHT_WO_SHOES")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.height_wo_shoes
    end

    def test_handles_missing_height_wo_shoes_ft_in_key
      stub_with_headers_except("HEIGHT_WO_SHOES_FT_IN")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.height_wo_shoes_ft_in
    end

    def test_handles_missing_height_w_shoes_key
      stub_with_headers_except("HEIGHT_W_SHOES")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.height_w_shoes
    end

    def test_handles_missing_height_w_shoes_ft_in_key
      stub_with_headers_except("HEIGHT_W_SHOES_FT_IN")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.height_w_shoes_ft_in
    end
  end
end
