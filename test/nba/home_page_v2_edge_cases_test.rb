require_relative "../test_helper"

module NBA
  class HomePageV2EdgeCasesTest < Minitest::Test
    cover HomePageV2

    def test_all_handles_nil_response
      stub_request(:get, /homepagev2/).to_return(body: nil)

      result = HomePageV2.all(stat_category: :pts)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_result_sets
      stub_request(:get, /homepagev2/).to_return(body: {resultSets: []}.to_json)

      result = HomePageV2.all(stat_category: :pts)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_result_set
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /homepagev2/).to_return(body: response.to_json)

      result = HomePageV2.all(stat_category: :pts)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_row_set
      response = {resultSets: [{name: "HomePageStat1", headers: %w[RANK TEAM_ID], rowSet: []}]}
      stub_request(:get, /homepagev2/).to_return(body: response.to_json)

      result = HomePageV2.all(stat_category: :pts)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_raises_key_error_for_invalid_stat_category
      assert_raises(KeyError) { HomePageV2.all(stat_category: :invalid) }
    end

    def test_all_handles_missing_rank
      response = {resultSets: [{name: "HomePageStat1",
                                headers: %w[TEAM_ID TEAM_ABBREVIATION PTS],
                                rowSet: [[Team::BOS, "BOS", 120.5]]}]}
      stub_request(:get, /homepagev2/).to_return(body: response.to_json)

      stat = HomePageV2.all(stat_category: :pts).first

      assert_nil stat.rank
      assert_equal Team::BOS, stat.team_id
    end

    def test_all_handles_missing_value
      response = {resultSets: [{name: "HomePageStat1",
                                headers: %w[RANK TEAM_ID TEAM_ABBREVIATION TEAM_NAME],
                                rowSet: [[1, Team::BOS, "BOS", "Boston Celtics"]]}]}
      stub_request(:get, /homepagev2/).to_return(body: response.to_json)

      stat = HomePageV2.all(stat_category: :pts).first

      assert_equal 1, stat.rank
      assert_nil stat.value
    end

    def test_all_handles_missing_team_id
      response = {resultSets: [{name: "HomePageStat1",
                                headers: %w[RANK TEAM_ABBREVIATION TEAM_NAME PTS],
                                rowSet: [[1, "BOS", "Boston Celtics", 120.5]]}]}
      stub_request(:get, /homepagev2/).to_return(body: response.to_json)

      stat = HomePageV2.all(stat_category: :pts).first

      assert_nil stat.team_id
      assert_equal "BOS", stat.team_abbreviation
    end

    def test_all_handles_missing_team_abbreviation
      response = {resultSets: [{name: "HomePageStat1",
                                headers: %w[RANK TEAM_ID TEAM_NAME PTS],
                                rowSet: [[1, Team::BOS, "Boston Celtics", 120.5]]}]}
      stub_request(:get, /homepagev2/).to_return(body: response.to_json)

      stat = HomePageV2.all(stat_category: :pts).first

      assert_nil stat.team_abbreviation
      assert_equal Team::BOS, stat.team_id
    end

    def test_all_handles_missing_team_name
      response = {resultSets: [{name: "HomePageStat1",
                                headers: %w[RANK TEAM_ID TEAM_ABBREVIATION PTS],
                                rowSet: [[1, Team::BOS, "BOS", 120.5]]}]}
      stub_request(:get, /homepagev2/).to_return(body: response.to_json)

      stat = HomePageV2.all(stat_category: :pts).first

      assert_nil stat.team_name
      assert_equal "BOS", stat.team_abbreviation
    end

    def test_all_selects_correct_result_set_from_multiple
      response = {resultSets: [
        {name: "WrongSet", headers: %w[WRONG_COL], rowSet: [["wrong_data"]]},
        {name: "HomePageStat3", headers: %w[RANK TEAM_ID TEAM_ABBREVIATION AST],
         rowSet: [[1, Team::LAL, "LAL", 30.5]]}
      ]}
      stub_request(:get, /homepagev2/).to_return(body: response.to_json)

      stat = HomePageV2.all(stat_category: :ast).first

      assert_equal 1, stat.rank
      assert_equal Team::LAL, stat.team_id
      assert_in_delta 30.5, stat.value
    end
  end
end
