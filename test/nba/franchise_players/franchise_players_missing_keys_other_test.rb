require_relative "franchise_players_missing_keys_helper"

module NBA
  class FranchisePlayersMissingKeysOtherTest < Minitest::Test
    include FranchisePlayersMissingKeysHelper

    cover FranchisePlayers

    def test_all_handles_missing_oreb
      stub_missing_key("OREB")

      assert_nil find_first.oreb
    end

    def test_all_handles_missing_dreb
      stub_missing_key("DREB")

      assert_nil find_first.dreb
    end

    def test_all_handles_missing_reb
      stub_missing_key("REB")

      assert_nil find_first.reb
    end

    def test_all_handles_missing_ast
      stub_missing_key("AST")

      assert_nil find_first.ast
    end

    def test_all_handles_missing_pf
      stub_missing_key("PF")

      assert_nil find_first.pf
    end

    def test_all_handles_missing_stl
      stub_missing_key("STL")

      assert_nil find_first.stl
    end

    def test_all_handles_missing_tov
      stub_missing_key("TOV")

      assert_nil find_first.tov
    end

    def test_all_handles_missing_blk
      stub_missing_key("BLK")

      assert_nil find_first.blk
    end

    def test_all_handles_missing_pts
      stub_missing_key("PTS")

      assert_nil find_first.pts
    end
  end
end
