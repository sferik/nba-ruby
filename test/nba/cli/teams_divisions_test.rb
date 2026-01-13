require_relative "test_helper"

module NBA
  class CLITeamsDivisionsTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_teams_command_shows_eastern_conference
      team = Team.new(full_name: "Boston Celtics", abbreviation: "BOS", year_founded: 1946)
      run_teams_command_with_stubs(%w[teams Celtics], teams: Collection.new([team]),
        detail: build_team_detail(abbreviation: "BOS"))

      assert_includes stdout_output, "Conference: Eastern Conference"
      assert_includes stdout_output, "Division: Atlantic Division"
    end

    def test_teams_command_with_nil_abbreviation_defaults_to_western
      team = Team.new(full_name: "Test Team", abbreviation: nil, year_founded: 2000)
      detail = TeamDetail.new(team_id: 1, abbreviation: nil, head_coach: "Test Coach")
      run_teams_command_with_stubs(%w[teams Test], teams: Collection.new([team]), detail: detail)

      assert_includes stdout_output, "Conference: Western Conference"
    end

    def test_teams_command_shows_central_division
      team = Team.new(full_name: "Chicago Bulls", abbreviation: "CHI", year_founded: 1966)
      run_teams_command_with_stubs(%w[teams Bulls], teams: Collection.new([team]),
        detail: build_team_detail(abbreviation: "CHI"))

      assert_includes stdout_output, "Division: Central Division"
    end

    def test_teams_command_shows_southeast_division
      team = Team.new(full_name: "Atlanta Hawks", abbreviation: "ATL", year_founded: 1946)
      run_teams_command_with_stubs(%w[teams Hawks], teams: Collection.new([team]),
        detail: build_team_detail(abbreviation: "ATL"))

      assert_includes stdout_output, "Division: Southeast Division"
    end

    def test_teams_command_shows_northwest_division
      team = Team.new(full_name: "Denver Nuggets", abbreviation: "DEN", year_founded: 1967)
      run_teams_command_with_stubs(%w[teams Nuggets], teams: Collection.new([team]),
        detail: build_team_detail(abbreviation: "DEN"))

      assert_includes stdout_output, "Division: Northwest Division"
    end

    def test_teams_command_shows_southwest_division
      team = Team.new(full_name: "Dallas Mavericks", abbreviation: "DAL", year_founded: 1980)
      run_teams_command_with_stubs(%w[teams Mavericks], teams: Collection.new([team]),
        detail: build_team_detail(abbreviation: "DAL"))

      assert_includes stdout_output, "Division: Southwest Division"
    end
  end
end
