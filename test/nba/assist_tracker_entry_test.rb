require_relative "../test_helper"

module NBA
  class AssistTrackerEntryTest < Minitest::Test
    cover AssistTrackerEntry

    def test_player_id_attribute
      entry = AssistTrackerEntry.new(player_id: 201_566)

      assert_equal 201_566, entry.player_id
    end

    def test_player_name_attribute
      entry = AssistTrackerEntry.new(player_name: "Russell Westbrook")

      assert_equal "Russell Westbrook", entry.player_name
    end

    def test_team_id_attribute
      entry = AssistTrackerEntry.new(team_id: Team::LAC)

      assert_equal Team::LAC, entry.team_id
    end

    def test_team_abbreviation_attribute
      entry = AssistTrackerEntry.new(team_abbreviation: "LAC")

      assert_equal "LAC", entry.team_abbreviation
    end

    def test_pass_to_attribute
      entry = AssistTrackerEntry.new(pass_to: "Kawhi Leonard")

      assert_equal "Kawhi Leonard", entry.pass_to
    end

    def test_pass_to_player_id_attribute
      entry = AssistTrackerEntry.new(pass_to_player_id: 202_695)

      assert_equal 202_695, entry.pass_to_player_id
    end

    def test_frequency_attribute
      entry = AssistTrackerEntry.new(frequency: 0.123)

      assert_in_delta 0.123, entry.frequency
    end

    def test_pass_attribute
      entry = AssistTrackerEntry.new(pass: 45)

      assert_equal 45, entry.pass
    end

    def test_ast_attribute
      entry = AssistTrackerEntry.new(ast: 32)

      assert_equal 32, entry.ast
    end

    def test_fg_m_attribute
      entry = AssistTrackerEntry.new(fg_m: 28)

      assert_equal 28, entry.fg_m
    end

    def test_fg_a_attribute
      entry = AssistTrackerEntry.new(fg_a: 45)

      assert_equal 45, entry.fg_a
    end

    def test_fg_pct_attribute
      entry = AssistTrackerEntry.new(fg_pct: 0.622)

      assert_in_delta 0.622, entry.fg_pct
    end

    def test_fg2m_attribute
      entry = AssistTrackerEntry.new(fg2m: 20)

      assert_equal 20, entry.fg2m
    end

    def test_fg2a_attribute
      entry = AssistTrackerEntry.new(fg2a: 30)

      assert_equal 30, entry.fg2a
    end

    def test_fg2_pct_attribute
      entry = AssistTrackerEntry.new(fg2_pct: 0.667)

      assert_in_delta 0.667, entry.fg2_pct
    end

    def test_fg3m_attribute
      entry = AssistTrackerEntry.new(fg3m: 8)

      assert_equal 8, entry.fg3m
    end

    def test_fg3a_attribute
      entry = AssistTrackerEntry.new(fg3a: 15)

      assert_equal 15, entry.fg3a
    end

    def test_fg3_pct_attribute
      entry = AssistTrackerEntry.new(fg3_pct: 0.533)

      assert_in_delta 0.533, entry.fg3_pct
    end

    def test_equality_based_on_player_id_and_pass_to
      entry1 = AssistTrackerEntry.new(player_id: 201_566, pass_to: "Kawhi Leonard")
      entry2 = AssistTrackerEntry.new(player_id: 201_566, pass_to: "Kawhi Leonard")

      assert_equal entry1, entry2
    end

    def test_inequality_when_different_player_id
      entry1 = AssistTrackerEntry.new(player_id: 201_566, pass_to: "Kawhi Leonard")
      entry2 = AssistTrackerEntry.new(player_id: 201_939, pass_to: "Kawhi Leonard")

      refute_equal entry1, entry2
    end

    def test_inequality_when_different_pass_to
      entry1 = AssistTrackerEntry.new(player_id: 201_566, pass_to: "Kawhi Leonard")
      entry2 = AssistTrackerEntry.new(player_id: 201_566, pass_to: "Paul George")

      refute_equal entry1, entry2
    end
  end
end
