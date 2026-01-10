require_relative "../test_helper"

module NBA
  module FranchiseLeadersPopulatesHelper
    LEADER_HEADERS = %w[TEAM_ID PTS_PERSON_ID PTS_PLAYER PTS AST_PERSON_ID AST_PLAYER AST
      REB_PERSON_ID REB_PLAYER REB BLK_PERSON_ID BLK_PLAYER BLK
      STL_PERSON_ID STL_PLAYER STL].freeze

    LEADER_ROW = [Team::GSW, 201_939, "Stephen Curry", 23_668, 201_939, "Stephen Curry", 5845,
      600_015, "Nate Thurmond", 12_771, 2442, "Manute Bol", 2086,
      959, "Chris Mullin", 1360].freeze

    def response
      {resultSets: [{name: "FranchiseLeaders", headers: LEADER_HEADERS, rowSet: [LEADER_ROW]}]}
    end

    def find_result
      FranchiseLeaders.find(team: Team::GSW)
    end
  end
end
