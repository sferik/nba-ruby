require "thor"
require "date"
require_relative "cli/formatters"
require_relative "cli/display"
require_relative "cli/helpers"

module NBA
  # Command-line interface for the NBA gem
  #
  # @api public
  class CLI < Thor
    include Formatters
    include Display
    include Helpers

    # Mapping of category names and abbreviations to Leaders constants
    # @return [Hash<String, String>] category mapping
    CATEGORY_MAP = {
      "PTS" => "PTS", "POINTS" => "PTS",
      "REB" => "REB", "REBOUNDS" => "REB",
      "AST" => "AST", "ASSISTS" => "AST",
      "STL" => "STL", "STEALS" => "STL",
      "BLK" => "BLK", "BLOCKS" => "BLK",
      "FG_PCT" => "FG_PCT", "FG3_PCT" => "FG3_PCT", "FT_PCT" => "FT_PCT"
    }.freeze

    class_option :version, type: :boolean, aliases: "-v", desc: "Print version and exit"
    class_option :format, type: :string, aliases: "-f", enum: %w[table json csv], default: "table",
      desc: "Output format (table, json, csv)"

    remove_command :tree

    # Returns whether Thor should exit on failure
    #
    # @api public
    # @example
    #   NBA::CLI.exit_on_failure? #=> true
    # @return [Boolean] true if CLI should exit on failure
    def self.exit_on_failure?
      true
    end

    desc "games", "Retrieve games' scoreboard for a date"
    method_option :date, type: :string, aliases: "-d", desc: "Date (YYYYMMDD, 'today', or 'yesterday')"
    # Retrieves and displays games for a specified date
    #
    # @api public
    # @example
    #   cli = NBA::CLI.new
    #   cli.games
    # @return [void]
    def games
      date = parse_date(options[:date])
      games_list = fetch_games(date)
      return say("No games found for #{date}") if games_list.empty?

      output_collection(games_list) { display_games(games_list) }
    end

    desc "teams [NAME]", "List all teams or search by name"
    method_option :roster, type: :boolean, aliases: "-r", default: false, desc: "Include roster"
    # Lists all teams or searches for teams by name
    #
    # @api public
    # @example
    #   cli = NBA::CLI.new
    #   cli.teams("GSW")
    # @param name [String, nil] the team name or abbreviation to search for
    # @return [void]
    def teams(name = nil)
      matching_teams = filter_teams(name)
      if matching_teams.empty?
        say("No team found with name '#{name}'")
      else
        display_teams(matching_teams, options.fetch(:roster), detailed: name)
      end
    end

    desc "player NAME", "Search for a player by name"
    # Searches for players by name
    #
    # @api public
    # @example
    #   cli = NBA::CLI.new
    #   cli.player("LeBron")
    # @param name [String] the player name to search for
    # @return [void]
    def player(name)
      pattern = Regexp.new(name, Regexp::IGNORECASE)
      matching = Players.all.select { |p| pattern.match?(p.full_name) }
      if matching.empty?
        say("No player found with name '#{name}'")
      elsif matching.one?
        matching.each { |p| display_player(p) }
      else
        display_players(matching)
      end
    end

    desc "standings", "Display current league standings"
    method_option :conference, type: :string, aliases: "-c", desc: "Filter by conference (East/West)"
    method_option :season, type: :numeric, aliases: "-s", desc: "Season year (e.g., 2024)"
    # Displays current league standings
    #
    # @api public
    # @example
    #   cli = NBA::CLI.new
    #   cli.standings
    # @return [void]
    def standings
      standings_list = fetch_standings
      output_collection(standings_list) { display_standings(standings_list) }
    end

    desc "leaders [CATEGORY]", "Display league leaders for a statistical category"
    method_option :season, type: :numeric, aliases: "-s", desc: "Season year (e.g., 2024)"
    method_option :limit, type: :numeric, aliases: "-l", default: 10, desc: "Number of leaders"
    # Displays league leaders for a statistical category
    #
    # @api public
    # @example
    #   cli = NBA::CLI.new
    #   cli.leaders("PTS")
    # @param category_name [String] the stat category (PTS, REB, AST, STL, BLK, FG_PCT, FG3_PCT, FT_PCT)
    # @return [void]
    def leaders(category_name = "PTS")
      category = resolve_leader_category(category_name, CATEGORY_MAP)
      leaders_list = if options[:season]
        Leaders.find(category: category, limit: options.fetch(:limit),
          season: options.fetch(:season))
      else
        Leaders.find(category: category, limit: options.fetch(:limit))
      end
      output_collection(leaders_list) { display_leaders(leaders_list, category_name) }
    end

    desc "schedule TEAM", "Display schedule for a team"
    method_option :season, type: :numeric, aliases: "-s", desc: "Season year (e.g., 2024)"
    # Displays schedule for a team
    #
    # @api public
    # @example
    #   cli = NBA::CLI.new
    #   cli.schedule("Lakers")
    # @param team_name [String] the team name or abbreviation
    # @return [void]
    def schedule(team_name)
      team = find_team_by_name(team_name)
      return say("No team found with name '#{team_name}'") unless team

      schedule_list = fetch_team_schedule(team)
      output_collection(schedule_list) { display_schedule(schedule_list, team) }
    end

    desc "roster TEAM", "Display roster for a team"
    method_option :season, type: :numeric, aliases: "-s", desc: "Season year (e.g., 2024)"
    # Displays roster for a team
    #
    # @api public
    # @example
    #   cli = NBA::CLI.new
    #   cli.roster("Lakers")
    # @param team_name [String] the team name or abbreviation
    # @return [void]
    def roster(team_name)
      team = find_team_by_name(team_name)
      return say("No team found with name '#{team_name}'") unless team

      roster_list = fetch_team_roster(team)
      output_collection(roster_list) { display_roster(roster_list, team) }
    end

    desc "version", "Display version information"
    # Displays version information
    #
    # @api public
    # @example
    #   cli = NBA::CLI.new
    #   cli.version
    # @return [void]
    def version
      say("nba #{VERSION}")
    end

    map %w[-v --version] => :version
  end
end
