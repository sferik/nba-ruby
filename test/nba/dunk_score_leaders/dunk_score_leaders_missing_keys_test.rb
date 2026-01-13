require_relative "../../test_helper"

module NBA
  class DunkScoreLeadersMissingKeysTest < Minitest::Test
    cover DunkScoreLeaders

    def test_handles_missing_player_id_key
      response = {resultSets: [{name: "DunkScoreLeaders",
                                headers: %w[RANK PLAYER_NAME TEAM_ID TEAM_ABBREVIATION DUNK_SCORE],
                                rowSet: [[1, "Paolo Banchero", Team::ORL, "ORL", 85.5]]}]}
      stub_request(:get, /dunkscoreleaders/).to_return(body: response.to_json)

      leader = DunkScoreLeaders.all.first

      assert_nil leader.player_id
    end

    def test_handles_missing_player_name_key
      response = {resultSets: [{name: "DunkScoreLeaders",
                                headers: %w[RANK PLAYER_ID TEAM_ID TEAM_ABBREVIATION DUNK_SCORE],
                                rowSet: [[1, 1_631_094, Team::ORL, "ORL", 85.5]]}]}
      stub_request(:get, /dunkscoreleaders/).to_return(body: response.to_json)

      leader = DunkScoreLeaders.all.first

      assert_nil leader.player_name
    end

    def test_handles_missing_team_id_key
      response = {resultSets: [{name: "DunkScoreLeaders",
                                headers: %w[RANK PLAYER_ID PLAYER_NAME TEAM_ABBREVIATION DUNK_SCORE],
                                rowSet: [[1, 1_631_094, "Paolo Banchero", "ORL", 85.5]]}]}
      stub_request(:get, /dunkscoreleaders/).to_return(body: response.to_json)

      leader = DunkScoreLeaders.all.first

      assert_nil leader.team_id
    end

    def test_handles_missing_team_abbreviation_key
      response = {resultSets: [{name: "DunkScoreLeaders",
                                headers: %w[RANK PLAYER_ID PLAYER_NAME TEAM_ID DUNK_SCORE],
                                rowSet: [[1, 1_631_094, "Paolo Banchero", Team::ORL, 85.5]]}]}
      stub_request(:get, /dunkscoreleaders/).to_return(body: response.to_json)

      leader = DunkScoreLeaders.all.first

      assert_nil leader.team_abbreviation
    end

    def test_handles_missing_rank_key
      response = {resultSets: [{name: "DunkScoreLeaders",
                                headers: %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION DUNK_SCORE],
                                rowSet: [[1_631_094, "Paolo Banchero", Team::ORL, "ORL", 85.5]]}]}
      stub_request(:get, /dunkscoreleaders/).to_return(body: response.to_json)

      leader = DunkScoreLeaders.all.first

      assert_nil leader.rank
    end

    def test_handles_missing_dunk_score_key
      response = {resultSets: [{name: "DunkScoreLeaders",
                                headers: %w[RANK PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION],
                                rowSet: [[1, 1_631_094, "Paolo Banchero", Team::ORL, "ORL"]]}]}
      stub_request(:get, /dunkscoreleaders/).to_return(body: response.to_json)

      leader = DunkScoreLeaders.all.first

      assert_nil leader.dunk_score
    end
  end
end
