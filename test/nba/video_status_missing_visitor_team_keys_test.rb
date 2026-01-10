require_relative "../test_helper"

module NBA
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
end
