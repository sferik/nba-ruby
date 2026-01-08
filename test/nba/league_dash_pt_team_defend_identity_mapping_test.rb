require_relative "../test_helper"

module NBA
  class LeagueDashPtTeamDefendIdentityMappingTest < Minitest::Test
    cover LeagueDashPtTeamDefend

    def test_maps_team_id
      stub_pt_team_defend_request

      stat = LeagueDashPtTeamDefend.all(season: 2024).first

      assert_equal Team::GSW, stat.team_id
    end

    def test_maps_team_name
      stub_pt_team_defend_request

      stat = LeagueDashPtTeamDefend.all(season: 2024).first

      assert_equal "Golden State Warriors", stat.team_name
    end

    def test_maps_team_abbreviation
      stub_pt_team_defend_request

      stat = LeagueDashPtTeamDefend.all(season: 2024).first

      assert_equal "GSW", stat.team_abbreviation
    end

    def test_maps_gp
      stub_pt_team_defend_request

      stat = LeagueDashPtTeamDefend.all(season: 2024).first

      assert_equal 82, stat.gp
    end

    def test_maps_g
      stub_pt_team_defend_request

      stat = LeagueDashPtTeamDefend.all(season: 2024).first

      assert_equal 82, stat.g
    end

    private

    def stub_pt_team_defend_request
      stub_request(:get, /leaguedashptteamdefend/).to_return(body: pt_team_defend_response.to_json)
    end

    def pt_team_defend_response
      {resultSets: [{name: "LeagueDashPtTeamDefend", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION GP G FREQ D_FGM D_FGA D_FG_PCT NORMAL_FG_PCT PCT_PLUSMINUS]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors", "GSW", 82, 82, 0.089,
        245.0, 612.0, 0.400, 0.450, -0.050]
    end
  end
end
