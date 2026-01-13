require_relative "test_helper"
require_relative "game_formatters_test_helper"

module NBA
  class FormatGameTeamsAndScoresTest < Minitest::Test
    include GameFormattersTestHelper

    cover CLI::Formatters::GameFormatters

    def test_teams_returns_hash_with_home_and_away
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      result = format_game_teams(game, {home: 8, away: 6})

      assert result.key?(:home)
      assert result.key?(:away)
    end

    def test_scores_returns_hash_with_home_and_away
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      result = format_game_scores(game, {home_score: 3, away_score: 3})

      assert result.key?(:home)
      assert result.key?(:away)
    end

    def test_scores_uses_dash_for_nil
      game = mock_game("Scheduled", "Warriors", "Lakers", nil, nil)
      result = format_game_scores(game, {home_score: 1, away_score: 1})

      assert_includes result[:home], "-"
      assert_includes result[:away], "-"
    end
  end
end
