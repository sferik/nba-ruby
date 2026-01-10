require_relative "franchise_leaders_populates_helper"

module NBA
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
end
