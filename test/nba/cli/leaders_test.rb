require_relative "test_helper"

module NBA
  class CLILeadersTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_leaders_command_formats_rank_with_proper_width
      # Create leaders with different rank lengths (1 vs 10) to test width calculation
      leader1 = build_leader(rank: 1, player_name: "Short", value: 10.0)
      leader2 = build_leader(rank: 10, player_name: "LongerPlayerName", value: 9.0)
      stub_leaders([leader1, leader2]) { CLI.start(["leaders"]) }
      lines = stdout_output.lines

      # Rank 1 should be right-justified to match width of 10 (2 chars)
      rank_1_line = lines.find { |l| l.include?("Short") }
      rank_10_line = lines.find { |l| l.include?("LongerPlayerName") }
      # Rank 1 should have leading space, rank 10 should not
      assert_match(/^\s+1\.\s/, rank_1_line, "Rank 1 should be right-justified")
      assert_match(/^10\.\s/, rank_10_line, "Rank 10 should start at beginning")
    end

    def test_leaders_command_formats_name_with_proper_width
      # Create leaders with different name lengths to test width calculation
      leader1 = build_leader(rank: 1, player_name: "A", value: 10.0)
      leader2 = build_leader(rank: 2, player_name: "VeryLongPlayerName", value: 9.0)
      stub_leaders([leader1, leader2]) { CLI.start(["leaders"]) }
      output = stdout_output

      # Name A should be left-justified (followed by spaces) to match width of VeryLongPlayerName
      # Output format: "1. A                  10.0"
      assert_match(/1\. A\s+10\.0/, output, "Name A should be followed by padding to align with longer name")
    end

    private

    def stub_leaders(leaders, &)
      Leaders.stub(:find, Collection.new(leaders), &)
    end

    def build_leader(rank:, player_name:, value:)
      Struct.new(:rank, :player_name, :value).new(rank, player_name, value)
    end
  end
end
