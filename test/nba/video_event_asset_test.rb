require_relative "../test_helper"

module NBA
  class VideoEventAssetTest < Minitest::Test
    cover VideoEventAsset

    def test_equality_based_on_uuid
      asset1 = VideoEventAsset.new(uuid: "abc123")
      asset2 = VideoEventAsset.new(uuid: "abc123")

      assert_equal asset1, asset2
    end

    def test_inequality_when_uuid_differs
      asset1 = VideoEventAsset.new(uuid: "abc123")
      asset2 = VideoEventAsset.new(uuid: "def456")

      refute_equal asset1, asset2
    end

    def test_game_id_attribute
      asset = VideoEventAsset.new(game_id: "0022300001")

      assert_equal "0022300001", asset.game_id
    end

    def test_game_event_id_attribute
      asset = VideoEventAsset.new(game_event_id: 42)

      assert_equal 42, asset.game_event_id
    end

    def test_video_available_attribute
      asset = VideoEventAsset.new(video_available: 1)

      assert_equal 1, asset.video_available
    end

    def test_video_url_attribute
      asset = VideoEventAsset.new(video_url: "https://videos.nba.com/example")

      assert_equal "https://videos.nba.com/example", asset.video_url
    end

    def test_video_description_attribute
      asset = VideoEventAsset.new(video_description: "Curry 3PT shot")

      assert_equal "Curry 3PT shot", asset.video_description
    end

    def test_uuid_attribute
      asset = VideoEventAsset.new(uuid: "abc123")

      assert_equal "abc123", asset.uuid
    end

    def test_file_size_attribute
      asset = VideoEventAsset.new(file_size: 1_024_000)

      assert_equal 1_024_000, asset.file_size
    end

    def test_aspect_ratio_attribute
      asset = VideoEventAsset.new(aspect_ratio: "16:9")

      assert_equal "16:9", asset.aspect_ratio
    end

    def test_video_duration_attribute
      asset = VideoEventAsset.new(video_duration: 15)

      assert_equal 15, asset.video_duration
    end

    def test_video_available_returns_true_when_flag_is_one
      asset = VideoEventAsset.new(video_available: 1)

      assert_predicate asset, :video_available?
    end

    def test_video_available_returns_false_when_flag_is_zero
      asset = VideoEventAsset.new(video_available: 0)

      refute_predicate asset, :video_available?
    end

    def test_video_available_returns_false_when_flag_is_nil
      asset = VideoEventAsset.new(video_available: nil)

      refute_predicate asset, :video_available?
    end
  end
end
