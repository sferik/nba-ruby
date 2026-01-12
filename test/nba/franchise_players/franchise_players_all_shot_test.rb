require_relative "franchise_players_all_helper"

module NBA
  class FranchisePlayersAllShotTest < Minitest::Test
    include FranchisePlayersAllHelper

    cover FranchisePlayers

    def setup
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)
    end

    def test_all_parses_fgm
      assert_in_delta(9.2, find_first.fgm)
    end

    def test_all_parses_fga
      assert_in_delta(19.3, find_first.fga)
    end

    def test_all_parses_fg_pct
      assert_in_delta(0.476, find_first.fg_pct)
    end

    def test_all_parses_fg3m
      assert_in_delta(4.5, find_first.fg3m)
    end

    def test_all_parses_fg3a
      assert_in_delta(11.2, find_first.fg3a)
    end

    def test_all_parses_fg3_pct
      assert_in_delta(0.426, find_first.fg3_pct)
    end

    def test_all_parses_ftm
      assert_in_delta(4.8, find_first.ftm)
    end

    def test_all_parses_fta
      assert_in_delta(5.3, find_first.fta)
    end

    def test_all_parses_ft_pct
      assert_in_delta(0.908, find_first.ft_pct)
    end
  end
end
