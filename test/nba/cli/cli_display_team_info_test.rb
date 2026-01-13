require_relative "test_helper"

module NBA
  class CLIDisplayTeamInfoTest < Minitest::Test
    include CLITestHelper

    cover CLI::Display

    def test_display_team_passes_team_to_team_details_find
      team, captured = run_capturing_team_details_find

      assert_equal team, captured, "TeamDetails.find should be called with the team"
    end

    def test_display_team_passes_team_to_display_team_championships
      team, captured = run_capturing_year_stats_find

      assert_equal team, captured, "TeamYearByYearStats.find should be called with the team"
      assert_includes stdout_output, "Championships:"
    end

    def test_display_team_displays_coach
      team = Team.new(full_name: "Test Team", abbreviation: "TST", year_founded: 2000)
      detail = TeamDetail.new(team_id: 1, abbreviation: "TST", head_coach: "Mike Coach", nickname: "Testers")

      TeamDetails.stub(:find, ->(_) { detail }) do
        TeamYearByYearStats.stub(:find, ->(**_) { Collection.new([]) }) do
          Teams.stub(:all, Collection.new([team])) { CLI.start(%w[teams Test]) }
        end
      end

      assert_includes stdout_output, "Coach:"
      assert_includes stdout_output, "Mike Coach"
    end

    def test_display_team_shows_name_with_label
      team = Team.new(full_name: "Test Team Name", abbreviation: "TST", year_founded: 2000)
      detail = build_team_detail

      TeamDetails.stub(:find, ->(_) { detail }) do
        TeamYearByYearStats.stub(:find, ->(**_) { Collection.new([]) }) do
          Teams.stub(:all, Collection.new([team])) { CLI.start(%w[teams Test]) }
        end
      end

      assert_includes stdout_output, "Name:"
      assert_includes stdout_output, "Test Team Name"
    end

    def test_display_team_shows_founded_year
      team = Team.new(full_name: "Test Team", abbreviation: "TST", year_founded: 1975)
      detail = build_team_detail

      TeamDetails.stub(:find, ->(_) { detail }) do
        TeamYearByYearStats.stub(:find, ->(**_) { Collection.new([]) }) do
          Teams.stub(:all, Collection.new([team])) { CLI.start(%w[teams Test]) }
        end
      end

      assert_includes stdout_output, "Founded:"
      assert_includes stdout_output, "1975"
    end

    private

    def run_capturing_team_details_find
      captured = nil
      mock = capturing_mock(->(t) { captured = t }, -> { build_team_detail })
      run_with_stubs("Test", details_mock: mock) { |t| [t, captured] }
    end

    def run_capturing_year_stats_find
      captured = nil
      mock = capturing_mock(->(t) { captured = t }, -> { champion_stats })
      run_with_stubs("Championship", stats_mock: mock) { |t| [t, captured] }
    end

    def capturing_mock(capture, result)
      ->(team:) { capture.call(team) && result.call }
    end

    def run_with_stubs(name, details_mock: nil, stats_mock: nil)
      team = Team.new(full_name: "#{name} Team", abbreviation: name[0..2].upcase, year_founded: 2000)
      TeamDetails.stub(:find, details_mock || ->(_) { build_team_detail }) do
        TeamYearByYearStats.stub(:find, stats_mock || ->(**_) { Collection.new([]) }) do
          Teams.stub(:all, Collection.new([team])) { CLI.start(["teams", name]) }
        end
      end
      block_given? ? yield(team) : team
    end

    def champion_stats
      Collection.new([build_year_stat(year: "2020", nba_finals_appearance: "LEAGUE CHAMPION")])
    end
  end
end
