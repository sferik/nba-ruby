require_relative "test_helper"

module NBA
  class FetchGamesTest < Minitest::Test
    include CLI::Helpers

    cover CLI::Helpers

    def test_calls_live_scoreboard_for_today
      called = false
      mock = -> { called = true and Collection.new([]) }
      LiveScoreboard.stub(:today, mock) { fetch_games(eastern_time_date) }

      assert called
    end

    def test_calls_scoreboard_for_other_dates
      called = false
      mock = ->(**_) { called = true and Collection.new([]) }
      Scoreboard.stub(:games, mock) { fetch_games(Date.new(2024, 1, 1)) }

      assert called
    end

    def test_does_not_call_scoreboard_for_today
      called = false
      mock = ->(**_) { called = true and Collection.new([]) }
      LiveScoreboard.stub(:today, Collection.new([])) do
        Scoreboard.stub(:games, mock) { fetch_games(eastern_time_date) }
      end

      refute called
    end

    def test_does_not_call_live_scoreboard_for_other_dates
      called = false
      mock = -> { called = true and Collection.new([]) }
      Scoreboard.stub(:games, Collection.new([])) do
        LiveScoreboard.stub(:today, mock) { fetch_games(Date.new(2024, 1, 1)) }
      end

      refute called
    end

    def test_passes_date_to_scoreboard
      received = nil
      mock = ->(date:) { received = date and Collection.new([]) }
      Scoreboard.stub(:games, mock) { fetch_games(Date.new(2024, 3, 15)) }

      assert_equal Date.new(2024, 3, 15), received
    end

    def test_returns_live_scoreboard_result_for_today
      expected = Collection.new([Game.new(id: "live")])
      LiveScoreboard.stub(:today, expected) do
        result = fetch_games(eastern_time_date)

        assert_equal expected, result
      end
    end

    def test_returns_scoreboard_result_for_other_dates
      expected = Collection.new([Game.new(id: "historical")])
      Scoreboard.stub(:games, expected) do
        result = fetch_games(Date.new(2024, 1, 1))

        assert_equal expected, result
      end
    end
  end
end
