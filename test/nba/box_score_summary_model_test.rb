require_relative "../test_helper"

module NBA
  class BoxScoreSummaryModelTest < Minitest::Test
    cover BoxScoreSummary

    def test_objects_with_same_game_id_are_equal
      summary0 = BoxScoreSummary.new(game_id: "0022400001")
      summary1 = BoxScoreSummary.new(game_id: "0022400001")

      assert_equal summary0, summary1
    end

    def test_objects_with_different_game_id_are_not_equal
      summary0 = BoxScoreSummary.new(game_id: "0022400001")
      summary1 = BoxScoreSummary.new(game_id: "0022400002")

      refute_equal summary0, summary1
    end

    def test_home_team_returns_nil_when_home_team_id_is_nil
      summary = BoxScoreSummary.new(home_team_id: nil)

      assert_nil summary.home_team
    end

    def test_visitor_team_returns_nil_when_visitor_team_id_is_nil
      summary = BoxScoreSummary.new(visitor_team_id: nil)

      assert_nil summary.visitor_team
    end

    def test_game_returns_nil_when_game_id_is_nil
      summary = BoxScoreSummary.new(game_id: nil)

      assert_nil summary.game
    end

    def test_home_team_returns_team_object_when_home_team_id_valid
      summary = BoxScoreSummary.new(home_team_id: Team::GSW)

      result = summary.home_team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end

    def test_visitor_team_returns_team_object_when_visitor_team_id_valid
      summary = BoxScoreSummary.new(visitor_team_id: 1_610_612_747)

      result = summary.visitor_team

      assert_instance_of Team, result
      assert_equal 1_610_612_747, result.id
    end

    def test_game_returns_game_object_when_game_id_valid
      stub_request(:get, /boxscoresummaryv2/).to_return(body: game_response.to_json)

      summary = BoxScoreSummary.new(game_id: "0022400001")
      result = summary.game

      assert_instance_of Game, result
      assert_equal "0022400001", result.id
    end

    def test_final_returns_true_when_game_status_id_is_final
      summary = BoxScoreSummary.new(game_status_id: 3)

      assert_predicate summary, :final?
    end

    def test_final_returns_false_when_game_status_id_is_not_final
      summary = BoxScoreSummary.new(game_status_id: 2)

      refute_predicate summary, :final?
    end

    def test_in_progress_returns_true_when_game_status_id_is_in_progress
      summary = BoxScoreSummary.new(game_status_id: 2)

      assert_predicate summary, :in_progress?
    end

    def test_in_progress_returns_false_when_game_status_id_is_not_in_progress
      summary = BoxScoreSummary.new(game_status_id: 3)

      refute_predicate summary, :in_progress?
    end

    def test_scheduled_returns_true_when_game_status_id_is_scheduled
      summary = BoxScoreSummary.new(game_status_id: 1)

      assert_predicate summary, :scheduled?
    end

    def test_scheduled_returns_false_when_game_status_id_is_not_scheduled
      summary = BoxScoreSummary.new(game_status_id: 3)

      refute_predicate summary, :scheduled?
    end

    private

    def game_response
      headers = %w[GAME_DATE_EST GAME_SEQUENCE GAME_ID GAME_STATUS_ID GAME_STATUS_TEXT HOME_TEAM_ID VISITOR_TEAM_ID ARENA]
      row = ["2024-10-22", 1, "0022400001", 3, "Final", Team::GSW, Team::LAL, "Chase Center"]
      {resultSets: [{name: "GameSummary", headers: headers, rowSet: [row]}]}
    end
  end
end
