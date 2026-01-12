require_relative "../../test_helper"

module NBA
  class BoxScoreHustlePlayerStatModelTest < Minitest::Test
    cover BoxScoreHustlePlayerStat

    def test_objects_with_same_game_id_and_player_id_are_equal
      stat0 = BoxScoreHustlePlayerStat.new(game_id: "0022400001", player_id: 201_939)
      stat1 = BoxScoreHustlePlayerStat.new(game_id: "0022400001", player_id: 201_939)

      assert_equal stat0, stat1
    end

    def test_objects_with_different_game_id_are_not_equal
      stat0 = BoxScoreHustlePlayerStat.new(game_id: "0022400001", player_id: 201_939)
      stat1 = BoxScoreHustlePlayerStat.new(game_id: "0022400002", player_id: 201_939)

      refute_equal stat0, stat1
    end

    def test_objects_with_different_player_id_are_not_equal
      stat0 = BoxScoreHustlePlayerStat.new(game_id: "0022400001", player_id: 201_939)
      stat1 = BoxScoreHustlePlayerStat.new(game_id: "0022400001", player_id: 2544)

      refute_equal stat0, stat1
    end

    def test_player_returns_nil_when_player_id_is_nil
      stat = BoxScoreHustlePlayerStat.new(player_id: nil)

      assert_nil stat.player
    end

    def test_team_returns_nil_when_team_id_is_nil
      stat = BoxScoreHustlePlayerStat.new(team_id: nil)

      assert_nil stat.team
    end

    def test_game_returns_nil_when_game_id_is_nil
      stat = BoxScoreHustlePlayerStat.new(game_id: nil)

      assert_nil stat.game
    end

    def test_player_returns_player_object_when_player_id_valid
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)

      stat = BoxScoreHustlePlayerStat.new(player_id: 201_939)
      result = stat.player

      assert_instance_of Player, result
      assert_equal 201_939, result.id
    end

    def test_team_returns_team_object_when_team_id_valid
      stat = BoxScoreHustlePlayerStat.new(team_id: Team::GSW)

      result = stat.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end

    def test_game_returns_game_object_when_game_id_valid
      stub_request(:get, /boxscoresummaryv2/).to_return(body: game_response.to_json)

      stat = BoxScoreHustlePlayerStat.new(game_id: "0022400001")
      result = stat.game

      assert_instance_of Game, result
      assert_equal "0022400001", result.id
    end

    def test_starter_returns_true_when_start_position_present
      stat = BoxScoreHustlePlayerStat.new(start_position: "G")

      assert_predicate stat, :starter?
    end

    def test_starter_returns_false_when_start_position_nil
      stat = BoxScoreHustlePlayerStat.new(start_position: nil)

      refute_predicate stat, :starter?
    end

    def test_starter_returns_false_when_start_position_empty
      stat = BoxScoreHustlePlayerStat.new(start_position: "")

      refute_predicate stat, :starter?
    end

    private

    def player_response
      headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME]
      row = [201_939, "Stephen Curry", "Stephen", "Curry"]
      {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
    end

    def game_response
      headers = %w[GAME_DATE_EST GAME_SEQUENCE GAME_ID GAME_STATUS_ID GAME_STATUS_TEXT HOME_TEAM_ID VISITOR_TEAM_ID ARENA]
      row = ["2024-10-22", 1, "0022400001", 3, "Final", Team::GSW, Team::LAL, "Chase Center"]
      {resultSets: [{name: "GameSummary", headers: headers, rowSet: [row]}]}
    end
  end
end
