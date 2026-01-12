require_relative "../../test_helper"

module NBA
  class DraftCombineDrillResultsMissingKeysTest < Minitest::Test
    cover DraftCombineDrillResults

    def test_handles_missing_temp_player_id_key
      response = {resultSets: [{name: "Results", headers: headers_without("TEMP_PLAYER_ID"), rowSet: [row_without("TEMP_PLAYER_ID")]}]}
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      result = DraftCombineDrillResults.all(season: 2019).first

      assert_nil result.temp_player_id
    end

    def test_handles_missing_player_id_key
      response = {resultSets: [{name: "Results", headers: headers_without("PLAYER_ID"), rowSet: [row_without("PLAYER_ID")]}]}
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      result = DraftCombineDrillResults.all(season: 2019).first

      assert_nil result.player_id
    end

    def test_handles_missing_first_name_key
      response = {resultSets: [{name: "Results", headers: headers_without("FIRST_NAME"), rowSet: [row_without("FIRST_NAME")]}]}
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      result = DraftCombineDrillResults.all(season: 2019).first

      assert_nil result.first_name
    end

    def test_handles_missing_last_name_key
      response = {resultSets: [{name: "Results", headers: headers_without("LAST_NAME"), rowSet: [row_without("LAST_NAME")]}]}
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      result = DraftCombineDrillResults.all(season: 2019).first

      assert_nil result.last_name
    end

    def test_handles_missing_player_name_key
      response = {resultSets: [{name: "Results", headers: headers_without("PLAYER_NAME"), rowSet: [row_without("PLAYER_NAME")]}]}
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      result = DraftCombineDrillResults.all(season: 2019).first

      assert_nil result.player_name
    end

    def test_handles_missing_position_key
      response = {resultSets: [{name: "Results", headers: headers_without("POSITION"), rowSet: [row_without("POSITION")]}]}
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      result = DraftCombineDrillResults.all(season: 2019).first

      assert_nil result.position
    end

    def test_handles_missing_standing_vertical_leap_key
      response = {resultSets: [{name: "Results", headers: headers_without("STANDING_VERTICAL_LEAP"),
                                rowSet: [row_without("STANDING_VERTICAL_LEAP")]}]}
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      result = DraftCombineDrillResults.all(season: 2019).first

      assert_nil result.standing_vertical_leap
    end

    def test_handles_missing_max_vertical_leap_key
      response = {resultSets: [{name: "Results", headers: headers_without("MAX_VERTICAL_LEAP"),
                                rowSet: [row_without("MAX_VERTICAL_LEAP")]}]}
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      result = DraftCombineDrillResults.all(season: 2019).first

      assert_nil result.max_vertical_leap
    end

    def test_handles_missing_lane_agility_time_key
      response = {resultSets: [{name: "Results", headers: headers_without("LANE_AGILITY_TIME"),
                                rowSet: [row_without("LANE_AGILITY_TIME")]}]}
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      result = DraftCombineDrillResults.all(season: 2019).first

      assert_nil result.lane_agility_time
    end

    def test_handles_missing_modified_lane_agility_time_key
      response = {resultSets: [{name: "Results", headers: headers_without("MODIFIED_LANE_AGILITY_TIME"),
                                rowSet: [row_without("MODIFIED_LANE_AGILITY_TIME")]}]}
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      result = DraftCombineDrillResults.all(season: 2019).first

      assert_nil result.modified_lane_agility_time
    end

    def test_handles_missing_three_quarter_sprint_key
      response = {resultSets: [{name: "Results", headers: headers_without("THREE_QUARTER_SPRINT"),
                                rowSet: [row_without("THREE_QUARTER_SPRINT")]}]}
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      result = DraftCombineDrillResults.all(season: 2019).first

      assert_nil result.three_quarter_sprint
    end

    def test_handles_missing_bench_press_key
      response = {resultSets: [{name: "Results", headers: headers_without("BENCH_PRESS"), rowSet: [row_without("BENCH_PRESS")]}]}
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      result = DraftCombineDrillResults.all(season: 2019).first

      assert_nil result.bench_press
    end

    private

    def headers_without(key)
      full_headers.reject { |h| h.eql?(key) }
    end

    def row_without(key)
      headers_without(key).map do |h|
        full_row[full_headers.index(h)]
      end
    end

    def full_headers
      %w[
        TEMP_PLAYER_ID PLAYER_ID FIRST_NAME LAST_NAME PLAYER_NAME POSITION
        STANDING_VERTICAL_LEAP MAX_VERTICAL_LEAP LANE_AGILITY_TIME
        MODIFIED_LANE_AGILITY_TIME THREE_QUARTER_SPRINT BENCH_PRESS
      ]
    end

    def full_row
      [
        1_630_162, 1_630_162, "Victor", "Wembanyama", "Victor Wembanyama", "C",
        30.5, 37.0, 10.5, 10.2, 3.2, 12
      ]
    end
  end
end
