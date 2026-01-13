require_relative "test_helper"

module NBA
  class CLIDisplayTeamConferenceTest < Minitest::Test
    include CLITestHelper

    cover CLI::Display

    def test_display_team_conference_with_nil_detail_shows_nil
      team = Team.new(full_name: "Test Team", abbreviation: "TST", year_founded: 2000)
      TeamDetails.stub(:find, ->(_) {}) do
        TeamYearByYearStats.stub(:find, ->(**_) { Collection.new([]) }) do
          Teams.stub(:all, Collection.new([team])) { CLI.start(%w[teams Test]) }
        end
      end

      assert_includes stdout_output, "Conference:"
    end

    def test_display_team_conference_shows_conference_value
      team = Team.new(full_name: "Test Team", abbreviation: "GSW", year_founded: 2000)
      detail = TeamDetail.new(team_id: 1, abbreviation: "GSW", head_coach: "Coach", nickname: "Warriors")

      TeamDetails.stub(:find, ->(_) { detail }) do
        TeamYearByYearStats.stub(:find, ->(**_) { Collection.new([]) }) do
          Teams.stub(:all, Collection.new([team])) { CLI.start(%w[teams Test]) }
        end
      end

      assert_includes stdout_output, "Conference:"
      assert_includes stdout_output, "Western Conference"
    end
  end
end
