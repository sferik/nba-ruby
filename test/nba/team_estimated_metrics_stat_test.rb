require_relative "../test_helper"

module NBA
  class TeamEstimatedMetricsStatTest < Minitest::Test
    cover TeamEstimatedMetricsStat

    def test_equality_based_on_team_id
      stat1 = TeamEstimatedMetricsStat.new(team_id: 1_610_612_744)
      stat2 = TeamEstimatedMetricsStat.new(team_id: 1_610_612_744)

      assert_equal stat1, stat2
    end

    def test_inequality_with_different_team_id
      stat1 = TeamEstimatedMetricsStat.new(team_id: 1_610_612_744)
      stat2 = TeamEstimatedMetricsStat.new(team_id: 1_610_612_745)

      refute_equal stat1, stat2
    end

    def test_team_returns_team_object
      stub_request(:get, /commonteamroster/).to_return(body: {resultSets: []}.to_json)
      stat = TeamEstimatedMetricsStat.new(team_id: 1_610_612_744)

      result = stat.team

      assert_instance_of Team, result
    end
  end
end
