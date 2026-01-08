require_relative "../test_helper"

module NBA
  class TeamDashPtRebReboundInfoTest < Minitest::Test
    cover TeamDashPtReb

    def test_extracts_c_reb
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_in_delta 23.3, result.c_reb
    end

    def test_extracts_c_reb_pct
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_in_delta 0.51, result.c_reb_pct
    end

    def test_extracts_uc_oreb
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_in_delta 5.3, result.uc_oreb
    end

    def test_extracts_uc_dreb
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_in_delta 17.1, result.uc_dreb
    end

    def test_extracts_uc_reb
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_in_delta 22.4, result.uc_reb
    end

    def test_extracts_uc_reb_pct
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_in_delta 0.49, result.uc_reb_pct
    end

    def test_extracts_reb_dist_range
      stub_request(:get, /teamdashptreb/).to_return(body: reb_distance_response.to_json)

      result = TeamDashPtReb.reb_distance(team: 1_610_612_744).first

      assert_equal "0-6 Feet", result.reb_dist_range
    end

    def test_extracts_shot_dist_range
      stub_request(:get, /teamdashptreb/).to_return(body: shot_distance_response.to_json)

      result = TeamDashPtReb.shot_distance(team: 1_610_612_744).first

      assert_equal "0-10 Feet", result.shot_dist_range
    end

    def test_extracts_shot_type_range
      stub_request(:get, /teamdashptreb/).to_return(body: shot_type_response.to_json)

      result = TeamDashPtReb.shot_type(team: 1_610_612_744).first

      assert_equal "2PT FGs", result.shot_type_range
    end

    private

    def response
      {resultSets: [{name: "NumContestedRebounding", headers: headers, rowSet: [row]}]}
    end

    def reb_distance_response
      {resultSets: [{name: "RebDistanceRebounding", headers: reb_distance_headers, rowSet: [reb_distance_row]}]}
    end

    def shot_distance_response
      {resultSets: [{name: "ShotDistanceRebounding", headers: shot_distance_headers, rowSet: [shot_distance_row]}]}
    end

    def shot_type_response
      {resultSets: [{name: "ShotTypeRebounding", headers: shot_type_headers, rowSet: [shot_type_row]}]}
    end

    def headers
      %w[TEAM_ID TEAM_NAME SORT_ORDER G REB_NUM_CONTESTING_RANGE REB_FREQUENCY
        OREB DREB REB C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def reb_distance_headers
      %w[TEAM_ID TEAM_NAME SORT_ORDER G REB_DIST_RANGE REB_FREQUENCY
        OREB DREB REB C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def shot_distance_headers
      %w[TEAM_ID TEAM_NAME SORT_ORDER G SHOT_DIST_RANGE REB_FREQUENCY
        OREB DREB REB C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def shot_type_headers
      %w[TEAM_ID TEAM_NAME SORT_ORDER G SHOT_TYPE_RANGE REB_FREQUENCY
        OREB DREB REB C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", 1, 82, "0 Contests", 0.25,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end

    def reb_distance_row
      [1_610_612_744, "Golden State Warriors", 1, 82, "0-6 Feet", 0.25,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end

    def shot_distance_row
      [1_610_612_744, "Golden State Warriors", 1, 82, "0-10 Feet", 0.25,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end

    def shot_type_row
      [1_610_612_744, "Golden State Warriors", 1, 82, "2PT FGs", 0.25,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end
  end
end
