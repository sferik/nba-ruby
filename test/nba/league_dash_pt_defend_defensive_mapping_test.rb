require_relative "../test_helper"

module NBA
  class LeagueDashPtDefendDefensiveMappingTest < Minitest::Test
    cover LeagueDashPtDefend

    def test_maps_freq
      stub_pt_defend_request

      stat = LeagueDashPtDefend.all(season: 2024).first

      assert_in_delta 0.089, stat.freq
    end

    def test_maps_d_fgm
      stub_pt_defend_request

      stat = LeagueDashPtDefend.all(season: 2024).first

      assert_in_delta 245.0, stat.d_fgm
    end

    def test_maps_d_fga
      stub_pt_defend_request

      stat = LeagueDashPtDefend.all(season: 2024).first

      assert_in_delta 612.0, stat.d_fga
    end

    def test_maps_d_fg_pct
      stub_pt_defend_request

      stat = LeagueDashPtDefend.all(season: 2024).first

      assert_in_delta 0.400, stat.d_fg_pct
    end

    def test_maps_normal_fg_pct
      stub_pt_defend_request

      stat = LeagueDashPtDefend.all(season: 2024).first

      assert_in_delta 0.450, stat.normal_fg_pct
    end

    def test_maps_pct_plusminus
      stub_pt_defend_request

      stat = LeagueDashPtDefend.all(season: 2024).first

      assert_in_delta(-0.050, stat.pct_plusminus)
    end

    private

    def stub_pt_defend_request
      stub_request(:get, /leaguedashptdefend/).to_return(body: pt_defend_response.to_json)
    end

    def pt_defend_response
      {resultSets: [{name: "LeagueDashPTDefend", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[CLOSE_DEF_PERSON_ID PLAYER_NAME PLAYER_LAST_TEAM_ID PLAYER_LAST_TEAM_ABBREVIATION
        PLAYER_POSITION AGE GP G FREQ D_FGM D_FGA D_FG_PCT NORMAL_FG_PCT PCT_PLUSMINUS]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", "G", 36.0, 82, 82, 0.089,
        245.0, 612.0, 0.400, 0.450, -0.050]
    end
  end
end
