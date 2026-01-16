require_relative "test_helper"
require_relative "game_formatters_test_helper"

module NBA
  class FormatTeamScoreDisplayTest < Minitest::Test
    include GameFormattersTestHelper

    cover CLI::Formatters::GameFormatters

    def test_away_side_displays_team_before_score
      game = mock_game("Final", "Warriors", "Lakers", 109, 118)
      teams = {home: "Warriors", away: "Lakers"}
      scores = {home: "109", away: "118"}
      result = format_team_score_display(game, :away, teams, scores)

      assert_match(/Lakers.*118/, result)
    end

    def test_home_side_displays_score_before_team
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      teams = {home: "Warriors", away: "Lakers"}
      scores = {home: "118", away: "109"}
      result = format_team_score_display(game, :home, teams, scores)

      assert_match(/118.*Warriors/, result)
    end

    def test_winning_team_is_highlighted_green
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      teams = {home: "Warriors", away: "Lakers"}
      scores = {home: "118", away: "109"}
      result = format_team_score_display(game, :home, teams, scores)

      assert_includes result, "\e[32m"
      assert_includes result, "\e[0m"
    end

    def test_losing_team_is_not_highlighted
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      teams = {home: "Warriors", away: "Lakers"}
      scores = {home: "118", away: "109"}
      result = format_team_score_display(game, :away, teams, scores)

      refute_includes result, "\e[32m"
      refute_includes result, "\e[0m"
    end

    def test_fetches_team_from_teams_hash
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      teams = {home: "Warriors", away: "Lakers"}
      scores = {home: "118", away: "109"}
      result = format_team_score_display(game, :home, teams, scores)

      assert_includes result, "Warriors"
    end

    def test_fetches_score_from_scores_hash
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      teams = {home: "Warriors", away: "Lakers"}
      scores = {home: "118", away: "109"}
      result = format_team_score_display(game, :home, teams, scores)

      assert_includes result, "118"
    end

    def test_uses_eql_for_away_side_check
      game = mock_game("Q4 2:30", "Warriors", "Lakers", 118, 109)
      teams = {home: "Warriors", away: "Lakers"}
      scores = {home: "118", away: "109"}

      home_result = format_team_score_display(game, :home, teams, scores)
      away_result = format_team_score_display(game, :away, teams, scores)

      assert_match(/118\s+Warriors/, home_result)
      assert_match(/Lakers\s+109/, away_result)
    end

    def test_no_highlighting_when_game_not_final
      game = mock_game("Q4 2:30", "Warriors", "Lakers", 118, 109)
      teams = {home: "Warriors", away: "Lakers"}
      scores = {home: "118", away: "109"}
      result = format_team_score_display(game, :home, teams, scores)

      refute_includes result, "\e[32m"
    end
  end
end
