require_relative "../test_helper"

module NBA
  class LeagueDashPtDefendStatTest < Minitest::Test
    cover LeagueDashPtDefendStat

    def test_objects_with_same_player_id_and_team_id_are_equal
      stat0 = LeagueDashPtDefendStat.new(player_id: 201_939, team_id: Team::GSW)
      stat1 = LeagueDashPtDefendStat.new(player_id: 201_939, team_id: Team::GSW)

      assert_equal stat0, stat1
    end

    def test_objects_with_different_player_id_are_not_equal
      stat0 = LeagueDashPtDefendStat.new(player_id: 201_939, team_id: Team::GSW)
      stat1 = LeagueDashPtDefendStat.new(player_id: 2544, team_id: Team::GSW)

      refute_equal stat0, stat1
    end

    def test_objects_with_different_team_id_are_not_equal
      stat0 = LeagueDashPtDefendStat.new(player_id: 201_939, team_id: Team::GSW)
      stat1 = LeagueDashPtDefendStat.new(player_id: 201_939, team_id: 1_610_612_747)

      refute_equal stat0, stat1
    end

    def test_player_returns_nil_when_player_id_is_nil
      stat = LeagueDashPtDefendStat.new(player_id: nil)

      assert_nil stat.player
    end

    def test_team_returns_nil_when_team_id_is_nil
      stat = LeagueDashPtDefendStat.new(team_id: nil)

      assert_nil stat.team
    end

    def test_player_returns_player_object_when_player_id_valid
      stub_request(:get, /commonplayerinfo/).to_return(body: player_info_response.to_json)

      stat = LeagueDashPtDefendStat.new(player_id: 201_939)
      result = stat.player

      assert_instance_of Player, result
      assert_equal 201_939, result.id
    end

    def test_team_returns_team_object_when_team_id_valid
      stat = LeagueDashPtDefendStat.new(team_id: Team::GSW)

      result = stat.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end

    private

    def player_info_response
      headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS JERSEY
        HEIGHT WEIGHT SCHOOL COUNTRY DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER]
      row = [201_939, "Stephen Curry", "Stephen", "Curry", "Active", "30", "6-2", 185,
        "Davidson", "USA", 2009, 1, 7]
      {resultSets: [{headers: headers, rowSet: [row]}]}
    end
  end
end
