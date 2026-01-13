require_relative "test_helper"

module NBA
  class CLIDisplayFetchStatsTest < Minitest::Test
    include CLITestHelper

    cover CLI::Display

    def test_fetch_team_year_stats_returns_empty_on_json_error
      team = Team.new(full_name: "Golden State Warriors", abbreviation: "GSW", year_founded: 1946)
      TeamDetails.stub(:find, ->(_) { build_team_detail }) do
        TeamYearByYearStats.stub(:find, ->(**_) { raise JSON::ParserError }) do
          Teams.stub(:all, Collection.new([team])) { CLI.start(%w[teams GSW]) }
        end
      end

      assert_includes stdout_output, "Golden State Warriors"
    end
  end
end
