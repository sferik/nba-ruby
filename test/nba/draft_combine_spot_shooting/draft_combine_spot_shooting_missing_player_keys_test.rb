require_relative "draft_combine_spot_shooting_missing_keys_helper"

module NBA
  class DraftCombineSpotShootingMissingPlayerKeysTest < Minitest::Test
    include DraftCombineSpotShootingMissingKeysHelper

    cover DraftCombineSpotShooting

    def test_handles_missing_player_id_key
      stub_with_headers_except("PLAYER_ID")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.player_id
    end

    def test_handles_missing_player_name_key
      stub_with_headers_except("PLAYER_NAME")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.player_name
    end

    def test_handles_missing_first_name_key
      stub_with_headers_except("FIRST_NAME")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.first_name
    end

    def test_handles_missing_last_name_key
      stub_with_headers_except("LAST_NAME")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.last_name
    end

    def test_handles_missing_position_key
      stub_with_headers_except("POSITION")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.position
    end
  end
end
