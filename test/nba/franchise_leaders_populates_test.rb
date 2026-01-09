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

  class FranchiseLeadersPopulatesPtsTest < Minitest::Test
    include FranchiseLeadersPopulatesHelper

    cover FranchiseLeaders

    def setup
      stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)
    end

    def test_populates_team_id
      assert_equal Team::GSW, find_result.team_id
    end

    def test_populates_pts_person_id
      assert_equal 201_939, find_result.pts_person_id
    end

    def test_populates_pts_player_name
      assert_equal "Stephen Curry", find_result.pts_player_name
    end

    def test_populates_pts
      assert_equal 23_668, find_result.pts
    end
  end

  class FranchiseLeadersPopulatesAstTest < Minitest::Test
    include FranchiseLeadersPopulatesHelper

    cover FranchiseLeaders

    def setup
      stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)
    end

    def test_populates_ast_person_id
      assert_equal 201_939, find_result.ast_person_id
    end

    def test_populates_ast_player_name
      assert_equal "Stephen Curry", find_result.ast_player_name
    end

    def test_populates_ast
      assert_equal 5845, find_result.ast
    end
  end

  class FranchiseLeadersPopulatesRebTest < Minitest::Test
    include FranchiseLeadersPopulatesHelper

    cover FranchiseLeaders

    def setup
      stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)
    end

    def test_populates_reb_person_id
      assert_equal 600_015, find_result.reb_person_id
    end

    def test_populates_reb_player_name
      assert_equal "Nate Thurmond", find_result.reb_player_name
    end

    def test_populates_reb
      assert_equal 12_771, find_result.reb
    end
  end

  class FranchiseLeadersPopulatesDefenseTest < Minitest::Test
    include FranchiseLeadersPopulatesHelper

    cover FranchiseLeaders

    def setup
      stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)
    end

    def test_populates_blk_person_id
      assert_equal 2442, find_result.blk_person_id
    end

    def test_populates_blk_player_name
      assert_equal "Manute Bol", find_result.blk_player_name
    end

    def test_populates_blk
      assert_equal 2086, find_result.blk
    end

    def test_populates_stl_person_id
      assert_equal 959, find_result.stl_person_id
    end

    def test_populates_stl_player_name
      assert_equal "Chris Mullin", find_result.stl_player_name
    end

    def test_populates_stl
      assert_equal 1360, find_result.stl
    end

    def test_find_extracts_team_id_from_team_object
      team = Team.new(id: Team::GSW)

      FranchiseLeaders.find(team: team)

      assert_requested :get, /TeamID=#{Team::GSW}/o
    end
  end
end
