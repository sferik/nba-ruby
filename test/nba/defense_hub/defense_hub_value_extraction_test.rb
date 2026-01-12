require_relative "../../test_helper"

module NBA
  class DefenseHubValueExtractionTest < Minitest::Test
    cover DefenseHub

    def test_all_extracts_blk_value
      response = {resultSets: [{name: "DefenseHubStat3",
                                headers: %w[RANK TEAM_ID BLK],
                                rowSet: [[1, Team::BOS, 5.5]]}]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      stat = DefenseHub.all(stat_category: :blk).first

      assert_in_delta 5.5, stat.value
    end

    def test_all_extracts_def_rating_value
      response = {resultSets: [{name: "DefenseHubStat4",
                                headers: %w[RANK TEAM_ID TM_DEF_RATING],
                                rowSet: [[1, Team::BOS, 105.3]]}]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      stat = DefenseHub.all(stat_category: :def_rating).first

      assert_in_delta 105.3, stat.value
    end

    def test_all_extracts_overall_pm_value
      response = {resultSets: [{name: "DefenseHubStat5",
                                headers: %w[RANK TEAM_ID OVERALL_PM],
                                rowSet: [[1, Team::BOS, 3.2]]}]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      stat = DefenseHub.all(stat_category: :overall_pm).first

      assert_in_delta 3.2, stat.value
    end

    def test_all_extracts_threep_dfg_pct_value
      response = {resultSets: [{name: "DefenseHubStat6",
                                headers: %w[RANK TEAM_ID THREEP_DFGPCT],
                                rowSet: [[1, Team::BOS, 0.342]]}]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      stat = DefenseHub.all(stat_category: :threep_dfg_pct).first

      assert_in_delta 0.342, stat.value
    end

    def test_all_extracts_twop_dfg_pct_value
      response = {resultSets: [{name: "DefenseHubStat7",
                                headers: %w[RANK TEAM_ID TWOP_DFGPCT],
                                rowSet: [[1, Team::BOS, 0.485]]}]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      stat = DefenseHub.all(stat_category: :twop_dfg_pct).first

      assert_in_delta 0.485, stat.value
    end

    def test_all_extracts_fifteenf_dfg_pct_value
      response = {resultSets: [{name: "DefenseHubStat8",
                                headers: %w[RANK TEAM_ID FIFETEENF_DFGPCT],
                                rowSet: [[1, Team::BOS, 0.412]]}]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      stat = DefenseHub.all(stat_category: :fifteenf_dfg_pct).first

      assert_in_delta 0.412, stat.value
    end

    def test_all_extracts_def_rim_pct_value
      response = {resultSets: [{name: "DefenseHubStat9",
                                headers: %w[RANK TEAM_ID DEF_RIM_PCT],
                                rowSet: [[1, Team::BOS, 0.582]]}]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      stat = DefenseHub.all(stat_category: :def_rim_pct).first

      assert_in_delta 0.582, stat.value
    end
  end
end
