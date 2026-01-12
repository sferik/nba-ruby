require_relative "../../test_helper"

module NBA
  class CommonPlayerInfoTeamAttributeMappingTest < Minitest::Test
    cover CommonPlayerInfo

    def test_maps_team_id
      stub_player_info_request

      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal Team::GSW, info.team_id
    end

    def test_maps_team_name
      stub_player_info_request

      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal "Warriors", info.team_name
    end

    def test_maps_team_abbreviation
      stub_player_info_request

      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal "GSW", info.team_abbreviation
    end

    def test_maps_team_city
      stub_player_info_request

      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal "Golden State", info.team_city
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
