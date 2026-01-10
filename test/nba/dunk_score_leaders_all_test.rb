require_relative "../test_helper"

module NBA
  class DunkScoreLeadersAllTest < Minitest::Test
    cover DunkScoreLeaders

    def test_all_returns_collection
      stub_dunk_score_leaders_request

      assert_instance_of Collection, DunkScoreLeaders.all
    end

    def test_all_parses_player_info
      stub_dunk_score_leaders_request

      leader = DunkScoreLeaders.all.first

      assert_equal 1_631_094, leader.player_id
      assert_equal "Paolo Banchero", leader.player_name
      assert_equal Team::ORL, leader.team_id
      assert_equal "ORL", leader.team_abbreviation
    end

    def test_all_parses_rank_and_dunk_score
      stub_dunk_score_leaders_request

      leader = DunkScoreLeaders.all.first

      assert_equal 1, leader.rank
      assert_in_delta 85.5, leader.dunk_score
    end

    private

    def stub_dunk_score_leaders_request
      stub_request(:get, /dunkscoreleaders/).to_return(body: dunk_score_leaders_response.to_json)
    end

    def dunk_score_leaders_response
      {resultSets: [{name: "DunkScoreLeaders",
                     headers: %w[RANK PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION DUNK_SCORE],
                     rowSet: [[1, 1_631_094, "Paolo Banchero", Team::ORL, "ORL", 85.5]]}]}
    end
  end
end
