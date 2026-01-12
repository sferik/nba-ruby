require_relative "../../test_helper"

module NBA
  class DefenseHubMissingKeysTest < Minitest::Test
    cover DefenseHub

    def test_all_handles_missing_rank
      response = {resultSets: [{name: "DefenseHubStat1",
                                headers: %w[TEAM_ID TEAM_ABBREVIATION DREB],
                                rowSet: [[Team::BOS, "BOS", 47.8]]}]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      stat = DefenseHub.all(stat_category: :dreb).first

      assert_nil stat.rank
      assert_equal Team::BOS, stat.team_id
    end

    def test_all_handles_missing_team_id
      response = {resultSets: [{name: "DefenseHubStat1",
                                headers: %w[RANK TEAM_ABBREVIATION DREB],
                                rowSet: [[1, "BOS", 47.8]]}]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      stat = DefenseHub.all(stat_category: :dreb).first

      assert_equal 1, stat.rank
      assert_nil stat.team_id
    end

    def test_all_handles_missing_team_abbreviation
      response = {resultSets: [{name: "DefenseHubStat1",
                                headers: %w[RANK TEAM_ID DREB],
                                rowSet: [[1, Team::BOS, 47.8]]}]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      stat = DefenseHub.all(stat_category: :dreb).first

      assert_equal Team::BOS, stat.team_id
      assert_nil stat.team_abbreviation
    end

    def test_all_handles_missing_team_name
      response = {resultSets: [{name: "DefenseHubStat1",
                                headers: %w[RANK TEAM_ID TEAM_ABBREVIATION DREB],
                                rowSet: [[1, Team::BOS, "BOS", 47.8]]}]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      stat = DefenseHub.all(stat_category: :dreb).first

      assert_equal "BOS", stat.team_abbreviation
      assert_nil stat.team_name
    end

    def test_all_handles_missing_value
      response = {resultSets: [{name: "DefenseHubStat1",
                                headers: %w[RANK TEAM_ID TEAM_ABBREVIATION TEAM_NAME],
                                rowSet: [[1, Team::BOS, "BOS", "Boston Celtics"]]}]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      stat = DefenseHub.all(stat_category: :dreb).first

      assert_equal 1, stat.rank
      assert_nil stat.value
    end
  end
end
