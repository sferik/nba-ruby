require_relative "../test_helper"

module NBA
  class BoxScoreUsageTeamStatTest < Minitest::Test
    cover BoxScoreUsageTeamStat

    def test_objects_with_same_game_id_and_team_id_are_equal
      stat0 = BoxScoreUsageTeamStat.new(game_id: "001", team_id: Team::GSW)
      stat1 = BoxScoreUsageTeamStat.new(game_id: "001", team_id: Team::GSW)

      assert_equal stat0, stat1
    end

    def test_team_returns_nil_when_team_id_is_nil
      stat = BoxScoreUsageTeamStat.new(team_id: nil)

      assert_nil stat.team
    end

    def test_team_returns_team_object_when_team_id_valid
      stat = BoxScoreUsageTeamStat.new(team_id: Team::GSW)

      result = stat.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end

    def test_game_returns_nil_when_game_id_is_nil
      stat = BoxScoreUsageTeamStat.new(game_id: nil)

      assert_nil stat.game
    end

    def test_game_returns_game_object_when_game_id_valid
      stub_request(:get, /boxscoresummaryv2/).to_return(body: game_summary_response.to_json)

      stat = BoxScoreUsageTeamStat.new(game_id: "0022400001")
      result = stat.game

      assert_instance_of Game, result
      assert_equal "0022400001", result.id
    end

    private

    def game_summary_response
      {resultSets: [{name: "GameSummary", headers: %w[GAME_ID GAME_DATE_EST GAME_STATUS_ID HOME_TEAM_ID VISITOR_TEAM_ID ARENA],
                     rowSet: [["0022400001", "2024-10-22", 3, Team::GSW, Team::LAL, "Chase Center"]]}]}
    end
  end
end
