require_relative "test_helper"

module NBA
  class CLIPlayerEdgeCasesTest < Minitest::Test
    include CLITestHelper

    cover CLI
    cover CLI::Display::PlayerDisplay

    def test_player_command_shows_undrafted_for_nil_draft_year
      player = Player.new(id: 1, full_name: "Test Player", is_active: true, draft_year: nil, draft_round: 1, draft_number: 1)
      stub_player_search([player], player) { CLI.start(%w[player Test]) }

      assert_includes stdout_output, "Draft: Undrafted"
      refute_includes stdout_output, "Round"
    end

    def test_player_command_shows_nil_weight
      player = Player.new(id: 1, full_name: "Test Player", is_active: true, weight: nil)
      stub_player_search([player], player) { CLI.start(%w[player Test]) }

      assert_includes stdout_output, "Weight:"
      refute_includes stdout_output, "lbs"
    end

    def test_player_command_shows_nil_position
      player = Player.new(id: 1, full_name: "Test Player", is_active: true, position: nil)
      stub_player_search([player], player) { CLI.start(%w[player Test]) }

      assert_includes stdout_output, "Position:"
    end

    def test_player_command_calls_players_find_with_matched_player
      search_player, find_called_with = build_search_player_pair
      stub_players_find(search_player, find_called_with) { CLI.start(%w[player Test]) }

      assert_equal search_player, find_called_with.value
    end

    def test_player_command_shows_not_found_when_find_returns_nil
      player = Player.new(id: 1, full_name: "Test Player", is_active: true)
      Players.stub(:all, Collection.new([player])) do
        Players.stub(:find, ->(_) {}) { CLI.start(%w[player Test]) }
      end

      assert_includes stdout_output, "Player not found"
    end

    private

    def build_search_player_pair
      search = Player.new(id: 123, full_name: "Test Player", is_active: true)
      capture = Struct.new(:value).new
      [search, capture]
    end

    def stub_players_find(search_player, capture, &block)
      detail = Player.new(id: 123, full_name: "Test Player", is_active: true, height: "6-5")
      Players.stub(:all, Collection.new([search_player])) do
        Players.stub(:find, lambda { |arg|
          capture.value = arg
          detail
        }, &block)
      end
    end

    def stub_player_search(players, detail, &block)
      Players.stub(:all, Collection.new(players)) do
        Players.stub(:find, ->(_) { detail }, &block)
      end
    end
  end
end
