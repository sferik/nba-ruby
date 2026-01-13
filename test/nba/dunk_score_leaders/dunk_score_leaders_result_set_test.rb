require_relative "../../test_helper"

module NBA
  class DunkScoreLeadersResultSetTest < Minitest::Test
    cover DunkScoreLeaders

    def test_all_selects_correct_result_set_when_multiple_present
      response = {resultSets: [
        {name: "OtherSet", headers: %w[FOO], rowSet: [["bar"]]},
        {name: "DunkScoreLeaders", headers: %w[RANK PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION DUNK_SCORE],
         rowSet: [[1, 1_631_094, "Paolo Banchero", Team::ORL, "ORL", 85.5]]}
      ]}
      stub_request(:get, /dunkscoreleaders/).to_return(body: response.to_json)

      leader = DunkScoreLeaders.all.first

      assert_equal "Paolo Banchero", leader.player_name
    end
  end
end
