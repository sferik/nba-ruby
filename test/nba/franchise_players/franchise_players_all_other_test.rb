require_relative "franchise_players_all_helper"

module NBA
  class FranchisePlayersAllOtherTest < Minitest::Test
    include FranchisePlayersAllHelper

    cover FranchisePlayers

    def setup
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)
    end

    def test_all_parses_oreb
      assert_in_delta(0.5, find_first.oreb)
    end

    def test_all_parses_dreb
      assert_in_delta(4.5, find_first.dreb)
    end

    def test_all_parses_reb
      assert_in_delta(5.0, find_first.reb)
    end

    def test_all_parses_ast
      assert_in_delta(6.5, find_first.ast)
    end

    def test_all_parses_pf
      assert_in_delta(2.1, find_first.pf)
    end

    def test_all_parses_stl
      assert_in_delta(1.6, find_first.stl)
    end

    def test_all_parses_tov
      assert_in_delta(3.1, find_first.tov)
    end

    def test_all_parses_blk
      assert_in_delta(0.2, find_first.blk)
    end

    def test_all_parses_pts
      assert_in_delta(24.8, find_first.pts)
    end
  end
end
