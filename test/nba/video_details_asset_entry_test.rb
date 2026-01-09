require_relative "../test_helper"

module NBA
  class VideoDetailsAssetEntryModelTest < Minitest::Test
    cover VideoDetailsAssetEntry

    def test_objects_with_same_uuid_are_equal
      entry0 = VideoDetailsAssetEntry.new(uuid: "abc123")
      entry1 = VideoDetailsAssetEntry.new(uuid: "abc123")

      assert_equal entry0, entry1
    end

    def test_objects_with_different_uuid_are_not_equal
      entry0 = VideoDetailsAssetEntry.new(uuid: "abc123")
      entry1 = VideoDetailsAssetEntry.new(uuid: "def456")

      refute_equal entry0, entry1
    end

    def test_available_returns_true_when_video_available_is_one
      entry = VideoDetailsAssetEntry.new(video_available: 1)

      assert_predicate entry, :available?
    end

    def test_available_returns_false_when_video_available_is_zero
      entry = VideoDetailsAssetEntry.new(video_available: 0)

      refute_predicate entry, :available?
    end

    def test_available_uses_value_equality
      entry = VideoDetailsAssetEntry.new(video_available: 1.0)

      assert_predicate entry, :available?
    end
  end
end
