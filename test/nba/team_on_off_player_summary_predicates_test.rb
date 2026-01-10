require_relative "../test_helper"

module NBA
  class TeamOnOffPlayerSummaryPredicatesTest < Minitest::Test
    cover TeamOnOffPlayerSummary

    def test_on_court_returns_true_when_court_status_is_on
      summary = TeamOnOffPlayerSummary.new(court_status: "On")

      assert_predicate summary, :on_court?
    end

    def test_on_court_returns_false_when_court_status_is_off
      summary = TeamOnOffPlayerSummary.new(court_status: "Off")

      refute_predicate summary, :on_court?
    end

    def test_off_court_returns_true_when_court_status_is_off
      summary = TeamOnOffPlayerSummary.new(court_status: "Off")

      assert_predicate summary, :off_court?
    end

    def test_off_court_returns_false_when_court_status_is_on
      summary = TeamOnOffPlayerSummary.new(court_status: "On")

      refute_predicate summary, :off_court?
    end
  end
end
