require_relative "../../test_helper"

module NBA
  class DraftCombineDrillResultsDrillAttrTest < Minitest::Test
    cover DraftCombineDrillResults

    def test_parses_standing_vertical_leap
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_in_delta(30.5, DraftCombineDrillResults.all(season: 2019).first.standing_vertical_leap)
    end

    def test_parses_max_vertical_leap
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_in_delta(37.0, DraftCombineDrillResults.all(season: 2019).first.max_vertical_leap)
    end

    def test_parses_lane_agility_time
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_in_delta(10.5, DraftCombineDrillResults.all(season: 2019).first.lane_agility_time)
    end

    def test_parses_modified_lane_agility_time
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_in_delta(10.2, DraftCombineDrillResults.all(season: 2019).first.modified_lane_agility_time)
    end

    def test_parses_three_quarter_sprint
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_in_delta(3.2, DraftCombineDrillResults.all(season: 2019).first.three_quarter_sprint)
    end

    def test_parses_bench_press
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_equal 12, DraftCombineDrillResults.all(season: 2019).first.bench_press
    end

    private

    def response
      headers = %w[STANDING_VERTICAL_LEAP MAX_VERTICAL_LEAP LANE_AGILITY_TIME
        MODIFIED_LANE_AGILITY_TIME THREE_QUARTER_SPRINT BENCH_PRESS]
      row = [30.5, 37.0, 10.5, 10.2, 3.2, 12]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end
end
