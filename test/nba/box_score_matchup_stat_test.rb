require_relative "../test_helper"

module NBA
  class BoxScoreMatchupStatTest < Minitest::Test
    cover BoxScoreMatchupStat

    def test_objects_with_same_game_id_and_player_ids_are_equal
      stat0 = BoxScoreMatchupStat.new(game_id: "001", person_id_off: 123, person_id_def: 456)
      stat1 = BoxScoreMatchupStat.new(game_id: "001", person_id_off: 123, person_id_def: 456)

      assert_equal stat0, stat1
    end

    def test_objects_with_different_game_id_are_not_equal
      stat0 = BoxScoreMatchupStat.new(game_id: "001", person_id_off: 123, person_id_def: 456)
      stat1 = BoxScoreMatchupStat.new(game_id: "002", person_id_off: 123, person_id_def: 456)

      refute_equal stat0, stat1
    end

    def test_objects_with_different_person_id_off_are_not_equal
      stat0 = BoxScoreMatchupStat.new(game_id: "001", person_id_off: 123, person_id_def: 456)
      stat1 = BoxScoreMatchupStat.new(game_id: "001", person_id_off: 789, person_id_def: 456)

      refute_equal stat0, stat1
    end

    def test_objects_with_different_person_id_def_are_not_equal
      stat0 = BoxScoreMatchupStat.new(game_id: "001", person_id_off: 123, person_id_def: 456)
      stat1 = BoxScoreMatchupStat.new(game_id: "001", person_id_off: 123, person_id_def: 789)

      refute_equal stat0, stat1
    end

    def test_offensive_player_returns_player_object
      stub_request(:get, %r{stats\.nba\.com/stats/commonplayerinfo}).to_return(body: player_info_response(201_939).to_json)
      stat = BoxScoreMatchupStat.new(person_id_off: 201_939)

      player = stat.offensive_player

      assert_instance_of Player, player
      assert_equal 201_939, player.id
    end

    def test_offensive_player_returns_nil_when_person_id_off_is_nil
      stat = BoxScoreMatchupStat.new(person_id_off: nil)

      assert_nil stat.offensive_player
    end

    def test_defensive_player_returns_player_object
      stub_request(:get, %r{stats\.nba\.com/stats/commonplayerinfo}).to_return(body: player_info_response(203_507).to_json)
      stat = BoxScoreMatchupStat.new(person_id_def: 203_507)

      player = stat.defensive_player

      assert_instance_of Player, player
      assert_equal 203_507, player.id
    end

    def test_defensive_player_returns_nil_when_person_id_def_is_nil
      stat = BoxScoreMatchupStat.new(person_id_def: nil)

      assert_nil stat.defensive_player
    end

    def test_team_returns_team_object
      stat = BoxScoreMatchupStat.new(team_id: Team::GSW)

      team = stat.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_team_returns_nil_when_team_id_is_nil
      stat = BoxScoreMatchupStat.new(team_id: nil)

      assert_nil stat.team
    end

    def test_game_returns_game_object
      stub_request(:get, %r{stats\.nba\.com/stats/boxscoresummaryv2}).to_return(body: game_summary_response.to_json)
      stat = BoxScoreMatchupStat.new(game_id: "0022400001")

      game = stat.game

      assert_instance_of Game, game
      assert_equal "0022400001", game.id
    end

    def test_game_returns_nil_when_game_id_is_nil
      stat = BoxScoreMatchupStat.new(game_id: nil)

      assert_nil stat.game
    end

    private

    def player_info_response(player_id)
      headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS JERSEY HEIGHT
        WEIGHT SCHOOL COUNTRY DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER]
      row = [player_id, "Test Player", "Test", "Player", "Active", "30", "6-2", 185, "Test U", "USA", 2009, 1, 7]
      {resultSets: [{headers: headers, rowSet: [row]}]}
    end

    def game_summary_response
      headers = %w[GAME_DATE_EST GAME_SEQUENCE GAME_ID GAME_STATUS_ID GAME_STATUS_TEXT
        GAMECODE HOME_TEAM_ID VISITOR_TEAM_ID SEASON LIVE_PERIOD LIVE_PC_TIME
        NATL_TV_BROADCASTER_ABBREVIATION LIVE_PERIOD_TIME_BCAST WH_STATUS]
      row = ["2024-10-22T00:00:00", 1, "0022400001", 3, "Final", "20241022/MILGSW",
        Team::GSW, Team::MIL, "2024", 4, "", "TNT", "Q4", 1]
      {resultSets: [{name: "GameSummary", headers: headers, rowSet: [row]}]}
    end
  end
end
