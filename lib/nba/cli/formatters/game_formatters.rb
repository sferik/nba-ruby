module NBA
  class CLI < Thor
    module Formatters
      # Formatters for game-related output
      module GameFormatters
        # Formats a game status for display
        #
        # @api private
        # @return [String]
        def format_game_status(game)
          status = game.status
          return "TBD" unless status

          convert_et_to_local(status.strip)
        end

        # Formats a game row for tabular display
        #
        # @api private
        # @return [String]
        def format_game_row(game, widths)
          status = center(format_game_status(game), widths.fetch(:status))
          teams = format_game_teams(game, widths)
          scores = format_game_scores(game, widths)
          away_display = format_team_score_display(game, :away, teams, scores)
          home_display = format_team_score_display(game, :home, teams, scores)
          "#{status} - #{away_display} : #{home_display}".rstrip
        end

        # Formats a team and score with optional winner highlighting
        #
        # @api private
        # @return [String]
        def format_team_score_display(game, side, teams, scores)
          team = teams.fetch(side)
          score = scores.fetch(side)
          display = side.eql?(:away) ? "#{team} #{score}" : "#{score} #{team}"
          winner?(game, side) ? green(display) : display
        end

        # Determines if the given side won the game
        #
        # @api private
        # @return [Boolean]
        def winner?(game, side)
          return false unless final?(game)

          home = game.home_score
          away = game.away_score
          return false unless home && away

          side.eql?(:home) ? home > away : away > home
        end

        # Determines if the game is final
        #
        # @api private
        # @return [Boolean]
        def final?(game)
          game.status&.start_with?("Final") || false
        end

        # Formats game team names with padding
        #
        # @api private
        # @return [Hash]
        def format_game_teams(game, widths)
          {home: center(team_nickname(game.home_team), widths.fetch(:home)),
           away: center(team_nickname(game.away_team), widths.fetch(:away))}
        end

        # Formats game scores with padding
        #
        # @api private
        # @return [Hash]
        def format_game_scores(game, widths)
          {home: rjust(game.home_score || "-", widths.fetch(:home_score)),
           away: rjust(game.away_score || "-", widths.fetch(:away_score))}
        end

        # Calculates column widths for game display
        #
        # @api private
        # @return [Hash]
        def calculate_game_widths(games)
          {status: max_length(games.map { |g| format_game_status(g) }),
           home: max_length(games.map { |g| team_nickname(g.home_team) }),
           away: max_length(games.map { |g| team_nickname(g.away_team) }),
           **score_widths(games)}
        end

        # Calculates score column widths
        #
        # @api private
        # @return [Hash]
        def score_widths(games)
          {home_score: max_length(games.map(&:home_score)),
           away_score: max_length(games.map(&:away_score))}
        end

        # Formats a scheduled game for display
        #
        # @api private
        # @return [String]
        def format_schedule_game(game, team)
          date = game.game_date&.split("T")&.first || "TBD"
          "#{date}: #{determine_opponent(game, team)}"
        end

        # Determines the opponent display string
        #
        # @api private
        # @return [String]
        def determine_opponent(game, team)
          home_game = game.home_team_tricode.eql?(team.abbreviation)
          home_game ? "vs #{game.away_team_tricode}" : "@ #{game.home_team_tricode}"
        end
      end
    end
  end
end
