require_relative "franchise_players_missing_keys_helper"

module NBA
  class FranchisePlayersMissingKeysShotTest < Minitest::Test
    include FranchisePlayersMissingKeysHelper

    cover FranchisePlayers

    def test_all_handles_missing_fgm
      stub_missing_key("FGM")

      assert_nil find_first.fgm
    end

    def test_all_handles_missing_fga
      stub_missing_key("FGA")

      assert_nil find_first.fga
    end

    def test_all_handles_missing_fg_pct
      stub_missing_key("FG_PCT")

      assert_nil find_first.fg_pct
    end

    def test_all_handles_missing_fg3m
      stub_missing_key("FG3M")

      assert_nil find_first.fg3m
    end

    def test_all_handles_missing_fg3a
      stub_missing_key("FG3A")

      assert_nil find_first.fg3a
    end

    def test_all_handles_missing_fg3_pct
      stub_missing_key("FG3_PCT")

      assert_nil find_first.fg3_pct
    end

    def test_all_handles_missing_ftm
      stub_missing_key("FTM")

      assert_nil find_first.ftm
    end

    def test_all_handles_missing_fta
      stub_missing_key("FTA")

      assert_nil find_first.fta
    end

    def test_all_handles_missing_ft_pct
      stub_missing_key("FT_PCT")

      assert_nil find_first.ft_pct
    end
  end
end
