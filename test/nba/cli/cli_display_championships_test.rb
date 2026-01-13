require_relative "test_helper"

module NBA
  class CLIDisplayChampionshipsTest < Minitest::Test
    include CLITestHelper

    cover CLI::Display

    def test_display_team_championships_shows_years
      run_team_with_stats(championship_stats)

      assert_includes stdout_output, "Championships:"
    end

    def test_display_team_championships_displays_year_values
      stats = Collection.new([
        build_year_stat(year: "2014-15", nba_finals_appearance: "LEAGUE CHAMPION"),
        build_year_stat(year: "2016-17", nba_finals_appearance: "LEAGUE CHAMPION")
      ])
      run_team_with_stats(stats)

      assert_includes stdout_output, "2014-15"
      assert_includes stdout_output, "2016-17"
    end

    def test_display_team_championships_passes_team_to_fetch_stats
      team, captured = run_capturing_stats_team

      assert_equal team, captured
    end

    def test_display_team_championships_skips_when_no_championships
      non_champ = build_year_stat(year: "2018", nba_finals_appearance: "FINALS APPEARANCE")
      run_team_with_stats(Collection.new([non_champ]))

      refute_includes stdout_output, "Championships:"
    end

    def test_display_team_championships_skips_when_stats_empty
      run_team_with_stats(Collection.new([]))

      refute_includes stdout_output, "Championships:"
    end

    private

    def championship_stats
      Collection.new([build_year_stat(year: "2015", nba_finals_appearance: "LEAGUE CHAMPION")])
    end

    def run_team_with_stats(stats)
      run_with_stubs("Test", stats_mock: ->(**_) { stats })
    end

    def run_capturing_stats_team
      captured = nil
      mock = capturing_mock(->(t) { captured = t }, -> { championship_stats })
      run_with_stubs("Stats", stats_mock: mock) { |t| [t, captured] }
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
  end
end
