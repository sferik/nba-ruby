require_relative "franchise_players_all_helper"

module NBA
  class FranchisePlayersAllIdentityTest < Minitest::Test
    include FranchisePlayersAllHelper

    cover FranchisePlayers

    def setup
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)
    end

    def test_all_parses_league_id
      assert_equal "00", find_first.league_id
    end

    def test_all_parses_team_id
      assert_equal Team::GSW, find_first.team_id
    end

    def test_all_parses_team
      assert_equal "Golden State Warriors", find_first.team
    end

    def test_all_parses_person_id
      assert_equal 201_939, find_first.person_id
    end

    def test_all_parses_player_name
      assert_equal "Stephen Curry", find_first.player
    end

    def test_all_parses_season_type
      assert_equal "Regular Season", find_first.season_type
    end

    def test_all_parses_active_with_team
      assert_equal "Y", find_first.active_with_team
    end

    def test_all_parses_gp
      assert_equal 745, find_first.gp
    end
  end
end
