module NBA
  class CLI < Thor
    module Formatters
      # Formatters for standings-related output
      module StandingsFormatters
        # Formats a standing row for tabular display
        #
        # @api private
        # @return [String]
        def format_standing_row(standing, rank, widths)
          rank_str = rank.to_s.rjust(widths.fetch(:rank))
          team = standing.team_name.ljust(widths.fetch(:team))
          "#{rank_str}. #{team} #{standing.wins}-#{standing.losses}"
        end

        # Calculates column widths for standings display
        #
        # @api private
        # @return [Hash]
        def calculate_standings_widths(standings)
          {rank: standings.size.to_s.length, team: max_length(standings.map(&:team_name))}
        end
      end
    end
  end
end
