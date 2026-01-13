require_relative "../../test_helper"

module NBA
  module CLITestHelper
    def setup
      @captured_stdout = StringIO.new
      @captured_stderr = StringIO.new
      @original_stdout = $stdout
      @original_stderr = $stderr
      $stdout = @captured_stdout
      $stderr = @captured_stderr
    end

    def teardown
      restore_io
    end

    # Catches SystemExit/ArgumentError to prevent Thor from crashing test process during mutation testing
    def run
      super
    rescue SystemExit, ArgumentError => e
      restore_io
      failures << Minitest::UnexpectedError.new(e)
      self
    end

    def stdout_output
      $stdout = @original_stdout
      @captured_stdout.string
    end

    def stderr_output
      $stderr = @original_stderr
      @captured_stderr.string
    end

    private

    def restore_io
      $stdout = @original_stdout
      $stderr = @original_stderr
    end

    public

    def build_test_player(height: "6-2")
      Player.new(full_name: "Stephen Curry", jersey_number: 30, position: Position.new(abbreviation: "G"), height: height)
    end

    def build_roster_player = build_test_player(height: nil)

    def build_schedule_game(date, home, away)
      Struct.new(:game_date, :home_team_tricode, :away_team_tricode).new(date, home, away)
    end

    def build_away_schedule_game(date, home) = build_schedule_game(date, home, "GSW")

    def build_schedule_games(count)
      count.times.map { |i| build_schedule_game("2024-01-#{(i + 1).to_s.rjust(2, "0")}T19:30:00", "GSW", "LAL") }
    end

    def gsw_team_and_teams
      team = Team.new(full_name: "Golden State Warriors", abbreviation: "GSW")
      [team, Collection.new([team])]
    end

    def with_mock_teams(&)
      _, teams = gsw_team_and_teams
      Teams.stub(:all, teams, &)
    end

    def run_schedule_command(args, games)
      with_mock_teams { Schedule.stub(:by_team, Collection.new(games)) { CLI.start(args) } }
    end

    def run_schedule_command_with_method(args, mock_method)
      with_mock_teams { Schedule.stub(:by_team, mock_method) { CLI.start(args) } }
    end

    def run_roster_command_with_method(args, mock_method)
      with_mock_teams { Roster.stub(:find, mock_method) { CLI.start(args) } }
    end

    def build_game(home_team:, away_team:, status:, home_score: nil, away_score: nil, arena: nil)
      Game.new(
        id: "0022400001",
        home_team: home_team,
        away_team: away_team,
        home_score: home_score,
        away_score: away_score,
        status: status,
        arena: arena
      )
    end

    def build_team_detail(abbreviation: "GSW", head_coach: "Steve Kerr")
      TeamDetail.new(team_id: 1_610_612_744, abbreviation: abbreviation, head_coach: head_coach, nickname: "Warriors")
    end

    def stub_team_details(detail = nil, year_stats = nil, &block)
      detail ||= build_team_detail
      year_stats ||= Collection.new([])
      TeamDetails.stub(:find, ->(_) { detail }) do
        TeamYearByYearStats.stub(:find, ->(**_) { year_stats }, &block)
      end
    end

    def run_teams_command_with_stubs(args, teams: nil, detail: nil, year_stats: nil)
      teams ||= Teams.all
      stub_team_details(detail, year_stats) do
        Teams.stub(:all, teams) { CLI.start(args) }
      end
    end

    def build_year_stat(year:, nba_finals_appearance:)
      TeamYearStat.new(year: year, nba_finals_appearance: nba_finals_appearance)
    end

    def gsw = Team.new(full_name: "Golden State Warriors", nickname: "Warriors")

    def lal = Team.new(full_name: "Los Angeles Lakers", nickname: "Lakers")

    def stub_scoreboard(games, &) = LiveScoreboard.stub(:today, Collection.new(games), &)
  end
end
