require_relative "../../test_helper"

module NBA
  class TeamDashPtRebValuesTest < Minitest::Test
    cover TeamDashPtReb

    def test_extracts_team_id
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_equal 1_610_612_744, result.team_id
    end

    def test_extracts_team_name
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_equal "Golden State Warriors", result.team_name
    end

    def test_extracts_sort_order
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_equal 1, result.sort_order
    end

    def test_extracts_g
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_equal 82, result.g
    end

    def test_extracts_reb_num_contesting_range
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_equal "0 Contests", result.reb_num_contesting_range
    end

    def test_extracts_overall
      stub_request(:get, /teamdashptreb/).to_return(body: overall_response.to_json)

      result = TeamDashPtReb.overall(team: 1_610_612_744).first

      assert_equal "Overall", result.overall
    end

    def test_extracts_reb_frequency
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_in_delta 0.25, result.reb_frequency
    end

    def test_extracts_oreb
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_in_delta 10.5, result.oreb
    end

    def test_extracts_dreb
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_in_delta 35.2, result.dreb
    end

    def test_extracts_reb
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_in_delta 45.7, result.reb
    end

    def test_extracts_c_oreb
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_in_delta 5.2, result.c_oreb
    end

    def test_extracts_c_dreb
      stub_request(:get, /teamdashptreb/).to_return(body: response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_in_delta 18.1, result.c_dreb
    end

    private

    def response
      {resultSets: [{name: "NumContestedRebounding", headers: headers, rowSet: [row]}]}
    end

    def overall_response
      {resultSets: [{name: "OverallRebounding", headers: overall_headers, rowSet: [overall_row]}]}
    end

    def headers
      %w[TEAM_ID TEAM_NAME SORT_ORDER G REB_NUM_CONTESTING_RANGE REB_FREQUENCY
        OREB DREB REB C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def overall_headers
      %w[TEAM_ID TEAM_NAME G OVERALL REB_FREQUENCY OREB DREB REB
        C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", 1, 82, "0 Contests", 0.25,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end

    def overall_row
      [1_610_612_744, "Golden State Warriors", 82, "Overall", 1.0,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end
  end
end
