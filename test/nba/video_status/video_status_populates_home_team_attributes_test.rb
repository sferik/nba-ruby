require_relative "../../test_helper"
require_relative "video_status_populates_helper"

module NBA
  class VideoStatusPopulatesHomeTeamAttributesTest < Minitest::Test
    include VideoStatusPopulatesHelper

    cover VideoStatus

    def test_populates_home_team_id
      stub_video_status_request

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal Team::LAL, entry.home_team_id
    end

    def test_populates_home_team_city
      stub_video_status_request

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal "Los Angeles", entry.home_team_city
    end

    def test_populates_home_team_name
      stub_video_status_request

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal "Lakers", entry.home_team_name
    end

    def test_populates_home_team_abbreviation
      stub_video_status_request

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal "LAL", entry.home_team_abbreviation
    end
  end
end
