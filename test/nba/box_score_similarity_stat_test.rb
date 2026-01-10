require_relative "../test_helper"

module NBA
  class BoxScoreSimilarityStatTest < Minitest::Test
    cover BoxScoreSimilarityStat

    def test_equality_based_on_person_ids
      stat1 = BoxScoreSimilarityStat.new(first_person_id: 201_939, second_person_id: 203_507)
      stat2 = BoxScoreSimilarityStat.new(first_person_id: 201_939, second_person_id: 203_507)

      assert_equal stat1, stat2
    end

    def test_inequality_when_first_person_ids_differ
      stat1 = BoxScoreSimilarityStat.new(first_person_id: 201_939, second_person_id: 203_507)
      stat2 = BoxScoreSimilarityStat.new(first_person_id: 201_566, second_person_id: 203_507)

      refute_equal stat1, stat2
    end

    def test_inequality_when_second_person_ids_differ
      stat1 = BoxScoreSimilarityStat.new(first_person_id: 201_939, second_person_id: 203_507)
      stat2 = BoxScoreSimilarityStat.new(first_person_id: 201_939, second_person_id: 201_566)

      refute_equal stat1, stat2
    end

    def test_first_person_returns_nil_when_first_person_id_nil
      stat = BoxScoreSimilarityStat.new(first_person_id: nil)

      assert_nil stat.first_person
    end

    def test_first_person_returns_player_when_first_person_id_present
      stub_player_request(201_939)
      stat = BoxScoreSimilarityStat.new(first_person_id: 201_939)

      result = stat.first_person

      assert_instance_of Player, result
      assert_equal 201_939, result.id
    end

    def test_second_person_returns_nil_when_second_person_id_nil
      stat = BoxScoreSimilarityStat.new(second_person_id: nil)

      assert_nil stat.second_person
    end

    def test_second_person_returns_player_when_second_person_id_present
      stub_player_request(203_507)
      stat = BoxScoreSimilarityStat.new(second_person_id: 203_507)

      result = stat.second_person

      assert_instance_of Player, result
      assert_equal 203_507, result.id
    end

    def test_team_returns_nil_when_team_id_nil
      stat = BoxScoreSimilarityStat.new(team_id: nil)

      assert_nil stat.team
    end

    def test_team_returns_team_when_team_id_present
      stub_team_request(Team::MIL)
      stat = BoxScoreSimilarityStat.new(team_id: Team::MIL)

      result = stat.team

      assert_instance_of Team, result
      assert_equal Team::MIL, result.id
    end

    private

    def stub_player_request(player_id)
      response = player_response(player_id)
      stub_request(:get, /commonplayerinfo\?PlayerID=#{player_id}/).to_return(body: response.to_json)
    end

    def player_response(player_id)
      {resultSets: [{name: "CommonPlayerInfo", headers: player_headers, rowSet: [player_row(player_id)]}]}
    end

    def player_headers
      %w[PERSON_ID DISPLAY_FIRST_LAST BIRTHDATE SCHOOL COUNTRY HEIGHT WEIGHT SEASON_EXP JERSEY
        POSITION TEAM_ID TEAM_NAME TEAM_ABBREVIATION FROM_YEAR TO_YEAR GREATEST_75_FLAG DRAFT_YEAR
        DRAFT_ROUND DRAFT_NUMBER]
    end

    def player_row(player_id)
      [player_id, "Test Player", "1988-03-14", "Test School", "USA", "6-2", 185, 15, "30",
        "Guard", Team::GSW, "Golden State Warriors", "GSW", 2009, 2024, "Y", 2009, 1, 7]
    end

    def stub_team_request(team_id)
      response = team_response(team_id)
      stub_request(:get, /teaminfocommon\?TeamID=#{team_id}/).to_return(body: response.to_json)
    end

    def team_response(team_id)
      {resultSets: [{name: "TeamInfoCommon", headers: team_headers, rowSet: [team_row(team_id)]}]}
    end

    def team_headers
      %w[TEAM_ID SEASON_YEAR TEAM_CITY TEAM_NAME TEAM_ABBREVIATION TEAM_CONFERENCE TEAM_DIVISION
        TEAM_CODE TEAM_SLUG W L PCT CONF_RANK DIV_RANK MIN_YEAR MAX_YEAR LEAGUE_ID SEASON_ID PTS OPP_PTS DIFF]
    end

    def team_row(team_id)
      [team_id, "2024-25", "Milwaukee", "Bucks", "MIL", "East", "Central", "bucks", "bucks",
        46, 36, 0.561, 3, 1, 1968, 2024, "00", "22024", 115.0, 112.0, 3.0]
    end
  end
end
