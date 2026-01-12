require_relative "franchise_leaders_populates_helper"

module NBA
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
