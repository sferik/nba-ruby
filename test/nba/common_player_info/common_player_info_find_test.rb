require_relative "../../test_helper"

module NBA
  class CommonPlayerInfoFindTest < Minitest::Test
    cover CommonPlayerInfo

    def test_find_returns_player_info
      stub_player_info_request

      result = CommonPlayerInfo.find(player: 201_939)

      assert_instance_of PlayerInfo, result
    end

    def test_find_uses_correct_player_id_in_path
      stub_player_info_request

      CommonPlayerInfo.find(player: 201_939)

      assert_requested :get, /commonplayerinfo\?PlayerID=201939/
    end

    def test_find_parses_player_info_successfully
      stub_player_info_request

      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal 201_939, info.player_id
      assert_equal "Stephen", info.first_name
      assert_equal "Curry", info.last_name
    end

    def test_find_accepts_player_object
      stub_player_info_request
      player = Player.new(id: 201_939)

      CommonPlayerInfo.find(player: player)

      assert_requested :get, /PlayerID=201939/
    end

    def test_find_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, player_info_response.to_json, ["commonplayerinfo?PlayerID=201939"]

      CommonPlayerInfo.find(player: 201_939, client: mock_client)

      mock_client.verify
    end

    private

    def stub_player_info_request
      stub_request(:get, /commonplayerinfo/).to_return(body: player_info_response.to_json)
    end

    def player_info_response
      {resultSets: [{name: "CommonPlayerInfo", headers: info_headers, rowSet: [info_row]}]}
    end

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
  end
end
