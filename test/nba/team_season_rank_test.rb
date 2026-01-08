require_relative "../test_helper"

module NBA
  class TeamSeasonRankTest < Minitest::Test
    cover TeamSeasonRank

    def test_equality_based_on_team_id_and_season_id
      rank1 = TeamSeasonRank.new(team_id: 1_610_612_744, season_id: "2024-25")
      rank2 = TeamSeasonRank.new(team_id: 1_610_612_744, season_id: "2024-25")

      assert_equal rank1, rank2
    end

    def test_inequality_with_different_team_id
      rank1 = TeamSeasonRank.new(team_id: 1_610_612_744, season_id: "2024-25")
      rank2 = TeamSeasonRank.new(team_id: 1_610_612_745, season_id: "2024-25")

      refute_equal rank1, rank2
    end

    def test_inequality_with_different_season_id
      rank1 = TeamSeasonRank.new(team_id: 1_610_612_744, season_id: "2024-25")
      rank2 = TeamSeasonRank.new(team_id: 1_610_612_744, season_id: "2023-24")

      refute_equal rank1, rank2
    end

    def test_team_returns_team_object
      stub_request(:get, /commonteamroster/).to_return(body: {resultSets: []}.to_json)
      rank = TeamSeasonRank.new(team_id: 1_610_612_744)

      result = rank.team

      assert_instance_of Team, result
    end
  end
end
