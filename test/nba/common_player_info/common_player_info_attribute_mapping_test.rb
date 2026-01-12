require_relative "../../test_helper"

module NBA
  class CommonPlayerInfoAttributeMappingTest < Minitest::Test
    cover CommonPlayerInfo

    def test_maps_name_attributes
      stub_player_info_request
      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal 201_939, info.player_id
      assert_equal "Stephen", info.first_name
      assert_equal "Curry", info.last_name
      assert_equal "Stephen Curry", info.display_name
    end

    def test_maps_bio_attributes
      stub_player_info_request
      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal "1988-03-14", info.birthdate
      assert_equal "Davidson", info.school
      assert_equal "USA", info.country
    end

    def test_maps_physical_attributes
      stub_player_info_request
      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal "6-2", info.height
      assert_equal 185, info.weight
      assert_equal 15, info.season_exp
      assert_equal "30", info.jersey
      assert_equal "Guard", info.position
    end

    def test_maps_draft_attributes
      stub_player_info_request
      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal 2009, info.draft_year
      assert_equal 1, info.draft_round
      assert_equal 7, info.draft_number
    end

    def test_maps_team_attributes
      stub_player_info_request
      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal Team::GSW, info.team_id
      assert_equal "Warriors", info.team_name
      assert_equal "GSW", info.team_abbreviation
      assert_equal "Golden State", info.team_city
    end

    def test_maps_career_year_attributes
      stub_player_info_request
      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal 2009, info.from_year
      assert_equal 2024, info.to_year
      assert_equal "Y", info.greatest_75_flag
    end

    def test_full_name_returns_display_name_when_present
      stub_player_info_request
      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal "Stephen Curry", info.full_name
    end

    def test_full_name_falls_back_to_first_and_last_when_no_display_name
      headers = %w[PERSON_ID FIRST_NAME LAST_NAME DISPLAY_FIRST_LAST TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY]
      row = [201_939, "Stephen", "Curry", nil, Team::GSW, "Warriors", "GSW", "Golden State"]
      response = {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal "Stephen Curry", info.full_name
    end

    def test_greatest_75_returns_true_when_y
      stub_player_info_request

      assert_predicate CommonPlayerInfo.find(player: 201_939), :greatest_75?
    end

    def test_greatest_75_returns_false_when_not_y
      headers = %w[PERSON_ID FIRST_NAME LAST_NAME GREATEST_75_FLAG TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY]
      row = [201_939, "Stephen", "Curry", "N", Team::GSW, "Warriors", "GSW", "Golden State"]
      response = {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      refute_predicate CommonPlayerInfo.find(player: 201_939), :greatest_75?
    end

    private

    def stub_player_info_request
      stub_request(:get, /commonplayerinfo/).to_return(body: player_info_response.to_json)
    end

    def player_info_response
      {resultSets: [{name: "CommonPlayerInfo", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_headers
      %w[PERSON_ID FIRST_NAME LAST_NAME DISPLAY_FIRST_LAST BIRTHDATE SCHOOL COUNTRY HEIGHT WEIGHT
        SEASON_EXP JERSEY POSITION FROM_YEAR TO_YEAR DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER GREATEST_75_FLAG
        TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY]
    end

    def player_row
      [201_939, "Stephen", "Curry", "Stephen Curry", "1988-03-14", "Davidson", "USA", "6-2", "185",
        15, "30", "Guard", 2009, 2024, "2009", "1", "7", "Y",
        Team::GSW, "Warriors", "GSW", "Golden State"]
    end
  end
end
