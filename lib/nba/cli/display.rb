require_relative "display/player_display"

module NBA
  class CLI < Thor
    # Helper methods for displaying CLI output
    module Display
      include PlayerDisplay

      # Displays a list of games in aligned columns
      #
      # @api private
      # @param games_list [Collection] the games to display
      # @return [void]
      def display_games(games_list)
        widths = calculate_game_widths(games_list)
        games_list.each { |game| say(format_game_row(game, widths)) }
      end

      # Displays a list of teams
      #
      # @api private
      # @param teams_list [Collection] the teams to display
      # @param include_roster [Boolean] whether to include roster
      # @param detailed [Boolean] whether to show detailed info
      # @return [void]
      def display_teams(teams_list, include_roster, detailed:)
        return display_team_names(teams_list) unless detailed

        teams_list.each_with_index do |team, index|
          say unless index.zero?
          display_team(team)
          display_team_roster(team) if include_roster
        end
      end

      # Displays team names only in alphabetical order
      #
      # @api private
      # @param teams_list [Collection] the teams to display
      # @return [void]
      def display_team_names(teams_list)
        sorted = teams_list.sort_by { |team| team.full_name.to_s }
        sorted.each { |team| say(team.full_name) }
      end

      # Displays a single team
      #
      # @api private
      # @param team [Team] the team to display
      # @return [void]
      def display_team(team)
        detail = TeamDetails.find(team: team)
        say(format_label("Name", team.full_name))
        say(format_label("Founded", team.year_founded))
        display_team_conference(detail)
        display_team_division(detail)
        say(format_label("Coach", detail&.head_coach))
        display_team_championships(team)
      end

      # Displays team conference info
      #
      # @api private
      # @param detail [TeamDetail] the team detail
      # @return [void]
      def display_team_conference(detail)
        return say(format_label("Conference", nil)) unless detail

        conf = conference_name(detail)
        say(format_label("Conference", conf))
      end

      # Displays team division info
      #
      # @api private
      # @param detail [TeamDetail] the team detail
      # @return [void]
      def display_team_division(detail)
        return say(format_label("Division", nil)) unless detail

        div = division_name(detail)
        say(format_label("Division", div))
      end

      # Displays team championships
      #
      # @api private
      # @param team [Team] the team
      # @return [void]
      def display_team_championships(team)
        stats = fetch_team_year_stats(team)
        championships = stats.select { |s| championship_year?(s) }.map(&:year)
        return if championships.empty?

        say(format_multiline_label("Championships", championships))
      end

      # Fetches team year-by-year stats safely
      #
      # @api private
      # @param team [Team] the team
      # @return [Collection] the stats collection
      def fetch_team_year_stats(team)
        TeamYearByYearStats.find(team: team)
      rescue JSON::ParserError
        Collection.new
      end

      # Displays the roster for a team
      #
      # @api private
      # @param team [Team] the team
      # @return [void]
      def display_team_roster(team)
        roster_list = Roster.find(team: team)
        return if roster_list.empty?

        display_players_list(roster_list)
      end

      # Displays a list of players as team roster
      #
      # @api private
      # @param players [Collection] the players to display
      # @return [void]
      def display_players_list(players)
        say("Players:")
        players.each { |player| say(format_detailed_roster_player(player)) }
      end

      # Displays standings in aligned format
      #
      # @api private
      # @param standings_list [Collection] the standings to display
      # @return [void]
      def display_standings(standings_list)
        widths = calculate_standings_widths(standings_list)
        standings_list.each_with_index do |standing, index|
          say(format_standing_row(standing, index + 1, widths))
        end
      end

      # Displays league leaders in aligned format
      #
      # @api private
      # @param leaders_list [Collection] the leaders to display
      # @param category [String] the stat category
      # @return [void]
      def display_leaders(leaders_list, category)
        say("League Leaders - #{category.upcase}")
        widths = calculate_leader_widths(leaders_list)
        leaders_list.each { |leader| say(format_leader_row(leader, widths)) }
      end

      # Displays schedule for a team
      #
      # @api private
      # @param schedule_list [Collection] the schedule to display
      # @param team [Team] the team
      # @return [void]
      def display_schedule(schedule_list, team)
        say("Schedule for #{team.full_name}")
        schedule_list.each { |game| say(format_schedule_game(game, team)) }
      end

      # Displays roster for a team
      #
      # @api private
      # @param roster_list [Collection] the roster to display
      # @param team [Team] the team
      # @return [void]
      def display_roster(roster_list, team)
        say("Roster for #{team.full_name}")
        roster_list.each { |player| say(format_detailed_roster_player(player)) }
      end
    end
  end
end
