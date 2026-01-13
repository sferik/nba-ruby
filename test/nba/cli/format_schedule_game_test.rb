require_relative "test_helper"
require_relative "game_formatters_test_helper"

module NBA
  class FormatScheduleGameTest < Minitest::Test
    include GameFormattersTestHelper

    cover CLI::Formatters::GameFormatters

    def test_returns_date_and_opponent
      game = Struct.new(:game_date, :home_team_tricode, :away_team_tricode)
        .new("2024-01-15T19:30:00", "GSW", "LAL")
      team = Team.new(abbreviation: "GSW")
      result = format_schedule_game(game, team)

      assert_includes result, "2024-01-15"
      assert_includes result, "vs LAL"
    end

    def test_shows_at_for_away_games
      game = Struct.new(:game_date, :home_team_tricode, :away_team_tricode)
        .new("2024-01-15T19:30:00", "LAL", "GSW")
      team = Team.new(abbreviation: "GSW")

      assert_includes format_schedule_game(game, team), "@ LAL"
    end

    def test_handles_nil_date
      game = Struct.new(:game_date, :home_team_tricode, :away_team_tricode)
        .new(nil, "GSW", "LAL")
      team = Team.new(abbreviation: "GSW")

      assert_includes format_schedule_game(game, team), "TBD"
    end

    def test_uses_first_part_of_split_date
      game = Struct.new(:game_date, :home_team_tricode, :away_team_tricode)
        .new("2024-01-15T19:30:00", "GSW", "LAL")
      team = Team.new(abbreviation: "GSW")
      result = format_schedule_game(game, team)

      # Should use first part (date), not last part (time)
      assert_includes result, "2024-01-15"
      refute_includes result, "19:30:00"
    end
  end
end
