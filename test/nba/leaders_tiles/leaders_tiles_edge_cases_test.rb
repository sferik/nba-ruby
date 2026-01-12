require_relative "../../test_helper"

module NBA
  class LeadersTilesEdgeCasesTest < Minitest::Test
    cover LeadersTiles

    def test_all_handles_nil_response
      stub_request(:get, /leaderstiles/).to_return(body: nil)

      result = LeadersTiles.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_result_sets
      stub_request(:get, /leaderstiles/).to_return(body: {resultSets: []}.to_json)

      result = LeadersTiles.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_result_set
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /leaderstiles/).to_return(body: response.to_json)

      result = LeadersTiles.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_row_set
      response = {resultSets: [{name: "LeadersTiles", headers: %w[RANK TEAM_ID], rowSet: []}]}
      stub_request(:get, /leaderstiles/).to_return(body: response.to_json)

      result = LeadersTiles.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_raises_key_error_for_invalid_result_set
      assert_raises(KeyError) { LeadersTiles.all(result_set: :invalid) }
    end

    def test_all_handles_missing_rank
      response = {resultSets: [{name: "LeadersTiles",
                                headers: %w[TEAM_ID TEAM_ABBREVIATION PTS],
                                rowSet: [[Team::BOS, "BOS", 120.5]]}]}
      stub_request(:get, /leaderstiles/).to_return(body: response.to_json)

      tile = LeadersTiles.all.first

      assert_nil tile.rank
      assert_equal Team::BOS, tile.team_id
    end

    def test_all_handles_missing_pts
      response = {resultSets: [{name: "LeadersTiles",
                                headers: %w[RANK TEAM_ID TEAM_ABBREVIATION TEAM_NAME],
                                rowSet: [[1, Team::BOS, "BOS", "Boston Celtics"]]}]}
      stub_request(:get, /leaderstiles/).to_return(body: response.to_json)

      tile = LeadersTiles.all.first

      assert_equal 1, tile.rank
      assert_nil tile.pts
    end

    def test_all_handles_missing_season_year
      response = {resultSets: [{name: "AllTimeSeasonHigh",
                                headers: %w[TEAM_ID TEAM_ABBREVIATION TEAM_NAME PTS],
                                rowSet: [[Team::CHI, "CHI", "Chicago Bulls", 131.5]]}]}
      stub_request(:get, /leaderstiles/).to_return(body: response.to_json)

      tile = LeadersTiles.all(result_set: :all_time_high).first

      assert_in_delta 131.5, tile.pts
      assert_nil tile.season_year
    end

    def test_all_handles_missing_team_id
      response = {resultSets: [{name: "LeadersTiles",
                                headers: %w[RANK TEAM_ABBREVIATION TEAM_NAME PTS],
                                rowSet: [[1, "BOS", "Boston Celtics", 120.5]]}]}
      stub_request(:get, /leaderstiles/).to_return(body: response.to_json)

      tile = LeadersTiles.all.first

      assert_nil tile.team_id
      assert_equal "BOS", tile.team_abbreviation
    end

    def test_all_handles_missing_team_abbreviation
      response = {resultSets: [{name: "LeadersTiles",
                                headers: %w[RANK TEAM_ID TEAM_NAME PTS],
                                rowSet: [[1, Team::BOS, "Boston Celtics", 120.5]]}]}
      stub_request(:get, /leaderstiles/).to_return(body: response.to_json)

      tile = LeadersTiles.all.first

      assert_nil tile.team_abbreviation
      assert_equal Team::BOS, tile.team_id
    end

    def test_all_handles_missing_team_name
      response = {resultSets: [{name: "LeadersTiles",
                                headers: %w[RANK TEAM_ID TEAM_ABBREVIATION PTS],
                                rowSet: [[1, Team::BOS, "BOS", 120.5]]}]}
      stub_request(:get, /leaderstiles/).to_return(body: response.to_json)

      tile = LeadersTiles.all.first

      assert_nil tile.team_name
      assert_equal "BOS", tile.team_abbreviation
    end

    def test_all_selects_correct_result_set_from_multiple
      response = {resultSets: [
        {name: "WrongSet", headers: %w[WRONG_COL], rowSet: [["wrong_data"]]},
        {name: "LeadersTiles", headers: %w[RANK TEAM_ID TEAM_ABBREVIATION TEAM_NAME PTS],
         rowSet: [[1, Team::LAL, "LAL", "Los Angeles Lakers", 115.5]]}
      ]}
      stub_request(:get, /leaderstiles/).to_return(body: response.to_json)

      tile = LeadersTiles.all.first

      assert_equal 1, tile.rank
      assert_equal Team::LAL, tile.team_id
      assert_in_delta 115.5, tile.pts
    end
  end
end
