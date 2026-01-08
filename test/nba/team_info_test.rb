require_relative "../test_helper"

module NBA
  class TeamInfoTest < Minitest::Test
    cover TeamInfo

    def test_equality_based_on_team_id_and_season_year
      info1 = TeamInfo.new(team_id: 1_610_612_744, season_year: "2024-25")
      info2 = TeamInfo.new(team_id: 1_610_612_744, season_year: "2024-25")

      assert_equal info1, info2
    end

    def test_inequality_with_different_team_id
      info1 = TeamInfo.new(team_id: 1_610_612_744, season_year: "2024-25")
      info2 = TeamInfo.new(team_id: 1_610_612_745, season_year: "2024-25")

      refute_equal info1, info2
    end

    def test_inequality_with_different_season_year
      info1 = TeamInfo.new(team_id: 1_610_612_744, season_year: "2024-25")
      info2 = TeamInfo.new(team_id: 1_610_612_744, season_year: "2023-24")

      refute_equal info1, info2
    end

    def test_team_returns_team_object
      stub_request(:get, /commonteamroster/).to_return(body: {resultSets: []}.to_json)
      info = TeamInfo.new(team_id: 1_610_612_744)

      result = info.team

      assert_instance_of Team, result
    end
  end
end
