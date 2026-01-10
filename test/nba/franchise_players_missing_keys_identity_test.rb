require_relative "franchise_players_missing_keys_helper"

module NBA
  class FranchisePlayersMissingKeysIdentityTest < Minitest::Test
    include FranchisePlayersMissingKeysHelper

    cover FranchisePlayers

    def test_all_handles_missing_league_id
      stub_missing_key("LEAGUE_ID")

      assert_nil find_first.league_id
    end

    def test_all_handles_missing_team_id
      stub_missing_key("TEAM_ID")

      assert_nil find_first.team_id
    end

    def test_all_handles_missing_team
      stub_missing_key("TEAM")

      assert_nil find_first.team
    end

    def test_all_handles_missing_person_id
      stub_missing_key("PERSON_ID")

      assert_nil find_first.person_id
    end

    def test_all_handles_missing_player
      stub_missing_key("PLAYER")

      assert_nil find_first.player
    end

    def test_all_handles_missing_season_type
      stub_missing_key("SEASON_TYPE")

      assert_nil find_first.season_type
    end

    def test_all_handles_missing_active_with_team
      stub_missing_key("ACTIVE_WITH_TEAM")

      assert_nil find_first.active_with_team
    end

    def test_all_handles_missing_gp
      stub_missing_key("GP")

      assert_nil find_first.gp
    end
  end
end
