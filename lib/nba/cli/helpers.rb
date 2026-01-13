module NBA
  class CLI < Thor
    # Helper methods for CLI date parsing and team lookup
    module Helpers
      # Eastern Time offset from UTC in seconds
      # @return [Integer] offset value in seconds
      ET_OFFSET_SECONDS = 5 * 60 * 60

      # Mapping of conference abbreviations to full names
      # @return [Hash<String, String>] conference mapping
      CONFERENCE_MAP = {"E" => "East", "W" => "West", nil => "Invalid"}.freeze

      # Parses a date string into a Date object
      #
      # @api private
      # @param date_str [String, nil] the date string
      # @return [Date] the parsed date
      def parse_date(date_str)
        return eastern_time_date if date_str.nil? || date_str.eql?("today")
        return eastern_time_date - 1 if date_str.eql?("yesterday")
        return eastern_time_date + 1 if date_str.eql?("tomorrow")

        parse_date_string(date_str)
      end

      # Parses a YYYYMMDD date string
      #
      # @api private
      # @param date_str [String] the date string in YYYYMMDD format
      # @return [Date] the parsed date
      # @raise [SystemExit] if the date string is invalid
      def parse_date_string(date_str)
        Date.strptime(date_str, "%Y%m%d")
      rescue Date::Error
        say("Invalid date '#{date_str}'. Use YYYYMMDD format, 'today', 'yesterday', or 'tomorrow'.")
        raise SystemExit
      end

      # Returns the current date in Eastern Time
      #
      # @api private
      # @return [Date] the current Eastern Time date
      def eastern_time_date = (Time.now.utc - ET_OFFSET_SECONDS).to_date

      # Finds a team by name or abbreviation
      #
      # @api private
      # @param name [String] the team name or abbreviation
      # @return [Team, nil] the matching team or nil
      def find_team_by_name(name)
        pattern = Regexp.new(name, Regexp::IGNORECASE)
        Teams.all.find { |t| pattern.match?(t.full_name) || pattern.match?(t.abbreviation) }
      end

      # Filters teams by name or abbreviation pattern, or returns all teams
      #
      # @api private
      # @param name [String, nil] the team name or abbreviation pattern to filter by
      # @return [Collection, Array] the matching teams
      def filter_teams(name)
        return Teams.all unless name

        pattern = Regexp.new(name, Regexp::IGNORECASE)
        Teams.all.select { |team| pattern.match?(team.full_name) || pattern.match?(team.abbreviation) }
      end

      # Normalizes a conference input to full name
      #
      # @api private
      # @param input [String] the conference input (e.g., "e", "E", "East", "w", "W", "West")
      # @return [String] the normalized conference name
      def normalize_conference(input)
        CONFERENCE_MAP.fetch(input.upcase[0].to_s, input)
      end

      # Fetches standings based on options
      #
      # @api private
      # @return [Collection] the standings collection
      def fetch_standings
        return fetch_conference_standings if options[:conference]

        options[:season] ? Standings.all(season: options.fetch(:season)) : Standings.all
      end

      # Fetches conference-specific standings
      #
      # @api private
      # @return [Collection] the conference standings
      def fetch_conference_standings
        conf = normalize_conference(options.fetch(:conference))
        options[:season] ? Standings.conference(conf, season: options.fetch(:season)) : Standings.conference(conf)
      end

      # Fetches schedule for a team
      #
      # @api private
      # @param team [Team] the team
      # @return [Collection] the schedule
      def fetch_team_schedule(team)
        season = options[:season]
        season ? Schedule.by_team(team: team, season: season) : Schedule.by_team(team: team)
      end

      # Fetches roster for a team
      #
      # @api private
      # @param team [Team] the team
      # @return [Collection] the roster
      def fetch_team_roster(team)
        season = options[:season]
        season ? Roster.find(team: team, season: season) : Roster.find(team: team)
      end

      # Resolves a category name to a Leaders constant
      #
      # @api private
      # @param category [String] the category name
      # @param category_map [Hash] mapping of category names to constant names
      # @return [String] the Leaders constant value
      def resolve_leader_category(category, category_map)
        category_map[category.upcase] || Leaders::PTS
      end

      # Fetches games for a date, using live data for today
      #
      # @api private
      # @param date [Date] the date
      # @return [Collection] the games collection
      def fetch_games(date)
        date.eql?(eastern_time_date) ? LiveScoreboard.today : Scoreboard.games(date: date)
      end
    end
  end
end
