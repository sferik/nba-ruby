require_relative "../test_helper"

module NBA
  class VideoStatusMissingGameKeysTest < Minitest::Test
    cover VideoStatus

    HEADERS = %w[GAME_ID GAME_DATE GAME_STATUS GAME_STATUS_TEXT].freeze
    ROW = ["0022300001", "2023-10-24", 3, "Final"].freeze

    def test_handles_missing_game_id_key
      stub_with_headers_except("GAME_ID")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.game_id
    end

    def test_handles_missing_game_date_key
      stub_with_headers_except("GAME_DATE")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.game_date
    end

    def test_handles_missing_game_status_key
      stub_with_headers_except("GAME_STATUS")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.game_status
    end

    def test_handles_missing_game_status_text_key
      stub_with_headers_except("GAME_STATUS_TEXT")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.game_status_text
    end

    private

    def stub_with_headers_except(key)
      headers = HEADERS.reject { |h| h == key }
      row = headers.map { |h| ROW[HEADERS.index(h)] }
      response = {resultSets: [{name: "VideoStatus", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videostatus/).to_return(body: response.to_json)
    end
  end

  class VideoStatusMissingVisitorTeamKeysTest < Minitest::Test
    cover VideoStatus

    HEADERS = %w[VISITOR_TEAM_ID VISITOR_TEAM_CITY VISITOR_TEAM_NAME VISITOR_TEAM_ABBREVIATION].freeze
    ROW = [Team::GSW, "Golden State", "Warriors", "GSW"].freeze

    def test_handles_missing_visitor_team_id_key
      stub_with_headers_except("VISITOR_TEAM_ID")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.visitor_team_id
    end

    def test_handles_missing_visitor_team_city_key
      stub_with_headers_except("VISITOR_TEAM_CITY")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.visitor_team_city
    end

    def test_handles_missing_visitor_team_name_key
      stub_with_headers_except("VISITOR_TEAM_NAME")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.visitor_team_name
    end

    def test_handles_missing_visitor_team_abbreviation_key
      stub_with_headers_except("VISITOR_TEAM_ABBREVIATION")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.visitor_team_abbreviation
    end

    private

    def stub_with_headers_except(key)
      headers = HEADERS.reject { |h| h == key }
      row = headers.map { |h| ROW[HEADERS.index(h)] }
      response = {resultSets: [{name: "VideoStatus", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videostatus/).to_return(body: response.to_json)
    end
  end

  class VideoStatusMissingHomeTeamKeysTest < Minitest::Test
    cover VideoStatus

    HEADERS = %w[HOME_TEAM_ID HOME_TEAM_CITY HOME_TEAM_NAME HOME_TEAM_ABBREVIATION].freeze
    ROW = [Team::LAL, "Los Angeles", "Lakers", "LAL"].freeze

    def test_handles_missing_home_team_id_key
      stub_with_headers_except("HOME_TEAM_ID")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.home_team_id
    end

    def test_handles_missing_home_team_city_key
      stub_with_headers_except("HOME_TEAM_CITY")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.home_team_city
    end

    def test_handles_missing_home_team_name_key
      stub_with_headers_except("HOME_TEAM_NAME")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.home_team_name
    end

    def test_handles_missing_home_team_abbreviation_key
      stub_with_headers_except("HOME_TEAM_ABBREVIATION")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.home_team_abbreviation
    end

    private

    def stub_with_headers_except(key)
      headers = HEADERS.reject { |h| h == key }
      row = headers.map { |h| ROW[HEADERS.index(h)] }
      response = {resultSets: [{name: "VideoStatus", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videostatus/).to_return(body: response.to_json)
    end
  end

  class VideoStatusMissingAvailabilityKeysTest < Minitest::Test
    cover VideoStatus

    HEADERS = %w[IS_AVAILABLE PT_XYZ_AVAILABLE].freeze
    ROW = [1, 1].freeze

    def test_handles_missing_is_available_key
      stub_with_headers_except("IS_AVAILABLE")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.is_available
    end

    def test_handles_missing_pt_xyz_available_key
      stub_with_headers_except("PT_XYZ_AVAILABLE")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.pt_xyz_available
    end

    private

    def stub_with_headers_except(key)
      headers = HEADERS.reject { |h| h == key }
      row = headers.map { |h| ROW[HEADERS.index(h)] }
      response = {resultSets: [{name: "VideoStatus", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videostatus/).to_return(body: response.to_json)
    end
  end
end
