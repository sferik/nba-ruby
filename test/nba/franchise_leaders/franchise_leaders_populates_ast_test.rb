require_relative "franchise_leaders_populates_helper"

module NBA
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
end
