require_relative "test_helper"

module NBA
  class CLIPlayerTest < Minitest::Test
    include CLITestHelper

    cover CLI
    cover CLI::Display::PlayerDisplay

    def test_player_command_with_single_match_shows_details
      player = build_detailed_player
      stub_player_search([player], player) { CLI.start(%w[player Curry]) }

      assert_player_details_displayed
    end

    def test_player_command_with_inactive_player
      player = Player.new(id: 1, full_name: "Kobe Bryant", is_active: false, height: "6-6")
      stub_player_search([player], player) { CLI.start(%w[player Bryant]) }

      assert_includes stdout_output, "Name: Kobe Bryant"
      assert_includes stdout_output, "Status: Inactive"
    end

    def test_player_command_with_no_match
      stub_players([build_detailed_player]) { CLI.start(%w[player NonExistentPlayer]) }

      assert_includes stdout_output, "No player found"
      assert_includes stdout_output, "NonExistentPlayer"
    end

    def test_player_command_no_match_returns_early
      # Verifies that no match returns early without calling display methods
      stub_players([build_detailed_player]) { CLI.start(%w[player NonExistentPlayer]) }

      # Should only show error message, not "Found X player(s)" from display_players
      refute_includes stdout_output, "Found"
    end

    def test_player_command_matches_player_with_nil_full_name
      # Player with nil full_name should not cause error during matching
      player_with_nil = Player.new(id: 1, full_name: nil, is_active: true)
      player_with_name = build_detailed_player
      stub_player_search([player_with_nil, player_with_name], player_with_name) { CLI.start(%w[player Curry]) }

      assert_includes stdout_output, "Name: Stephen Curry"
    end

    def test_player_command_case_insensitive
      player = build_detailed_player
      stub_player_search([player], player) { CLI.start(%w[player curry]) }

      assert_includes stdout_output, "Name: Stephen Curry"
    end

    def test_player_command_partial_match
      player = build_detailed_player
      stub_player_search([player], player) { CLI.start(%w[player Steph]) }

      assert_includes stdout_output, "Name: Stephen Curry"
    end

    def test_player_command_with_multiple_matches_shows_search_results
      curry = Player.new(full_name: "Stephen Curry", is_active: true)
      seth = Player.new(full_name: "Seth Curry", is_active: true)
      stub_players([curry, seth]) { CLI.start(%w[player Curry]) }

      assert_includes stdout_output, "Stephen Curry (Active)"
      assert_includes stdout_output, "Seth Curry (Active)"
      assert_includes stdout_output, "Found 2 player"
    end

    def test_player_command_with_multiple_matches_shows_inactive_status
      active = Player.new(full_name: "Michael Jordan", is_active: true)
      inactive = Player.new(full_name: "Marcus Jordan", is_active: false)
      stub_players([active, inactive]) { CLI.start(%w[player Jordan]) }

      assert_includes stdout_output, "Michael Jordan (Active)"
      assert_includes stdout_output, "Marcus Jordan (Inactive)"
    end

    private

    def build_detailed_player
      Player.new(id: 201_939, full_name: "Stephen Curry", is_active: true, height: "6-2", weight: 185,
        country: "USA", college: "Davidson", draft_year: 2009, draft_round: 1, draft_number: 7,
        position: Position.new(name: "Guard"))
    end

    def assert_player_details_displayed
      assert_includes stdout_output, "Name: Stephen Curry"
      assert_includes stdout_output, "Status: Active"
      assert_includes stdout_output, "Position: Guard"
      assert_includes stdout_output, "Height: 6-2"
      assert_includes stdout_output, "Weight: 185 lbs"
      assert_includes stdout_output, "Country: USA"
      assert_includes stdout_output, "College: Davidson"
      assert_includes stdout_output, "Draft: 2009 Round 1, Pick 7"
    end

    def stub_players(players, &)
      Players.stub(:all, Collection.new(players), &)
    end

    def stub_player_search(players, detail, &block)
      Players.stub(:all, Collection.new(players)) do
        Players.stub(:find, ->(_) { detail }, &block)
      end
    end
  end
end
