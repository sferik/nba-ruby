module NBA
  class CLI < Thor
    module Display
      # Helper methods for displaying player info
      module PlayerDisplay
        # Displays a list of players from search
        #
        # @api private
        # @param players_list [Collection] the players to display
        # @return [void]
        def display_players(players_list)
          say("Found #{players_list.size} player(s):")
          players_list.each { |player| say(format_player_result(player)) }
        end

        # Displays detailed information for a single player
        #
        # @api private
        # @param player [Player] the player to display
        # @return [void]
        def display_player(player)
          detail = Players.find(player)
          return say("Player not found") unless detail

          say(format_label("Name", detail.full_name))
          say(format_label("Status", detail.active? ? "Active" : "Inactive"))
          display_player_physical(detail)
          display_player_draft(detail)
        end

        # Displays player physical info
        #
        # @api private
        # @param player [Player] the player
        # @return [void]
        def display_player_physical(player)
          display_player_position(player)
          display_player_body(player)
          display_player_origin(player)
        end

        # Displays player draft info
        #
        # @api private
        # @param player [Player] the player
        # @return [void]
        def display_player_draft(player)
          return say(format_label("Draft", "Undrafted")) unless player.draft_year

          draft = format_draft_info(player)
          say(format_label("Draft", draft))
        end

        private

        # Displays player position
        #
        # @api private
        # @param player [Player] the player
        # @return [void]
        def display_player_position(player)
          say(format_label("Position", player.position&.name))
        end

        # Displays player body measurements
        #
        # @api private
        # @param player [Player] the player
        # @return [void]
        def display_player_body(player)
          say(format_label("Height", player.height))
          say(format_label("Weight", format_weight(player.weight)))
        end

        # Displays player origin info
        #
        # @api private
        # @param player [Player] the player
        # @return [void]
        def display_player_origin(player)
          say(format_label("Country", player.country))
          say(format_label("College", player.college))
        end

        # Formats weight with unit if present
        #
        # @api private
        # @param weight [Integer, nil] the weight value
        # @return [String, nil] formatted weight or nil
        def format_weight(weight)
          return unless weight

          "#{weight} lbs"
        end
      end
    end
  end
end
