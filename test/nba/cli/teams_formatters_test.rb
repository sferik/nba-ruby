require_relative "test_helper"

module NBA
  class CLITeamsFormattersTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_teams_command_with_nil_detail_returns_nil_conference_and_division
      team = Team.new(full_name: "Test Team", abbreviation: "XXX", year_founded: 2000)
      TeamDetails.stub(:find, ->(_) {}) do
        TeamYearByYearStats.stub(:find, ->(**_) { Collection.new([]) }) do
          Teams.stub(:all, Collection.new([team])) { CLI.start(%w[teams Test]) }
        end
      end

      assert_includes stdout_output, "Conference:"
      assert_includes stdout_output, "Division:"
      assert_includes stdout_output, "Coach:"
    end

    def test_teams_command_with_multiple_players_in_roster
      klay = Player.new(full_name: "Klay Thompson", jersey_number: 11, position: Position.new(abbreviation: "G"))
      stub_team_details(build_team_detail, Collection.new([])) do
        Roster.stub(:find, Collection.new([build_roster_player, klay])) { CLI.start(["teams", "Warriors", "-r"]) }
      end

      assert_includes stdout_output, "Stephen Curry"
      assert_includes stdout_output, "Klay Thompson"
    end

    def test_teams_command_hides_championships_when_na
      stat = build_year_stat(year: "2020-21", nba_finals_appearance: "N/A")
      run_teams_command_with_stubs(%w[teams Warriors], year_stats: Collection.new([stat]))

      refute_includes stdout_output, "Championships"
    end

    def test_teams_command_hides_championships_when_finals_appearance
      stat = build_year_stat(year: "2020-21", nba_finals_appearance: "FINALS APPEARANCE")
      run_teams_command_with_stubs(%w[teams Warriors], year_stats: Collection.new([stat]))

      refute_includes stdout_output, "Championships"
    end

    def test_teams_command_hides_championships_when_nil
      stat = build_year_stat(year: "2020-21", nba_finals_appearance: nil)
      run_teams_command_with_stubs(%w[teams Warriors], year_stats: Collection.new([stat]))

      refute_includes stdout_output, "Championships"
    end

    def test_teams_command_shows_single_championship
      stat = build_year_stat(year: "2021-22", nba_finals_appearance: "LEAGUE CHAMPION")
      run_teams_command_with_stubs(%w[teams Warriors], year_stats: Collection.new([stat]))

      assert_includes stdout_output, "Championships: 2021-22"
    end

    def test_teams_command_shows_multiple_championships
      stats = [
        build_year_stat(year: "2014-15", nba_finals_appearance: "LEAGUE CHAMPION"),
        build_year_stat(year: "2016-17", nba_finals_appearance: "LEAGUE CHAMPION"),
        build_year_stat(year: "2017-18", nba_finals_appearance: "LEAGUE CHAMPION")
      ]
      run_teams_command_with_stubs(%w[teams Warriors], year_stats: Collection.new(stats))
      expected_line = "Championships: 2014-15, 2016-17\n               2017-18"

      assert_includes stdout_output, expected_line
      refute_includes stdout_output, "               2014-15"
    end

    def test_teams_command_handles_unknown_division
      team = Team.new(full_name: "Unknown Team", abbreviation: "UNK", year_founded: 2000)
      run_teams_command_with_stubs(%w[teams Unknown], teams: Collection.new([team]),
        detail: build_team_detail(abbreviation: "UNK"))

      assert_includes stdout_output, "Division:"
    end

    def test_teams_command_handles_year_stats_error
      team = Team.new(full_name: "Test Team", abbreviation: "TST", year_founded: 2000)
      TeamDetails.stub(:find, ->(_) { build_team_detail(abbreviation: "TST") }) do
        TeamYearByYearStats.stub(:find, ->(**_) { raise JSON::ParserError }) do
          Teams.stub(:all, Collection.new([team])) { CLI.start(%w[teams Test]) }
        end
      end

      assert_includes stdout_output, "Name: Test Team"
      refute_includes stdout_output, "Championships"
    end

    def test_teams_command_with_empty_year_stats
      run_teams_command_with_stubs(%w[teams Warriors], year_stats: Collection.new([]))

      refute_includes stdout_output, "Championships"
    end
  end
end
