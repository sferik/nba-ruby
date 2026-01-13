require "json"
require_relative "client"
require_relative "collection"
require_relative "schedule"
require_relative "utils"

module NBA
  # Provides methods to retrieve international league schedule
  module ScheduleInternational
    # Result set name for league schedule
    # @return [String] the result set name
    LEAGUE_SCHEDULE = "LeagueSchedule".freeze

    # Retrieves the international league schedule
    #
    # @api public
    # @example
    #   games = NBA::ScheduleInternational.all(season: 2024)
    #   games.each { |g| puts "#{g.game_date}: #{g.away_team_name} @ #{g.home_team_name}" }
    # @param season [Integer] the season year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of scheduled games
    def self.all(season: Utils.current_season, league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      path = build_path(season, league_id)
      response = client.get(path)
      parse_response(response)
    end

    # Retrieves international games for a specific date
    #
    # @api public
    # @example
    #   games = NBA::ScheduleInternational.by_date(date: Date.today, season: 2024)
    #   games.each { |g| puts "#{g.away_team_name} @ #{g.home_team_name}" }
    # @param date [Date] the date
    # @param season [Integer] the season year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of scheduled games
    def self.by_date(date:, season: Utils.current_season, league: League::NBA, client: CLIENT)
      all_games = all(season: season, league: league, client: client)
      date_str = date.strftime
      filtered = all_games.select { |g| g.game_date&.start_with?(date_str) }
      Collection.new(filtered)
    end

    # Retrieves international games for a specific team
    #
    # @api public
    # @example
    #   games = NBA::ScheduleInternational.by_team(team: NBA::Team::GSW, season: 2024)
    #   games.each { |g| puts "#{g.game_date}: #{g.away_team_tricode} @ #{g.home_team_tricode}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of scheduled games
    def self.by_team(team:, season: Utils.current_season, league: League::NBA, client: CLIENT)
      team_id = extract_team_id(team)
      all_games = all(season: season, league: league, client: client)
      filtered = all_games.select { |g| g.home_team_id.eql?(team_id) || g.away_team_id.eql?(team_id) }
      Collection.new(filtered)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(season, league_id)
      season_str = Utils.format_season(season)
      "scheduleleaguev2int?LeagueID=#{league_id}&Season=#{season_str}"
    end
    private_class_method :build_path

    # Parses the API response into scheduled game objects
    # @api private
    # @return [Collection] collection of scheduled games
    def self.parse_response(response)
      return Collection.new if response.nil? || response.empty?

      data = JSON.parse(response)
      game_dates = data.dig("leagueSchedule", "gameDates")
      return Collection.new unless game_dates

      games = game_dates.flat_map { |date_entry| parse_date_entry(date_entry) }
      Collection.new(games)
    end
    private_class_method :parse_response

    # Parses a date entry into game objects
    # @api private
    # @return [Array<ScheduledGame>] array of games for the date
    def self.parse_date_entry(date_entry)
      games = date_entry["games"]
      return [] unless games

      games.map { |game| build_scheduled_game(game) }
    end
    private_class_method :parse_date_entry

    # Builds a ScheduledGame object from raw data
    # @api private
    # @return [ScheduledGame] the scheduled game object
    def self.build_scheduled_game(data)
      ScheduledGame.new(**scheduled_game_attributes(data))
    end
    private_class_method :build_scheduled_game

    # Combines all scheduled game attributes
    # @api private
    # @return [Hash] the combined attributes
    def self.scheduled_game_attributes(data)
      game_info_attributes(data).merge(home_team_attributes(data), away_team_attributes(data), venue_attributes(data))
    end
    private_class_method :scheduled_game_attributes

    # Extracts game info attributes from data
    # @api private
    # @return [Hash] game info attributes
    def self.game_info_attributes(data)
      {game_date: data["gameDateTimeUTC"], game_id: data["gameId"],
       game_code: data["gameCode"], game_status: data["gameStatus"],
       game_status_text: data["gameStatusText"]}
    end
    private_class_method :game_info_attributes

    # Extracts home team attributes from data
    # @api private
    # @return [Hash] home team attributes
    def self.home_team_attributes(data)
      home = data["homeTeam"] || {}
      {home_team_id: home["teamId"], home_team_name: home["teamName"],
       home_team_city: home["teamCity"], home_team_tricode: home["teamTricode"],
       home_team_wins: home["wins"], home_team_losses: home["losses"],
       home_team_score: home["score"]}
    end
    private_class_method :home_team_attributes

    # Extracts away team attributes from data
    # @api private
    # @return [Hash] away team attributes
    def self.away_team_attributes(data)
      away = data["awayTeam"] || {}
      {away_team_id: away["teamId"], away_team_name: away["teamName"],
       away_team_city: away["teamCity"], away_team_tricode: away["teamTricode"],
       away_team_wins: away["wins"], away_team_losses: away["losses"],
       away_team_score: away["score"]}
    end
    private_class_method :away_team_attributes

    # Extracts venue attributes from data
    # @api private
    # @return [Hash] venue attributes
    def self.venue_attributes(data)
      {arena_name: data["arenaName"], arena_city: data["arenaCity"],
       arena_state: data["arenaState"], broadcasters: format_broadcasters(data["broadcasters"])}
    end
    private_class_method :venue_attributes

    # Formats broadcasters into a string
    # @api private
    # @return [String, nil] formatted broadcasters
    def self.format_broadcasters(broadcasters)
      return unless broadcasters

      national = broadcasters["nationalTvBroadcasters"]
      return unless national&.any?

      national.map { |b| b["broadcasterDisplay"] }.join(", ")
    end
    private_class_method :format_broadcasters

    # Extracts team ID from team object or integer
    # @api private
    # @return [Integer] the team ID
    def self.extract_team_id(team)
      team.instance_of?(Team) ? team.id : team
    end
    private_class_method :extract_team_id
  end
end
