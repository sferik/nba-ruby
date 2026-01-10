require_relative "common_player_info_test_helpers"

module NBA
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
end
