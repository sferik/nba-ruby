require_relative "../test_helper"

module NBA
  class DraftCombineStatsAthleticAttrTest < Minitest::Test
    cover DraftCombineStats

    def test_parses_standing_vertical_leap
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 32.0, DraftCombineStats.all(season: 2019).first.standing_vertical_leap
    end

    def test_parses_max_vertical_leap
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 40.5, DraftCombineStats.all(season: 2019).first.max_vertical_leap
    end

    def test_parses_lane_agility_time
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 10.75, DraftCombineStats.all(season: 2019).first.lane_agility_time
    end

    def test_parses_modified_lane_agility_time
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 10.5, DraftCombineStats.all(season: 2019).first.modified_lane_agility_time
    end

    def test_parses_three_quarter_sprint
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 3.25, DraftCombineStats.all(season: 2019).first.three_quarter_sprint
    end

    def test_parses_bench_press
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal 15, DraftCombineStats.all(season: 2019).first.bench_press
    end

    private

    def response
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[
        STANDING_VERTICAL_LEAP MAX_VERTICAL_LEAP LANE_AGILITY_TIME
        MODIFIED_LANE_AGILITY_TIME THREE_QUARTER_SPRINT BENCH_PRESS
      ]
    end

    def row
      [32.0, 40.5, 10.75, 10.5, 3.25, 15]
    end
  end
end
