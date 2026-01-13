module NBA
  class CLI < Thor
    module Formatters
      # Formatters for player-related output
      module PlayerFormatters
        # Formats a roster player with detailed information
        #
        # @api private
        # @return [String]
        def format_detailed_roster_player(player)
          jersey = format_jersey_number(player.jersey_number)
          name = (player.full_name || "Unknown").ljust(25)
          position = format_position(player.position)
          "##{jersey} #{name} #{position} #{player.height || "?"}"
        end

        # Formats a jersey number for display
        #
        # @api private
        # @example
        #   format_jersey_number(3) #=> " 3"
        # @return [String]
        def format_jersey_number(number) = number&.to_s&.rjust(2) || " ?"

        # Formats a position abbreviation for display
        #
        # @api private
        # @example
        #   format_position(position) #=> "PG "
        # @return [String]
        def format_position(position) = (position&.abbreviation || "?").ljust(3)

        # Formats a player search result
        #
        # @api private
        # @return [String]
        def format_player_result(player)
          status = player.active? ? "Active" : "Inactive"
          "#{player.full_name} (#{status})"
        end

        # Formats player draft information
        #
        # @api private
        # @return [String]
        def format_draft_info(player)
          "#{player.draft_year} Round #{player.draft_round}, Pick #{player.draft_number}"
        end
      end
    end
  end
end
