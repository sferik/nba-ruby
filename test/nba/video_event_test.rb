require_relative "../test_helper"

module NBA
  class VideoEventModelTest < Minitest::Test
    cover VideoEvent

    def test_objects_with_same_uuid_are_equal
      event0 = VideoEvent.new(uuid: "abc123")
      event1 = VideoEvent.new(uuid: "abc123")

      assert_equal event0, event1
    end

    def test_objects_with_different_uuid_are_not_equal
      event0 = VideoEvent.new(uuid: "abc123")
      event1 = VideoEvent.new(uuid: "def456")

      refute_equal event0, event1
    end

    def test_video_available_returns_true_when_flag_is_one
      event = VideoEvent.new(video_available: 1)

      assert_predicate event, :video_available?
    end

    def test_video_available_returns_false_when_flag_is_zero
      event = VideoEvent.new(video_available: 0)

      refute_predicate event, :video_available?
    end

    def test_video_available_uses_value_equality
      event = VideoEvent.new(video_available: 1.0)

      assert_predicate event, :video_available?
    end
  end
end
