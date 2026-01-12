require_relative "../../test_helper"
require_relative "video_status_populates_helper"

module NBA
  class VideoStatusPopulatesGameAttributesTest < Minitest::Test
    include VideoStatusPopulatesHelper

    cover VideoStatus

    def test_populates_game_id
      stub_video_status_request

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal "0022300001", entry.game_id
    end

    def test_populates_game_date
      stub_video_status_request

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal "2023-10-24", entry.game_date
    end

    def test_populates_game_status
      stub_video_status_request

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal 3, entry.game_status
    end

    def test_populates_game_status_text
      stub_video_status_request

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal "Final", entry.game_status_text
    end
  end
end
