require_relative "../test_helper"

module NBA
  class VideoStatusPopulatesGameAttributesTest < Minitest::Test
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

    private

    def stub_video_status_request
      stub_request(:get, /videostatus/).to_return(body: video_status_response.to_json)
    end

    def video_status_response
      {resultSets: [{name: "VideoStatus", headers: all_headers, rowSet: [all_row]}]}
    end

    def all_headers
      %w[GAME_ID GAME_DATE GAME_STATUS GAME_STATUS_TEXT
        VISITOR_TEAM_ID VISITOR_TEAM_CITY VISITOR_TEAM_NAME VISITOR_TEAM_ABBREVIATION
        HOME_TEAM_ID HOME_TEAM_CITY HOME_TEAM_NAME HOME_TEAM_ABBREVIATION
        IS_AVAILABLE PT_XYZ_AVAILABLE]
    end

    def all_row
      ["0022300001", "2023-10-24", 3, "Final",
        Team::GSW, "Golden State", "Warriors", "GSW",
        Team::LAL, "Los Angeles", "Lakers", "LAL",
        1, 1]
    end
  end

  class VideoStatusPopulatesVisitorTeamAttributesTest < Minitest::Test
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

    private

    def stub_video_status_request
      stub_request(:get, /videostatus/).to_return(body: video_status_response.to_json)
    end

    def video_status_response
      {resultSets: [{name: "VideoStatus", headers: all_headers, rowSet: [all_row]}]}
    end

    def all_headers
      %w[GAME_ID GAME_DATE GAME_STATUS GAME_STATUS_TEXT
        VISITOR_TEAM_ID VISITOR_TEAM_CITY VISITOR_TEAM_NAME VISITOR_TEAM_ABBREVIATION
        HOME_TEAM_ID HOME_TEAM_CITY HOME_TEAM_NAME HOME_TEAM_ABBREVIATION
        IS_AVAILABLE PT_XYZ_AVAILABLE]
    end

    def all_row
      ["0022300001", "2023-10-24", 3, "Final",
        Team::GSW, "Golden State", "Warriors", "GSW",
        Team::LAL, "Los Angeles", "Lakers", "LAL",
        1, 1]
    end
  end

  class VideoStatusPopulatesHomeTeamAttributesTest < Minitest::Test
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

    private

    def stub_video_status_request
      stub_request(:get, /videostatus/).to_return(body: video_status_response.to_json)
    end

    def video_status_response
      {resultSets: [{name: "VideoStatus", headers: all_headers, rowSet: [all_row]}]}
    end

    def all_headers
      %w[GAME_ID GAME_DATE GAME_STATUS GAME_STATUS_TEXT
        VISITOR_TEAM_ID VISITOR_TEAM_CITY VISITOR_TEAM_NAME VISITOR_TEAM_ABBREVIATION
        HOME_TEAM_ID HOME_TEAM_CITY HOME_TEAM_NAME HOME_TEAM_ABBREVIATION
        IS_AVAILABLE PT_XYZ_AVAILABLE]
    end

    def all_row
      ["0022300001", "2023-10-24", 3, "Final",
        Team::GSW, "Golden State", "Warriors", "GSW",
        Team::LAL, "Los Angeles", "Lakers", "LAL",
        1, 1]
    end
  end

  class VideoStatusPopulatesAvailabilityAttributesTest < Minitest::Test
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

    private

    def stub_video_status_request
      stub_request(:get, /videostatus/).to_return(body: video_status_response.to_json)
    end

    def video_status_response
      {resultSets: [{name: "VideoStatus", headers: all_headers, rowSet: [all_row]}]}
    end

    def all_headers
      %w[GAME_ID GAME_DATE GAME_STATUS GAME_STATUS_TEXT
        VISITOR_TEAM_ID VISITOR_TEAM_CITY VISITOR_TEAM_NAME VISITOR_TEAM_ABBREVIATION
        HOME_TEAM_ID HOME_TEAM_CITY HOME_TEAM_NAME HOME_TEAM_ABBREVIATION
        IS_AVAILABLE PT_XYZ_AVAILABLE]
    end

    def all_row
      ["0022300001", "2023-10-24", 3, "Final",
        Team::GSW, "Golden State", "Warriors", "GSW",
        Team::LAL, "Los Angeles", "Lakers", "LAL",
        1, 1]
    end
  end
end
