require_relative "../../test_helper"

module NBA
  class AssistLeadersEdgeCasesMissingTest < Minitest::Test
    cover AssistLeaders

    def test_all_handles_missing_player_id
      response = {resultSets: [{name: "AssistLeaders", headers: %w[RANK PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AST],
                                rowSet: [[1, "Russell Westbrook", Team::LAC, "LAC", 654]]}]}
      stub_request(:get, /assistleaders/).to_return(body: response.to_json)

      leader = AssistLeaders.all.first

      assert_nil leader.player_id
      assert_equal "Russell Westbrook", leader.player_name
    end

    def test_all_handles_missing_player_name
      response = {resultSets: [{name: "AssistLeaders", headers: %w[RANK PLAYER_ID TEAM_ID TEAM_ABBREVIATION AST],
                                rowSet: [[1, 201_566, Team::LAC, "LAC", 654]]}]}
      stub_request(:get, /assistleaders/).to_return(body: response.to_json)

      leader = AssistLeaders.all.first

      assert_equal 201_566, leader.player_id
      assert_nil leader.player_name
    end

    def test_all_handles_missing_team_id
      response = {resultSets: [{name: "AssistLeaders", headers: %w[RANK PLAYER_ID PLAYER_NAME TEAM_ABBREVIATION AST],
                                rowSet: [[1, 201_566, "Russell Westbrook", "LAC", 654]]}]}
      stub_request(:get, /assistleaders/).to_return(body: response.to_json)

      leader = AssistLeaders.all.first

      assert_equal 201_566, leader.player_id
      assert_nil leader.team_id
    end

    def test_all_handles_missing_team_abbreviation
      response = {resultSets: [{name: "AssistLeaders", headers: %w[RANK PLAYER_ID PLAYER_NAME TEAM_ID AST],
                                rowSet: [[1, 201_566, "Russell Westbrook", Team::LAC, 654]]}]}
      stub_request(:get, /assistleaders/).to_return(body: response.to_json)

      leader = AssistLeaders.all.first

      assert_equal Team::LAC, leader.team_id
      assert_nil leader.team_abbreviation
    end

    def test_all_handles_missing_rank
      response = {resultSets: [{name: "AssistLeaders", headers: %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AST],
                                rowSet: [[201_566, "Russell Westbrook", Team::LAC, "LAC", 654]]}]}
      stub_request(:get, /assistleaders/).to_return(body: response.to_json)

      leader = AssistLeaders.all.first

      assert_equal 201_566, leader.player_id
      assert_nil leader.rank
    end

    def test_all_handles_missing_ast
      response = {resultSets: [{name: "AssistLeaders", headers: %w[RANK PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION],
                                rowSet: [[1, 201_566, "Russell Westbrook", Team::LAC, "LAC"]]}]}
      stub_request(:get, /assistleaders/).to_return(body: response.to_json)

      leader = AssistLeaders.all.first

      assert_equal 201_566, leader.player_id
      assert_nil leader.ast
    end

    def test_all_selects_correct_result_set_from_multiple
      response = {resultSets: [
        {name: "WrongSet", headers: %w[WRONG_COL], rowSet: [["wrong_data"]]},
        {name: "AssistLeaders", headers: %w[RANK PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AST],
         rowSet: [[1, 201_566, "Russell Westbrook", Team::LAC, "LAC", 654]]}
      ]}
      stub_request(:get, /assistleaders/).to_return(body: response.to_json)

      leader = AssistLeaders.all.first

      assert_equal 201_566, leader.player_id
      assert_equal "Russell Westbrook", leader.player_name
    end

    def test_all_default_league_is_nba
      stub_request(:get, /assistleaders.*LeagueID=00/)
        .to_return(body: {resultSets: [{name: "AssistLeaders", headers: %w[RANK PLAYER_ID], rowSet: [[1, 201_566]]}]}.to_json)

      AssistLeaders.all

      assert_requested :get, /assistleaders.*LeagueID=00/
    end
  end
end
