require_relative "../test_helper"

module NBA
  class RotationEntryTest < Minitest::Test
    cover RotationEntry

    def test_objects_with_same_game_id_player_id_and_in_time_are_equal
      entry0 = RotationEntry.new(game_id: "001", player_id: 123, in_time_real: 0)
      entry1 = RotationEntry.new(game_id: "001", player_id: 123, in_time_real: 0)

      assert_equal entry0, entry1
    end

    def test_objects_with_different_in_time_are_not_equal
      entry0 = RotationEntry.new(game_id: "001", player_id: 123, in_time_real: 0)
      entry1 = RotationEntry.new(game_id: "001", player_id: 123, in_time_real: 6000)

      refute_equal entry0, entry1
    end

    def test_player_name_combines_first_and_last
      entry = RotationEntry.new(player_first: "Stephen", player_last: "Curry")

      assert_equal "Stephen Curry", entry.player_name
    end

    def test_player_name_strips_whitespace_when_nil_first
      entry = RotationEntry.new(player_first: nil, player_last: "Curry")

      assert_equal "Curry", entry.player_name
    end

    def test_duration_returns_difference
      entry = RotationEntry.new(in_time_real: 1000, out_time_real: 6000)

      assert_equal 5000, entry.duration
    end

    def test_duration_returns_nil_when_in_time_nil
      entry = RotationEntry.new(in_time_real: nil, out_time_real: 6000)

      assert_nil entry.duration
    end

    def test_duration_returns_nil_when_out_time_nil
      entry = RotationEntry.new(in_time_real: 0, out_time_real: nil)

      assert_nil entry.duration
    end

    def test_player_returns_player_object
      stub_request(:get, %r{stats\.nba\.com/stats/commonplayerinfo}).to_return(body: player_info_response.to_json)
      entry = RotationEntry.new(player_id: 201_939)

      player = entry.player

      assert_instance_of Player, player
      assert_equal 201_939, player.id
    end

    def test_player_returns_nil_when_player_id_is_nil
      entry = RotationEntry.new(player_id: nil)

      assert_nil entry.player
    end

    def test_team_returns_team_object
      entry = RotationEntry.new(team_id: Team::GSW)

      team = entry.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_team_returns_nil_when_team_id_is_nil
      entry = RotationEntry.new(team_id: nil)

      assert_nil entry.team
    end

    def test_game_returns_game_object
      stub_box_score_summary_request("0022400001")
      entry = RotationEntry.new(game_id: "0022400001")

      game = entry.game

      assert_instance_of Game, game
      assert_equal "0022400001", game.id
    end

    def test_game_returns_nil_when_game_id_is_nil
      entry = RotationEntry.new(game_id: nil)

      assert_nil entry.game
    end

    private

    def player_info_response
      headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS JERSEY HEIGHT
        WEIGHT SCHOOL COUNTRY DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER]
      row = [201_939, "Stephen Curry", "Stephen", "Curry", "Active", "30", "6-2", 185, "Davidson", "USA", 2009, 1, 7]
      {resultSets: [{headers: headers, rowSet: [row]}]}
    end

    def stub_box_score_summary_request(game_id)
      response = {resultSets: [{name: "GameSummary", headers: %w[GAME_ID HOME_TEAM_ID VISITOR_TEAM_ID],
                                rowSet: [[game_id, Team::GSW, Team::LAL]]}]}
      stub_request(:get, /boxscoresummaryv2.*GameID=#{game_id}/).to_return(body: response.to_json)
    end
  end
end
