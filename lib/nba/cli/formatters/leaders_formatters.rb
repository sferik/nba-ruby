module NBA
  class CLI < Thor
    module Formatters
      # Formatters for leaders-related output
      module LeadersFormatters
        # Formats a leader row for tabular display
        #
        # @api private
        # @return [String]
        def format_leader_row(leader, widths)
          rank = leader.rank.to_s.rjust(widths.fetch(:rank))
          name = leader.player_name.ljust(widths.fetch(:name))
          "#{rank}. #{name} #{leader.value}"
        end

        # Calculates column widths for leader display
        #
        # @api private
        # @return [Hash]
        def calculate_leader_widths(leaders)
          {rank: max_length(leaders.map(&:rank)), name: max_length(leaders.map(&:player_name))}
        end
      end
    end
  end
end
