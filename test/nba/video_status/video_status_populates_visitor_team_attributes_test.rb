require_relative "../../test_helper"
require_relative "video_status_populates_helper"

module NBA
  class VideoStatusPopulatesVisitorTeamAttributesTest < Minitest::Test
    include VideoStatusPopulatesHelper

    cover VideoStatus

    def test_populates_visitor_team_id
      stub_video_status_request

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal Team::GSW, entry.visitor_team_id
    end

    def test_populates_visitor_team_city
      stub_video_status_request

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal "Golden State", entry.visitor_team_city
    end

    def test_populates_visitor_team_name
      stub_video_status_request

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal "Warriors", entry.visitor_team_name
    end

    def test_populates_visitor_team_abbreviation
      stub_video_status_request

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal "GSW", entry.visitor_team_abbreviation
    end
  end
end
