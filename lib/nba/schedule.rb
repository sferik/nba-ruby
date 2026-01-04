require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

module NBA
  # Represents a scheduled game
  class ScheduledGame < Shale::Mapper
    include Equalizer.new(:game_id)

    # @!attribute [rw] game_date
    #   Returns the game date
    #   @api public
    #   @example
    #     game.game_date #=> "2024-10-22T19:00:00Z"
    #   @return [String] the game date
    attribute :game_date, Shale::Type::String

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     game.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] game_code
    #   Returns the game code
    #   @api public
    #   @example
    #     game.game_code #=> "20241022/LALGSW"
    #   @return [String] the game code
    attribute :game_code, Shale::Type::String

    # @!attribute [rw] game_status
    #   Returns the game status (1=scheduled, 2=in progress, 3=final)
    #   @api public
    #   @example
    #     game.game_status #=> 1
    #   @return [Integer] the game status
    attribute :game_status, Shale::Type::Integer

    # @!attribute [rw] game_status_text
    #   Returns the game status text
    #   @api public
    #   @example
    #     game.game_status_text #=> "7:00 pm ET"
    #   @return [String] the game status text
    attribute :game_status_text, Shale::Type::String

    # @!attribute [rw] home_team_id
    #   Returns the home team ID
    #   @api public
    #   @example
    #     game.home_team_id #=> 1610612744
    #   @return [Integer] the home team ID
    attribute :home_team_id, Shale::Type::Integer

    # @!attribute [rw] home_team_name
    #   Returns the home team name
    #   @api public
    #   @example
    #     game.home_team_name #=> "Warriors"
    #   @return [String] the home team name
    attribute :home_team_name, Shale::Type::String

    # @!attribute [rw] home_team_city
    #   Returns the home team city
    #   @api public
    #   @example
    #     game.home_team_city #=> "Golden State"
    #   @return [String] the home team city
    attribute :home_team_city, Shale::Type::String

    # @!attribute [rw] home_team_tricode
    #   Returns the home team tricode/abbreviation
    #   @api public
    #   @example
    #     game.home_team_tricode #=> "GSW"
    #   @return [String] the home team tricode
    attribute :home_team_tricode, Shale::Type::String

    # @!attribute [rw] home_team_wins
    #   Returns the home team wins
    #   @api public
    #   @example
    #     game.home_team_wins #=> 46
    #   @return [Integer] the home team wins
    attribute :home_team_wins, Shale::Type::Integer

    # @!attribute [rw] home_team_losses
    #   Returns the home team losses
    #   @api public
    #   @example
    #     game.home_team_losses #=> 36
    #   @return [Integer] the home team losses
    attribute :home_team_losses, Shale::Type::Integer

    # @!attribute [rw] home_team_score
    #   Returns the home team score
    #   @api public
    #   @example
    #     game.home_team_score #=> 112
    #   @return [Integer] the home team score
    attribute :home_team_score, Shale::Type::Integer

    # @!attribute [rw] away_team_id
    #   Returns the away team ID
    #   @api public
    #   @example
    #     game.away_team_id #=> 1610612747
    #   @return [Integer] the away team ID
    attribute :away_team_id, Shale::Type::Integer

    # @!attribute [rw] away_team_name
    #   Returns the away team name
    #   @api public
    #   @example
    #     game.away_team_name #=> "Lakers"
    #   @return [String] the away team name
    attribute :away_team_name, Shale::Type::String

    # @!attribute [rw] away_team_city
    #   Returns the away team city
    #   @api public
    #   @example
    #     game.away_team_city #=> "Los Angeles"
    #   @return [String] the away team city
    attribute :away_team_city, Shale::Type::String

    # @!attribute [rw] away_team_tricode
    #   Returns the away team tricode/abbreviation
    #   @api public
    #   @example
    #     game.away_team_tricode #=> "LAL"
    #   @return [String] the away team tricode
    attribute :away_team_tricode, Shale::Type::String

    # @!attribute [rw] away_team_wins
    #   Returns the away team wins
    #   @api public
    #   @example
    #     game.away_team_wins #=> 43
    #   @return [Integer] the away team wins
    attribute :away_team_wins, Shale::Type::Integer

    # @!attribute [rw] away_team_losses
    #   Returns the away team losses
    #   @api public
    #   @example
    #     game.away_team_losses #=> 39
    #   @return [Integer] the away team losses
    attribute :away_team_losses, Shale::Type::Integer

    # @!attribute [rw] away_team_score
    #   Returns the away team score
    #   @api public
    #   @example
    #     game.away_team_score #=> 108
    #   @return [Integer] the away team score
    attribute :away_team_score, Shale::Type::Integer

    # @!attribute [rw] arena_name
    #   Returns the arena name
    #   @api public
    #   @example
    #     game.arena_name #=> "Chase Center"
    #   @return [String] the arena name
    attribute :arena_name, Shale::Type::String

    # @!attribute [rw] arena_city
    #   Returns the arena city
    #   @api public
    #   @example
    #     game.arena_city #=> "San Francisco"
    #   @return [String] the arena city
    attribute :arena_city, Shale::Type::String

    # @!attribute [rw] arena_state
    #   Returns the arena state
    #   @api public
    #   @example
    #     game.arena_state #=> "CA"
    #   @return [String] the arena state
    attribute :arena_state, Shale::Type::String

    # @!attribute [rw] broadcasters
    #   Returns the broadcaster information
    #   @api public
    #   @example
    #     game.broadcasters #=> "TNT"
    #   @return [String] the broadcasters
    attribute :broadcasters, Shale::Type::String

    # Returns the home team object
    #
    # @api public
    # @example
    #   game.home_team #=> #<NBA::Team>
    # @return [Team, nil] the home team object
    def home_team
      Teams.find(home_team_id)
    end

    # Returns the away team object
    #
    # @api public
    # @example
    #   game.away_team #=> #<NBA::Team>
    # @return [Team, nil] the away team object
    def away_team
      Teams.find(away_team_id)
    end

    # Returns whether the game is scheduled
    #
    # @api public
    # @example
    #   game.scheduled? #=> true
    # @return [Boolean] true if scheduled
    def scheduled?
      game_status.eql?(1)
    end

    # Returns whether the game is in progress
    #
    # @api public
    # @example
    #   game.in_progress? #=> false
    # @return [Boolean] true if in progress
    def in_progress?
      game_status.eql?(2)
    end

    # Returns whether the game is final
    #
    # @api public
    # @example
    #   game.final? #=> false
    # @return [Boolean] true if final
    def final?
      game_status.eql?(3)
    end
  end

  # Provides methods to retrieve league schedule
  module Schedule
    # Result set name for league schedule
    # @return [String] the result set name
    LEAGUE_SCHEDULE = "LeagueSchedule".freeze

    # Retrieves the league schedule
    #
    # @api public
    # @example
    #   games = NBA::Schedule.all(season: 2024)
    #   games.each { |g| puts "#{g.game_date}: #{g.away_team_name} @ #{g.home_team_name}" }
    # @param season [Integer] the season year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of scheduled games
    def self.all(season: Utils.current_season, league: League::NBA, client: CLIENT)
      league_id = extract_league_id(league)
      path = build_path(season, league_id)
      response = client.get(path)
      parse_response(response)
    end

    # Retrieves games for a specific date
    #
    # @api public
    # @example
    #   games = NBA::Schedule.by_date(date: Date.today, season: 2024)
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

    # Retrieves games for a specific team
    #
    # @api public
    # @example
    #   games = NBA::Schedule.by_team(team: NBA::Team::GSW, season: 2024)
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
      season_str = "#{season}-#{(season + 1).to_s[-2..]}"
      "scheduleleaguev2?LeagueID=#{league_id}&Season=#{season_str}"
    end
    private_class_method :build_path

    # Parses the API response into scheduled game objects
    # @api private
    # @return [Collection] collection of scheduled games
    def self.parse_response(response)
      return Collection.new unless response

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
      games = date_entry.fetch("games", nil)
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
      {game_date: data.fetch("gameDateTimeUTC", nil), game_id: data.fetch("gameId", nil),
       game_code: data.fetch("gameCode", nil), game_status: data.fetch("gameStatus", nil),
       game_status_text: data.fetch("gameStatusText", nil)}
    end
    private_class_method :game_info_attributes

    # Extracts home team attributes from data
    # @api private
    # @return [Hash] home team attributes
    def self.home_team_attributes(data)
      home = data.fetch("homeTeam", nil) || {}
      {home_team_id: home.fetch("teamId", nil), home_team_name: home.fetch("teamName", nil),
       home_team_city: home.fetch("teamCity", nil), home_team_tricode: home.fetch("teamTricode", nil),
       home_team_wins: home.fetch("wins", nil), home_team_losses: home.fetch("losses", nil),
       home_team_score: home.fetch("score", nil)}
    end
    private_class_method :home_team_attributes

    # Extracts away team attributes from data
    # @api private
    # @return [Hash] away team attributes
    def self.away_team_attributes(data)
      away = data.fetch("awayTeam", nil) || {}
      {away_team_id: away.fetch("teamId", nil), away_team_name: away.fetch("teamName", nil),
       away_team_city: away.fetch("teamCity", nil), away_team_tricode: away.fetch("teamTricode", nil),
       away_team_wins: away.fetch("wins", nil), away_team_losses: away.fetch("losses", nil),
       away_team_score: away.fetch("score", nil)}
    end
    private_class_method :away_team_attributes

    # Extracts venue attributes from data
    # @api private
    # @return [Hash] venue attributes
    def self.venue_attributes(data)
      {arena_name: data.fetch("arenaName", nil), arena_city: data.fetch("arenaCity", nil),
       arena_state: data.fetch("arenaState", nil), broadcasters: format_broadcasters(data.fetch("broadcasters", nil))}
    end
    private_class_method :venue_attributes

    # Formats broadcasters into a string
    # @api private
    # @return [String, nil] formatted broadcasters
    def self.format_broadcasters(broadcasters)
      return unless broadcasters

      national = broadcasters.fetch("nationalTvBroadcasters", nil)
      return unless national&.any?

      national.map { |b| b.fetch("broadcasterDisplay", nil) }.join(", ")
    end
    private_class_method :format_broadcasters

    # Extracts team ID from team object or integer
    # @api private
    # @return [Integer] the team ID
    def self.extract_team_id(team)
      team.instance_of?(Team) ? team.id : team
    end
    private_class_method :extract_team_id

    # Extracts the league ID from a League object or string
    #
    # @api private
    # @param league [String, League] the league ID or League object
    # @return [String] the league ID string
    def self.extract_league_id(league)
      case league
      when League then league.id
      else league
      end
    end
    private_class_method :extract_league_id
  end
end
