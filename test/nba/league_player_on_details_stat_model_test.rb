require_relative "../test_helper"

module NBA
  class LeaguePlayerOnDetailsStatModelTest < Minitest::Test
    cover LeaguePlayerOnDetailsStat

    def test_objects_with_same_team_id_and_vs_player_id_are_equal
      stat0 = LeaguePlayerOnDetailsStat.new(team_id: Team::GSW, vs_player_id: 201_939)
      stat1 = LeaguePlayerOnDetailsStat.new(team_id: Team::GSW, vs_player_id: 201_939)

      assert_equal stat0, stat1
    end

    def test_objects_with_different_team_id_are_not_equal
      stat0 = LeaguePlayerOnDetailsStat.new(team_id: Team::GSW, vs_player_id: 201_939)
      stat1 = LeaguePlayerOnDetailsStat.new(team_id: Team::LAL, vs_player_id: 201_939)

      refute_equal stat0, stat1
    end

    def test_objects_with_different_vs_player_id_are_not_equal
      stat0 = LeaguePlayerOnDetailsStat.new(team_id: Team::GSW, vs_player_id: 201_939)
      stat1 = LeaguePlayerOnDetailsStat.new(team_id: Team::GSW, vs_player_id: 2544)

      refute_equal stat0, stat1
    end

    def test_player_returns_nil_when_vs_player_id_is_nil
      stat = LeaguePlayerOnDetailsStat.new(vs_player_id: nil)

      assert_nil stat.player
    end

    def test_player_returns_player_object_when_vs_player_id_valid
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)

      stat = LeaguePlayerOnDetailsStat.new(vs_player_id: 201_939)

      result = stat.player

      assert_instance_of Player, result
      assert_equal 201_939, result.id
    end

    def test_team_returns_nil_when_team_id_is_nil
      stat = LeaguePlayerOnDetailsStat.new(team_id: nil)

      assert_nil stat.team
    end

    def test_team_returns_team_object_when_team_id_valid
      stat = LeaguePlayerOnDetailsStat.new(team_id: Team::GSW)

      result = stat.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end

    private

    def player_response
      {resultSets: [{
        name: "CommonPlayerInfo",
        headers: %w[PERSON_ID FIRST_NAME LAST_NAME DISPLAY_FIRST_LAST BIRTHDATE SCHOOL COUNTRY HEIGHT WEIGHT
          SEASON_EXP JERSEY POSITION TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY DRAFT_YEAR DRAFT_ROUND
          DRAFT_NUMBER FROM_YEAR TO_YEAR GREATEST_75_FLAG],
        rowSet: [[201_939, "Stephen", "Curry", "Stephen Curry", "1988-03-14T00:00:00", "Davidson", "USA",
          "6-2", "185", 15, "30", "Guard", Team::GSW, "Warriors", "GSW", "Golden State", 2009, 1, 7,
          2009, 2024, "Y"]]
      }]}
    end
  end
end
