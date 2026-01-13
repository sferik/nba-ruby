require_relative "test_helper"

module NBA
  class CLIPlayerFormattersTest < Minitest::Test
    include CLI::Formatters::PlayerFormatters

    cover CLI::Formatters::PlayerFormatters

    def test_format_detailed_roster_player_with_all_fields
      player = Player.new(full_name: "Stephen Curry", jersey_number: 30,
        position: Position.new(abbreviation: "G"), height: "6-2")
      result = format_detailed_roster_player(player)

      assert_includes result, "#30"
      assert_includes result, "Stephen Curry"
      assert_includes result, "G"
      assert_includes result, "6-2"
    end

    def test_format_detailed_roster_player_jersey_right_justified
      player1 = Player.new(full_name: "Test", jersey_number: 3)
      player2 = Player.new(full_name: "Test", jersey_number: 30)

      result1 = format_detailed_roster_player(player1)
      result2 = format_detailed_roster_player(player2)
      # Jersey 3 should be " 3" (right-justified to 2 chars)
      assert_includes result1, "# 3"
      # Jersey 30 should be "30"
      assert_includes result2, "#30"
    end

    def test_format_detailed_roster_player_nil_jersey_shows_question_mark
      player = Player.new(full_name: "Test Player")

      result = format_detailed_roster_player(player)

      assert_includes result, "# ?"
    end

    def test_format_detailed_roster_player_nil_position_shows_question_mark
      player = Player.new(full_name: "Test Player", jersey_number: 10)

      result = format_detailed_roster_player(player)

      assert_includes result, "?"
    end

    def test_format_detailed_roster_player_nil_height_shows_question_mark
      player = Player.new(
        full_name: "Test Player",
        jersey_number: 10,
        position: Position.new(abbreviation: "G")
      )

      result = format_detailed_roster_player(player)
      # Height should be "?"
      assert result.end_with?("?") || result.include?("?")
    end

    def test_format_detailed_roster_player_name_left_justified
      short_player = Player.new(full_name: "A", jersey_number: 1)
      long_player = Player.new(full_name: "X" * 25, jersey_number: 1)

      short_result = format_detailed_roster_player(short_player)
      long_result = format_detailed_roster_player(long_player)

      # Both should have names padded to 25 chars
      # Short name "A" should have spaces after it
      assert_includes short_result, "A#{" " * 24}"
      # Long name should not be truncated or extended
      assert_includes long_result, "X" * 25
    end

    def test_format_detailed_roster_player_name_width_exact
      # Use a name that when padded to 25 chars creates a known boundary
      player = Player.new(
        full_name: "A",
        jersey_number: 1,
        position: Position.new(abbreviation: "G"),
        height: "6-0"
      )

      result = format_detailed_roster_player(player)

      # The name field should be exactly 25 characters (A + 24 spaces)
      # followed by a space, then position
      # If width were 24: "A" + 23 spaces = only 24 chars before position
      # If width were 26: "A" + 25 spaces = 26 chars before position
      assert_includes result, "A#{" " * 24} G"
      refute_includes result, "A#{" " * 23} G"
      refute_includes result, "A#{" " * 25} G"
    end

    def test_format_detailed_roster_player_position_left_justified
      player = Player.new(
        full_name: "Test",
        jersey_number: 1,
        position: Position.new(abbreviation: "G"),
        height: "6-0"
      )

      result = format_detailed_roster_player(player)
      # Position "G" should be padded to 3 chars then followed by a space
      # "G".ljust(3) => "G  ", then " " before height = "G   6-0"
      assert_match(/G\s{3}6-0/, result)
      # Verify it's not 2 or 4 spaces
      refute_match(/G\s{2}6-0/, result)
      refute_match(/G\s{4}6-0/, result)
    end

    def test_format_player_result_active_player
      player = Struct.new(:full_name, :active?).new("LeBron James", true)

      result = format_player_result(player)

      assert_equal "LeBron James (Active)", result
    end

    def test_format_player_result_inactive_player
      player = Struct.new(:full_name, :active?).new("Michael Jordan", false)

      result = format_player_result(player)

      assert_equal "Michael Jordan (Inactive)", result
    end

    def test_format_draft_info
      player = Struct.new(:draft_year, :draft_round, :draft_number).new(2009, 1, 1)

      result = format_draft_info(player)

      assert_equal "2009 Round 1, Pick 1", result
    end

    def test_format_draft_info_second_round
      player = Struct.new(:draft_year, :draft_round, :draft_number).new(2015, 2, 35)

      result = format_draft_info(player)

      assert_equal "2015 Round 2, Pick 35", result
    end

    def test_format_detailed_roster_player_nil_full_name_shows_unknown
      # Kills mutations: removing || "Unknown" or replacing with || nil
      player = Player.new(full_name: nil, jersey_number: 10, position: Position.new(abbreviation: "G"))
      result = format_detailed_roster_player(player)

      assert_includes result, "Unknown"
      refute_match(/nil/, result)
    end
  end
end
