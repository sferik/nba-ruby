require_relative "../../test_helper"

module NBA
  class LeagueDashPtTeamDefendDefaultParamsTest < Minitest::Test
    cover LeagueDashPtTeamDefend

    def test_default_season_uses_current_season
      current_season_str = Utils.format_season(Utils.current_season)
      stub = stub_request(:get, /Season=#{current_season_str}/)
        .to_return(body: pt_team_defend_response.to_json)

      LeagueDashPtTeamDefend.all

      assert_requested stub
    end

    def test_default_season_type_is_regular_season
      stub = stub_request(:get, /SeasonType=Regular%20Season/)
        .to_return(body: pt_team_defend_response.to_json)

      LeagueDashPtTeamDefend.all(season: 2024)

      assert_requested stub
    end

    def test_default_per_mode_is_per_game
      stub = stub_request(:get, /PerMode=PerGame/)
        .to_return(body: pt_team_defend_response.to_json)

      LeagueDashPtTeamDefend.all(season: 2024)

      assert_requested stub
    end

    def test_default_defense_category_is_overall
      stub = stub_request(:get, /DefenseCategory=Overall/)
        .to_return(body: pt_team_defend_response.to_json)

      LeagueDashPtTeamDefend.all(season: 2024)

      assert_requested stub
    end

    private

    def pt_team_defend_response
      {resultSets: [{name: "LeagueDashPtTeamDefend", headers: %w[TEAM_ID], rowSet: [[Team::GSW]]}]}
    end
  end
end
