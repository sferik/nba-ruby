require_relative "../test_helper"

module NBA
  class BoxScorePlayerStatTest < Minitest::Test
    cover BoxScorePlayerStat

    def test_objects_with_same_game_id_and_player_id_are_equal
      stat0 = BoxScorePlayerStat.new(game_id: "001", player_id: 123)
      stat1 = BoxScorePlayerStat.new(game_id: "001", player_id: 123)

      assert_equal stat0, stat1
    end

    def test_objects_with_different_player_id_are_not_equal
      stat0 = BoxScorePlayerStat.new(game_id: "001", player_id: 123)
      stat1 = BoxScorePlayerStat.new(game_id: "001", player_id: 456)

      refute_equal stat0, stat1
    end

    def test_player_returns_player_object
      stub_request(:get, %r{stats\.nba\.com/stats/commonplayerinfo}).to_return(body: player_info_response.to_json)
      stat = BoxScorePlayerStat.new(player_id: 201_939)

      player = stat.player

      assert_instance_of Player, player
      assert_equal 201_939, player.id
    end

    def player_info_response
      headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS JERSEY HEIGHT
        WEIGHT SCHOOL COUNTRY DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER]
      row = [201_939, "Stephen Curry", "Stephen", "Curry", "Active", "30", "6-2", 185, "Davidson", "USA", 2009, 1, 7]
      {resultSets: [{headers: headers, rowSet: [row]}]}
    end

    def test_player_returns_nil_when_player_id_is_nil
      stat = BoxScorePlayerStat.new(player_id: nil)

      assert_nil stat.player
    end

    def test_team_returns_team_object
      stat = BoxScorePlayerStat.new(team_id: Team::GSW)

      team = stat.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_team_returns_nil_when_team_id_is_nil
      stat = BoxScorePlayerStat.new(team_id: nil)

      assert_nil stat.team
    end

    def test_starter_returns_true_when_start_position_present
      stat = BoxScorePlayerStat.new(start_position: "G")

      assert_predicate stat, :starter?
    end

    def test_starter_returns_false_when_start_position_empty
      stat = BoxScorePlayerStat.new(start_position: "")

      refute_predicate stat, :starter?
    end

    def test_starter_returns_false_when_start_position_nil
      stat = BoxScorePlayerStat.new(start_position: nil)

      refute_predicate stat, :starter?
    end
  end
end
