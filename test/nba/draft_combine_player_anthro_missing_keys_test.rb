require_relative "../test_helper"

module NBA
  module DraftCombinePlayerAnthroMissingKeysHelper
    FULL_HEADERS = %w[
      TEMP_PLAYER_ID PLAYER_ID FIRST_NAME LAST_NAME PLAYER_NAME POSITION
      HEIGHT_WO_SHOES HEIGHT_WO_SHOES_FT_IN HEIGHT_W_SHOES HEIGHT_W_SHOES_FT_IN
      WEIGHT WINGSPAN WINGSPAN_FT_IN STANDING_REACH STANDING_REACH_FT_IN
      BODY_FAT_PCT HAND_LENGTH HAND_WIDTH
    ].freeze

    FULL_ROW = [
      123_456, 1_630_162, "Victor", "Wembanyama", "Victor Wembanyama", "C",
      85.5, "7' 1.5\"", 86.5, "7' 2.5\"",
      209.0, 96.0, "8' 0\"", 114.5, "9' 6.5\"",
      4.8, 10.25, 12.0
    ].freeze

    def headers_without(key)
      FULL_HEADERS.reject { |h| h.eql?(key) }
    end

    def row_without(key)
      headers_without(key).map { |h| FULL_ROW[FULL_HEADERS.index(h)] }
    end

    def stub_with_headers_except(key)
      response = {resultSets: [{name: "Results", headers: headers_without(key), rowSet: [row_without(key)]}]}
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)
    end
  end

  class DraftCombinePlayerAnthroMissingPlayerKeysTest < Minitest::Test
    include DraftCombinePlayerAnthroMissingKeysHelper

    cover DraftCombinePlayerAnthro

    def test_handles_missing_temp_player_id_key
      stub_with_headers_except("TEMP_PLAYER_ID")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.temp_player_id
    end

    def test_handles_missing_player_id_key
      stub_with_headers_except("PLAYER_ID")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.player_id
    end

    def test_handles_missing_first_name_key
      stub_with_headers_except("FIRST_NAME")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.first_name
    end

    def test_handles_missing_last_name_key
      stub_with_headers_except("LAST_NAME")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.last_name
    end

    def test_handles_missing_player_name_key
      stub_with_headers_except("PLAYER_NAME")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.player_name
    end

    def test_handles_missing_position_key
      stub_with_headers_except("POSITION")

      assert_nil DraftCombinePlayerAnthro.all(season: 2019).first.position
    end
  end

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
