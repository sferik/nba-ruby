require_relative "../test_helper"

module NBA
  class LeadersTilesResultSetsTest < Minitest::Test
    cover LeadersTiles

    def test_all_with_last_season_high_result_set
      response = {resultSets: [{name: "LastSeasonHigh",
                                headers: %w[RANK TEAM_ID TEAM_ABBREVIATION TEAM_NAME PTS SEASON_YEAR],
                                rowSet: [[1, Team::DEN, "DEN", "Denver Nuggets", 118.5, "2023-24"]]}]}
      stub_request(:get, /leaderstiles/).to_return(body: response.to_json)

      tile = LeadersTiles.all(result_set: :last_season_high).first

      assert_equal Team::DEN, tile.team_id
      assert_equal "2023-24", tile.season_year
    end

    def test_all_with_low_season_high_result_set
      response = {resultSets: [{name: "LowSeasonHigh",
                                headers: %w[RANK TEAM_ID TEAM_ABBREVIATION TEAM_NAME PTS SEASON_YEAR],
                                rowSet: [[1, Team::MIN, "MIN", "Minnesota Timberwolves", 95.0, "2011-12"]]}]}
      stub_request(:get, /leaderstiles/).to_return(body: response.to_json)

      tile = LeadersTiles.all(result_set: :low_season_high).first

      assert_equal Team::MIN, tile.team_id
      assert_equal "2011-12", tile.season_year
    end
  end
end
