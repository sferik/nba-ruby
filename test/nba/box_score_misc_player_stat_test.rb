require_relative "../test_helper"

module NBA
  class BoxScoreMiscPlayerStatTest < Minitest::Test
    cover BoxScoreMiscPlayerStat

    def test_objects_with_same_game_id_and_player_id_are_equal
      stat0 = BoxScoreMiscPlayerStat.new(game_id: "001", player_id: 123)
      stat1 = BoxScoreMiscPlayerStat.new(game_id: "001", player_id: 123)

      assert_equal stat0, stat1
    end

    def test_starter_returns_true_when_start_position_present
      stat = BoxScoreMiscPlayerStat.new(start_position: "G")

      assert_predicate stat, :starter?
    end

    def test_starter_returns_false_when_start_position_nil
      stat = BoxScoreMiscPlayerStat.new(start_position: nil)

      refute_predicate stat, :starter?
    end

    def test_starter_returns_false_when_start_position_empty
      stat = BoxScoreMiscPlayerStat.new(start_position: "")

      refute_predicate stat, :starter?
    end

    def test_player_returns_nil_when_player_id_is_nil
      stat = BoxScoreMiscPlayerStat.new(player_id: nil)

      assert_nil stat.player
    end

    def test_player_returns_player_object_when_player_id_valid
      stub_request(:get, /commonplayerinfo/).to_return(body: player_info_response.to_json)

      stat = BoxScoreMiscPlayerStat.new(player_id: 201_939)
      result = stat.player

      assert_instance_of Player, result
      assert_equal 201_939, result.id
    end

    def test_team_returns_nil_when_team_id_is_nil
      stat = BoxScoreMiscPlayerStat.new(team_id: nil)

      assert_nil stat.team
    end

    def test_team_returns_team_object_when_team_id_valid
      stat = BoxScoreMiscPlayerStat.new(team_id: Team::GSW)

      result = stat.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end

    def test_game_returns_nil_when_game_id_is_nil
      stat = BoxScoreMiscPlayerStat.new(game_id: nil)

      assert_nil stat.game
    end

    def test_game_returns_game_object_when_game_id_valid
      stub_request(:get, /boxscoresummaryv2/).to_return(body: game_summary_response.to_json)

      stat = BoxScoreMiscPlayerStat.new(game_id: "0022400001")
      result = stat.game

      assert_instance_of Game, result
      assert_equal "0022400001", result.id
    end

    private

    def player_info_response
      headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS JERSEY HEIGHT
        WEIGHT SCHOOL COUNTRY DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER]
      row = [201_939, "Stephen Curry", "Stephen", "Curry", "Active", "30", "6-2", 185, "Davidson",
        "USA", 2009, 1, 7]
      {resultSets: [{headers: headers, rowSet: [row]}]}
    end

    def game_summary_response
      {resultSets: [{name: "GameSummary", headers: %w[GAME_ID GAME_DATE_EST GAME_STATUS_ID HOME_TEAM_ID VISITOR_TEAM_ID ARENA],
                     rowSet: [["0022400001", "2024-10-22", 3, Team::GSW, Team::LAL, "Chase Center"]]}]}
    end
  end
end
