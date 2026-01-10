require_relative "franchise_leaders_populates_helper"

module NBA
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
end
