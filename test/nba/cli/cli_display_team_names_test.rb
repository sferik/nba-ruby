require_relative "test_helper"

module NBA
  class CLIDisplayTeamNamesTest < Minitest::Test
    include CLITestHelper

    cover CLI::Display

    def test_display_team_names_sorts_alphabetically
      teams = [
        Team.new(full_name: "Zebra Team"),
        Team.new(full_name: "Alpha Team")
      ]
      Teams.stub(:all, Collection.new(teams)) { CLI.start(["teams"]) }

      alpha_idx = stdout_output.index("Alpha Team")
      zebra_idx = stdout_output.index("Zebra Team")

      assert_operator alpha_idx, :<, zebra_idx, "Alpha should come before Zebra"
    end

    def test_display_team_names_outputs_each_team
      teams = [
        Team.new(full_name: "Team One"),
        Team.new(full_name: "Team Two"),
        Team.new(full_name: "Team Three")
      ]
      Teams.stub(:all, Collection.new(teams)) { CLI.start(["teams"]) }

      teams.each { |team| assert_includes stdout_output, team.full_name }
    end

    def test_display_team_names_sorts_by_full_name_not_object
      teams = %w[Zebra Yankee X-ray Whiskey Victor Uniform Tango Sierra Romeo Quebec]
        .map { |name| Team.new(full_name: "#{name} Team") }
      Teams.stub(:all, Collection.new(teams)) { CLI.start(["teams"]) }

      output_names = stdout_output.split("\n").map(&:strip).reject(&:empty?)
      expected = %w[Quebec Romeo Sierra Tango Uniform Victor Whiskey X-ray Yankee Zebra]
        .map { |name| "#{name} Team" }

      assert_equal expected, output_names, "Should sort by full_name alphabetically"
    end

    def test_display_team_names_handles_nil_full_name
      teams = [
        Team.new(full_name: nil, abbreviation: "TST"),
        Team.new(full_name: "Alpha Team")
      ]
      Teams.stub(:all, Collection.new(teams)) { CLI.start(["teams"]) }

      assert_includes stdout_output, "Alpha Team"
    end

    def test_display_team_names_sorts_by_full_name_string_not_object_to_s
      # Team objects have a to_s that returns class info, not full_name
      # This test ensures we sort by team.full_name.to_s, not team.to_s
      team_a = Team.new(full_name: "Aardvark Team", abbreviation: "AAR")
      team_z = Team.new(full_name: "Zebra Team", abbreviation: "ZEB")

      Teams.stub(:all, Collection.new([team_z, team_a])) { CLI.start(["teams"]) }

      aardvark_idx = stdout_output.index("Aardvark Team")
      zebra_idx = stdout_output.index("Zebra Team")

      assert aardvark_idx, "Aardvark Team should appear in output"
      assert zebra_idx, "Zebra Team should appear in output"
      assert_operator aardvark_idx, :<, zebra_idx, "Aardvark should come before Zebra when sorting by full_name"
    end
  end
end
