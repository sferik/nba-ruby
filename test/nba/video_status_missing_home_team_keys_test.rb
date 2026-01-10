require_relative "../test_helper"

module NBA
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
end
