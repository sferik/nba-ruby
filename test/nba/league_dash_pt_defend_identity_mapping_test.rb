require_relative "../test_helper"

module NBA
  class LeagueDashPtDefendIdentityMappingTest < Minitest::Test
    cover LeagueDashPtDefend

    def test_maps_player_id
      stub_pt_defend_request

      stat = LeagueDashPtDefend.all(season: 2024).first

      assert_equal 201_939, stat.player_id
    end

    def test_maps_player_name
      stub_pt_defend_request

      stat = LeagueDashPtDefend.all(season: 2024).first

      assert_equal "Stephen Curry", stat.player_name
    end

    def test_maps_team_id
      stub_pt_defend_request

      stat = LeagueDashPtDefend.all(season: 2024).first

      assert_equal Team::GSW, stat.team_id
    end

    def test_maps_team_abbreviation
      stub_pt_defend_request

      stat = LeagueDashPtDefend.all(season: 2024).first

      assert_equal "GSW", stat.team_abbreviation
    end

    def test_maps_player_position
      stub_pt_defend_request

      stat = LeagueDashPtDefend.all(season: 2024).first

      assert_equal "G", stat.player_position
    end

    def test_maps_age
      stub_pt_defend_request

      stat = LeagueDashPtDefend.all(season: 2024).first

      assert_in_delta 36.0, stat.age
    end

    def test_maps_gp
      stub_pt_defend_request

      stat = LeagueDashPtDefend.all(season: 2024).first

      assert_equal 82, stat.gp
    end

    def test_maps_g
      stub_pt_defend_request

      stat = LeagueDashPtDefend.all(season: 2024).first

      assert_equal 82, stat.g
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
