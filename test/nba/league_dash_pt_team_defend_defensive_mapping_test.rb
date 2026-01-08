require_relative "../test_helper"

module NBA
  class LeagueDashPtTeamDefendDefensiveMappingTest < Minitest::Test
    cover LeagueDashPtTeamDefend

    def test_maps_freq
      stub_pt_team_defend_request

      stat = LeagueDashPtTeamDefend.all(season: 2024).first

      assert_in_delta 0.089, stat.freq
    end

    def test_maps_d_fgm
      stub_pt_team_defend_request

      stat = LeagueDashPtTeamDefend.all(season: 2024).first

      assert_in_delta 245.0, stat.d_fgm
    end

    def test_maps_d_fga
      stub_pt_team_defend_request

      stat = LeagueDashPtTeamDefend.all(season: 2024).first

      assert_in_delta 612.0, stat.d_fga
    end

    def test_maps_d_fg_pct
      stub_pt_team_defend_request

      stat = LeagueDashPtTeamDefend.all(season: 2024).first

      assert_in_delta 0.400, stat.d_fg_pct
    end

    def test_maps_normal_fg_pct
      stub_pt_team_defend_request

      stat = LeagueDashPtTeamDefend.all(season: 2024).first

      assert_in_delta 0.450, stat.normal_fg_pct
    end

    def test_maps_pct_plusminus
      stub_pt_team_defend_request

      stat = LeagueDashPtTeamDefend.all(season: 2024).first

      assert_in_delta(-0.050, stat.pct_plusminus)
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
