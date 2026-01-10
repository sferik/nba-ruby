require_relative "../test_helper"
require_relative "video_status_populates_helper"

module NBA
  class VideoStatusPopulatesAvailabilityAttributesTest < Minitest::Test
    include VideoStatusPopulatesHelper

    cover VideoStatus

    def test_populates_is_available
      stub_video_status_request

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal 1, entry.is_available
    end

    def test_populates_pt_xyz_available
      stub_video_status_request

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal 1, entry.pt_xyz_available
    end
  end
end
