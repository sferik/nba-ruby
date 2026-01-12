require_relative "common_player_info_test_helpers"

module NBA
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
end
