require_relative "../test_helper"

module NBA
  class LeagueDashPlayerClutchStatModelTest < Minitest::Test
    cover LeagueDashPlayerClutchStat

    def test_objects_with_same_player_id_and_season_id_are_equal
      stat0 = LeagueDashPlayerClutchStat.new(player_id: 201_939, season_id: "2024-25")
      stat1 = LeagueDashPlayerClutchStat.new(player_id: 201_939, season_id: "2024-25")

      assert_equal stat0, stat1
    end

    def test_objects_with_different_player_id_are_not_equal
      stat0 = LeagueDashPlayerClutchStat.new(player_id: 201_939, season_id: "2024-25")
      stat1 = LeagueDashPlayerClutchStat.new(player_id: 2544, season_id: "2024-25")

      refute_equal stat0, stat1
    end

    def test_objects_with_different_season_id_are_not_equal
      stat0 = LeagueDashPlayerClutchStat.new(player_id: 201_939, season_id: "2024-25")
      stat1 = LeagueDashPlayerClutchStat.new(player_id: 201_939, season_id: "2023-24")

      refute_equal stat0, stat1
    end

    def test_player_returns_nil_when_player_id_is_nil
      stat = LeagueDashPlayerClutchStat.new(player_id: nil)

      assert_nil stat.player
    end

    def test_player_returns_player_object_when_player_id_valid
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)

      stat = LeagueDashPlayerClutchStat.new(player_id: 201_939)

      result = stat.player

      assert_instance_of Player, result
      assert_equal 201_939, result.id
    end

    def test_team_returns_nil_when_team_id_is_nil
      stat = LeagueDashPlayerClutchStat.new(team_id: nil)

      assert_nil stat.team
    end

    def test_team_returns_team_object_when_team_id_valid
      stat = LeagueDashPlayerClutchStat.new(team_id: Team::GSW)

      result = stat.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end

    private

    def player_response
      {resultSets: [{name: "CommonPlayerInfo",
                     headers: %w[PERSON_ID DISPLAY_FIRST_LAST BIRTHDATE HEIGHT WEIGHT JERSEY POSITION
                       TEAM_ID TEAM_NAME TEAM_ABBREVIATION FROM_YEAR TO_YEAR GREATEST_75_FLAG],
                     rowSet: [[201_939, "Stephen Curry", "1988-03-14", "6-2", "185", "30", "Guard",
                       Team::GSW, "Golden State Warriors", "GSW", 2009, 2024, "Y"]]}]}
    end
  end
end
