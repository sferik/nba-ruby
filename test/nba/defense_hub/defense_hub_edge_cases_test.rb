require_relative "../../test_helper"

module NBA
  class DefenseHubEdgeCasesTest < Minitest::Test
    cover DefenseHub

    def test_all_handles_nil_response
      stub_request(:get, /defensehub/).to_return(body: nil)

      result = DefenseHub.all(stat_category: :dreb)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_result_sets
      stub_request(:get, /defensehub/).to_return(body: {resultSets: []}.to_json)

      result = DefenseHub.all(stat_category: :dreb)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_result_set
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      result = DefenseHub.all(stat_category: :dreb)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_row_set
      response = {resultSets: [{name: "DefenseHubStat1", headers: %w[RANK TEAM_ID], rowSet: []}]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      result = DefenseHub.all(stat_category: :dreb)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_raises_key_error_for_invalid_stat_category
      assert_raises(KeyError) { DefenseHub.all(stat_category: :invalid) }
    end

    def test_all_selects_correct_result_set_from_multiple
      response = {resultSets: [
        {name: "WrongSet", headers: %w[WRONG_COL], rowSet: [["wrong_data"]]},
        {name: "DefenseHubStat1", headers: %w[RANK TEAM_ID TEAM_ABBREVIATION TEAM_NAME DREB],
         rowSet: [[1, Team::BOS, "BOS", "Boston Celtics", 47.8]]}
      ]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      stat = DefenseHub.all(stat_category: :dreb).first

      assert_equal 1, stat.rank
      assert_equal "Boston Celtics", stat.team_name
    end

    def test_all_default_league_is_nba
      stub_request(:get, /defensehub.*LeagueID=00/)
        .to_return(body: {resultSets: [{name: "DefenseHubStat1", headers: %w[RANK], rowSet: [[1]]}]}.to_json)

      DefenseHub.all(stat_category: :dreb)

      assert_requested :get, /defensehub.*LeagueID=00/
    end

    def test_all_default_season_type_is_regular_season
      stub_request(:get, /defensehub.*SeasonType=Regular%20Season/)
        .to_return(body: {resultSets: [{name: "DefenseHubStat1", headers: %w[RANK], rowSet: [[1]]}]}.to_json)

      DefenseHub.all(stat_category: :dreb)

      assert_requested :get, /defensehub.*SeasonType=Regular%20Season/
    end

    def test_all_default_game_scope_is_season
      stub_request(:get, /defensehub.*GameScope=Season/)
        .to_return(body: {resultSets: [{name: "DefenseHubStat1", headers: %w[RANK], rowSet: [[1]]}]}.to_json)

      DefenseHub.all(stat_category: :dreb)

      assert_requested :get, /defensehub.*GameScope=Season/
    end

    def test_all_default_player_or_team_is_team
      stub_request(:get, /defensehub.*PlayerOrTeam=Team/)
        .to_return(body: {resultSets: [{name: "DefenseHubStat1", headers: %w[RANK], rowSet: [[1]]}]}.to_json)

      DefenseHub.all(stat_category: :dreb)

      assert_requested :get, /defensehub.*PlayerOrTeam=Team/
    end

    def test_all_default_player_scope_is_all_players
      stub_request(:get, /defensehub.*PlayerScope=All%20Players/)
        .to_return(body: {resultSets: [{name: "DefenseHubStat1", headers: %w[RANK], rowSet: [[1]]}]}.to_json)

      DefenseHub.all(stat_category: :dreb)

      assert_requested :get, /defensehub.*PlayerScope=All%20Players/
    end

    def test_all_stat_name_converts_symbol_to_string
      response = {resultSets: [{name: "DefenseHubStat1",
                                headers: %w[RANK TEAM_ID TEAM_ABBREVIATION TEAM_NAME DREB],
                                rowSet: [[1, Team::BOS, "BOS", "Boston Celtics", 47.8]]}]}
      stub_request(:get, /defensehub/).to_return(body: response.to_json)

      stat = DefenseHub.all(stat_category: :dreb).first

      assert_instance_of String, stat.stat_name
      assert_equal "dreb", stat.stat_name
    end
  end
end
