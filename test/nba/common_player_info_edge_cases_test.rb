require_relative "../test_helper"

module NBA
  module CommonPlayerInfoTestHelpers
    private

    def info_headers
      %w[PERSON_ID FIRST_NAME LAST_NAME DISPLAY_FIRST_LAST BIRTHDATE SCHOOL COUNTRY HEIGHT
        WEIGHT SEASON_EXP JERSEY POSITION TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY
        DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER FROM_YEAR TO_YEAR GREATEST_75_FLAG]
    end

    def info_row
      [201_939, "Stephen", "Curry", "Stephen Curry", "1988-03-14", "Davidson", "USA", "6-2",
        "185", 15, "30", "Guard", Team::GSW, "Warriors", "GSW", "Golden State",
        "2009", "1", "7", 2009, 2024, "Y"]
    end

    def build_response(headers, row)
      {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
    end
  end

  class CommonPlayerInfoNilResponseTest < Minitest::Test
    include CommonPlayerInfoTestHelpers

    cover CommonPlayerInfo

    def test_returns_nil_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = CommonPlayerInfo.find(player: 201_939, client: mock_client)

      assert_nil result
      mock_client.verify
    end

    def test_returns_nil_when_no_result_sets
      stub_request(:get, /commonplayerinfo/).to_return(body: {resultSets: nil}.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end

    def test_returns_nil_when_result_sets_key_missing
      stub_request(:get, /commonplayerinfo/).to_return(body: {}.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end

    def test_returns_nil_when_headers_key_missing
      response = {resultSets: [{name: "CommonPlayerInfo", rowSet: [[1]]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end

    def test_returns_nil_when_row_set_key_missing
      response = {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end

    def test_returns_nil_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end

    def test_returns_nil_when_no_headers
      response = {resultSets: [{name: "CommonPlayerInfo", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end

    def test_returns_nil_when_no_rows
      response = {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID], rowSet: nil}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end

    def test_returns_nil_when_row_set_empty
      response = {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID], rowSet: []}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end
  end

  class CommonPlayerInfoResultSetOrderingTest < Minitest::Test
    include CommonPlayerInfoTestHelpers

    cover CommonPlayerInfo

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "CommonPlayerInfo", headers: info_headers, rowSet: [info_row]}
      ]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_equal 201_939, CommonPlayerInfo.find(player: 201_939).player_id
    end

    def test_skips_result_set_without_name_key
      response = {resultSets: [
        {headers: [], rowSet: []},
        {name: "CommonPlayerInfo", headers: info_headers, rowSet: [info_row]}
      ]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_equal 201_939, CommonPlayerInfo.find(player: 201_939).player_id
    end

    def test_uses_first_row_when_multiple_rows_present
      second_row = info_row.dup.tap { |r| r[0] = 12_345 }
      response = {resultSets: [{name: "CommonPlayerInfo", headers: info_headers, rowSet: [info_row, second_row]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_equal 201_939, CommonPlayerInfo.find(player: 201_939).player_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "CommonPlayerInfo", headers: info_headers, rowSet: [info_row]},
        {name: "Other", headers: %w[WRONG], rowSet: [["wrong_data"]]}
      ]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_equal "Stephen Curry", CommonPlayerInfo.find(player: 201_939).display_name
    end
  end

  class CommonPlayerInfoTypeConversionTest < Minitest::Test
    include CommonPlayerInfoTestHelpers

    cover CommonPlayerInfo

    def test_weight_returned_as_integer_when_string
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, info_row).to_json)
      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal 185, info.weight
      assert_kind_of Integer, info.weight
    end

    def test_draft_year_returned_as_integer_when_string
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, info_row).to_json)
      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal 2009, info.draft_year
      assert_kind_of Integer, info.draft_year
    end

    def test_draft_round_returned_as_integer_when_string
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, info_row).to_json)
      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal 1, info.draft_round
      assert_kind_of Integer, info.draft_round
    end

    def test_draft_number_returned_as_integer_when_string
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, info_row).to_json)
      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal 7, info.draft_number
      assert_kind_of Integer, info.draft_number
    end
  end

  class CommonPlayerInfoMissingKeysTest < Minitest::Test
    cover CommonPlayerInfo

    def test_returns_nil_for_missing_team_id_key
      headers = %w[PERSON_ID FIRST_NAME LAST_NAME TEAM_NAME]
      row = [201_939, "Stephen", "Curry", "Warriors"]
      response = {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).team_id
    end

    def test_returns_nil_for_missing_team_name_key
      headers = %w[PERSON_ID FIRST_NAME LAST_NAME TEAM_ID]
      row = [201_939, "Stephen", "Curry", Team::GSW]
      response = {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).team_name
    end

    def test_returns_nil_for_missing_team_abbreviation_key
      headers = %w[PERSON_ID FIRST_NAME LAST_NAME TEAM_ID TEAM_NAME]
      row = [201_939, "Stephen", "Curry", Team::GSW, "Warriors"]
      response = {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).team_abbreviation
    end

    def test_returns_nil_for_missing_team_city_key
      headers = %w[PERSON_ID FIRST_NAME LAST_NAME TEAM_ID TEAM_NAME TEAM_ABBREVIATION]
      row = [201_939, "Stephen", "Curry", Team::GSW, "Warriors", "GSW"]
      response = {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).team_city
    end

    def test_returns_nil_for_missing_first_name_key
      headers = %w[PERSON_ID LAST_NAME DISPLAY_FIRST_LAST]
      row = [201_939, "Curry", "Stephen Curry"]
      response = {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).first_name
    end

    def test_returns_nil_for_missing_last_name_key
      headers = %w[PERSON_ID FIRST_NAME DISPLAY_FIRST_LAST]
      row = [201_939, "Stephen", "Stephen Curry"]
      response = {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).last_name
    end

    def test_returns_nil_for_missing_display_name_key
      headers = %w[PERSON_ID FIRST_NAME LAST_NAME]
      row = [201_939, "Stephen", "Curry"]
      response = {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).display_name
    end

    def test_returns_nil_for_missing_person_id_key
      headers = %w[FIRST_NAME LAST_NAME DISPLAY_FIRST_LAST]
      row = ["Stephen", "Curry", "Stephen Curry"]
      response = {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).player_id
    end
  end

  class CommonPlayerInfoFieldEdgeCasesTest < Minitest::Test
    include CommonPlayerInfoTestHelpers

    cover CommonPlayerInfo

    def test_handles_undrafted_draft_year
      row = info_row.dup.tap { |r| r[16] = "Undrafted" }
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, row).to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).draft_year
    end

    def test_handles_undrafted_draft_round
      row = info_row.dup.tap { |r| r[17] = "Undrafted" }
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, row).to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).draft_round
    end

    def test_handles_undrafted_draft_number
      row = info_row.dup.tap { |r| r[18] = "Undrafted" }
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, row).to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).draft_number
    end

    def test_handles_nil_weight
      row = info_row.dup.tap { |r| r[8] = nil }
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, row).to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).weight
    end

    def test_handles_nil_draft_year
      row = info_row.dup.tap { |r| r[16] = r[17] = r[18] = nil }
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, row).to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).draft_year
    end

    def test_handles_valid_draft_year_as_number
      row = info_row.dup.tap { |r| r[16] = 2009 }
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, row).to_json)

      assert_equal 2009, CommonPlayerInfo.find(player: 201_939).draft_year
    end

    def test_handles_zero_weight
      row = info_row.dup.tap { |r| r[8] = 0 }
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, row).to_json)

      assert_equal 0, CommonPlayerInfo.find(player: 201_939).weight
    end

    private

    def build_response(headers, row)
      {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
    end
  end
end
