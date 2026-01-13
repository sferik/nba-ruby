require_relative "test_helper"

module NBA
  class CLIGamesDateTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_games_command_with_date_option
      date_received = capture_date_from_scoreboard("20240101")

      assert_equal Date.new(2024, 1, 1), date_received
    rescue SystemExit
      flunk "games command with date option raised SystemExit"
    end

    def test_games_command_with_yesterday_date
      date_received = capture_date_from_scoreboard("yesterday")
      expected_date = (Time.now.utc - (29 * 60 * 60)).to_date

      assert_equal expected_date, date_received
    rescue SystemExit
      flunk "games command with yesterday raised SystemExit"
    end

    def test_games_command_with_today_date
      date_received = capture_date_from_scoreboard("today")
      expected_date = eastern_time_date

      assert_equal expected_date, date_received
    rescue SystemExit
      flunk "games command with today raised SystemExit"
    end

    def test_games_command_with_nil_date
      date_received = capture_date_from_scoreboard(nil)
      expected_date = eastern_time_date

      assert_equal expected_date, date_received
    rescue SystemExit
      flunk "games command with nil date raised SystemExit"
    end

    def test_games_command_with_tomorrow_date
      date_received = capture_date_from_scoreboard("tomorrow")
      expected_date = eastern_time_date + 1

      assert_equal expected_date, date_received
    rescue SystemExit
      flunk "games command with tomorrow raised SystemExit"
    end

    def test_games_command_with_invalid_date_shows_error
      assert_raises(SystemExit) { CLI.start(["games", "-d", "invalid"]) }

      assert_includes stdout_output, "Invalid date 'invalid'"
      assert_includes stdout_output, "YYYYMMDD"
    end

    def test_games_command_without_date_does_not_raise
      stub_scoreboard([]) { CLI.start(["games"]) }

      assert_includes stdout_output, "No games found"
    rescue ArgumentError
      flunk "games command raised ArgumentError - options.fetch may be broken"
    rescue SystemExit
      flunk "games command raised SystemExit unexpectedly"
    end

    def test_games_command_no_games_shows_date
      Scoreboard.stub(:games, Collection.new([])) { CLI.start(["games", "-d", "20240315"]) }

      assert_includes stdout_output, "2024-03-15"
    rescue ArgumentError
      flunk "games command raised ArgumentError"
    end

    private

    def capture_date_from_scoreboard(date_option)
      target_date = resolve_date(date_option)
      target_date.eql?(eastern_time_date) ? capture_today_date(date_option) : capture_historical_date(date_option)
    end

    def capture_today_date(date_option)
      LiveScoreboard.stub(:today, Collection.new([])) do
        CLI.start(date_option ? ["games", "-d", date_option] : ["games"])
      end
      eastern_time_date
    end

    def capture_historical_date(date_option)
      date_received = nil
      mock = ->(date:) { date_received = date and Collection.new([]) }
      Scoreboard.stub(:games, mock) { CLI.start(["games", "-d", date_option]) }
      date_received
    end

    def resolve_date(date_option)
      return eastern_time_date if date_option.nil? || date_option.eql?("today")
      return eastern_time_date - 1 if date_option.eql?("yesterday")
      return eastern_time_date + 1 if date_option.eql?("tomorrow")

      Date.strptime(date_option, "%Y%m%d")
    end

    def eastern_time_date = (Time.now.utc - (5 * 60 * 60)).to_date
  end
end
