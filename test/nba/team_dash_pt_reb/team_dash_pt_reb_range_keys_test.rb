require_relative "../../test_helper"

module NBA
  class TeamDashPtRebRangeKeysTest < Minitest::Test
    cover TeamDashPtReb

    def test_handles_missing_overall_key
      stub_request(:get, /teamdashptreb/).to_return(body: overall_response_missing_key("OVERALL").to_json)
      result = TeamDashPtReb.overall(team: 1_610_612_744).first

      assert_nil result.overall
    end

    def test_handles_missing_reb_dist_range_key
      stub_request(:get, /teamdashptreb/).to_return(body: reb_dist_response_missing_key("REB_DIST_RANGE").to_json)
      result = TeamDashPtReb.reb_distance(team: 1_610_612_744).first

      assert_nil result.reb_dist_range
    end

    def test_handles_missing_shot_dist_range_key
      stub_request(:get, /teamdashptreb/).to_return(body: shot_dist_response_missing_key("SHOT_DIST_RANGE").to_json)
      result = TeamDashPtReb.shot_distance(team: 1_610_612_744).first

      assert_nil result.shot_dist_range
    end

    def test_handles_missing_shot_type_range_key
      stub_request(:get, /teamdashptreb/).to_return(body: shot_type_response_missing_key("SHOT_TYPE_RANGE").to_json)
      result = TeamDashPtReb.shot_type(team: 1_610_612_744).first

      assert_nil result.shot_type_range
    end

    private

    def overall_response_missing_key(key)
      hdrs = overall_headers.reject { |h| h == key }
      rw = overall_row.each_with_index.reject { |_, i| overall_headers[i] == key }.map(&:first)
      {resultSets: [{name: "OverallRebounding", headers: hdrs, rowSet: [rw]}]}
    end

    def reb_dist_response_missing_key(key)
      hdrs = reb_dist_headers.reject { |h| h == key }
      rw = reb_dist_row.each_with_index.reject { |_, i| reb_dist_headers[i] == key }.map(&:first)
      {resultSets: [{name: "RebDistanceRebounding", headers: hdrs, rowSet: [rw]}]}
    end

    def shot_dist_response_missing_key(key)
      hdrs = shot_dist_headers.reject { |h| h == key }
      rw = shot_dist_row.each_with_index.reject { |_, i| shot_dist_headers[i] == key }.map(&:first)
      {resultSets: [{name: "ShotDistanceRebounding", headers: hdrs, rowSet: [rw]}]}
    end

    def shot_type_response_missing_key(key)
      hdrs = shot_type_headers.reject { |h| h == key }
      rw = shot_type_row.each_with_index.reject { |_, i| shot_type_headers[i] == key }.map(&:first)
      {resultSets: [{name: "ShotTypeRebounding", headers: hdrs, rowSet: [rw]}]}
    end

    def overall_headers
      %w[TEAM_ID TEAM_NAME G OVERALL REB_FREQUENCY OREB DREB REB
        C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def reb_dist_headers
      %w[TEAM_ID TEAM_NAME SORT_ORDER G REB_DIST_RANGE REB_FREQUENCY
        OREB DREB REB C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def shot_dist_headers
      %w[TEAM_ID TEAM_NAME SORT_ORDER G SHOT_DIST_RANGE REB_FREQUENCY
        OREB DREB REB C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def shot_type_headers
      %w[TEAM_ID TEAM_NAME SORT_ORDER G SHOT_TYPE_RANGE REB_FREQUENCY
        OREB DREB REB C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def overall_row
      [1_610_612_744, "Golden State Warriors", 82, "Overall", 1.0,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end

    def reb_dist_row
      [1_610_612_744, "Golden State Warriors", 1, 82, "0-6 Feet", 0.25,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end

    def shot_dist_row
      [1_610_612_744, "Golden State Warriors", 1, 82, "0-10 Feet", 0.25,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end

    def shot_type_row
      [1_610_612_744, "Golden State Warriors", 1, 82, "2PT FGs", 0.25,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end
  end
end
