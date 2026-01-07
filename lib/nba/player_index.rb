require_relative "client"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Represents a player from the player index endpoint
  #
  # @api public
  class PlayerIndexEntry < Shale::Mapper
    include Equalizer.new(:id)

    # @!attribute [rw] id
    #   Returns the player ID
    #   @api public
    #   @example
    #     entry.id #=> 201939
    #   @return [Integer] the player ID
    attribute :id, Shale::Type::Integer

    # @!attribute [rw] last_name
    #   Returns the player's last name
    #   @api public
    #   @example
    #     entry.last_name #=> "Curry"
    #   @return [String] the last name
    attribute :last_name, Shale::Type::String

    # @!attribute [rw] first_name
    #   Returns the player's first name
    #   @api public
    #   @example
    #     entry.first_name #=> "Stephen"
    #   @return [String] the first name
    attribute :first_name, Shale::Type::String

    # @!attribute [rw] slug
    #   Returns the player's URL slug
    #   @api public
    #   @example
    #     entry.slug #=> "stephen-curry"
    #   @return [String] the slug
    attribute :slug, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     entry.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_slug
    #   Returns the team's URL slug
    #   @api public
    #   @example
    #     entry.team_slug #=> "warriors"
    #   @return [String] the team slug
    attribute :team_slug, Shale::Type::String

    # @!attribute [rw] team_city
    #   Returns the team's city
    #   @api public
    #   @example
    #     entry.team_city #=> "Golden State"
    #   @return [String] the team city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team's name
    #   @api public
    #   @example
    #     entry.team_name #=> "Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] team_abbreviation
    #   Returns the team's abbreviation
    #   @api public
    #   @example
    #     entry.team_abbreviation #=> "GSW"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] jersey_number
    #   Returns the player's jersey number
    #   @api public
    #   @example
    #     entry.jersey_number #=> "30"
    #   @return [String] the jersey number
    attribute :jersey_number, Shale::Type::String

    # @!attribute [rw] position
    #   Returns the player's position
    #   @api public
    #   @example
    #     entry.position #=> "G"
    #   @return [String] the position
    attribute :position, Shale::Type::String

    # @!attribute [rw] height
    #   Returns the player's height
    #   @api public
    #   @example
    #     entry.height #=> "6-2"
    #   @return [String] the height
    attribute :height, Shale::Type::String

    # @!attribute [rw] weight
    #   Returns the player's weight in pounds
    #   @api public
    #   @example
    #     entry.weight #=> 185
    #   @return [Integer] the weight
    attribute :weight, Shale::Type::Integer

    # @!attribute [rw] college
    #   Returns the player's college
    #   @api public
    #   @example
    #     entry.college #=> "Davidson"
    #   @return [String] the college
    attribute :college, Shale::Type::String

    # @!attribute [rw] country
    #   Returns the player's country
    #   @api public
    #   @example
    #     entry.country #=> "USA"
    #   @return [String] the country
    attribute :country, Shale::Type::String

    # @!attribute [rw] draft_year
    #   Returns the player's draft year
    #   @api public
    #   @example
    #     entry.draft_year #=> 2009
    #   @return [Integer] the draft year
    attribute :draft_year, Shale::Type::Integer

    # @!attribute [rw] draft_round
    #   Returns the player's draft round
    #   @api public
    #   @example
    #     entry.draft_round #=> 1
    #   @return [Integer] the draft round
    attribute :draft_round, Shale::Type::Integer

    # @!attribute [rw] draft_number
    #   Returns the player's draft pick number
    #   @api public
    #   @example
    #     entry.draft_number #=> 7
    #   @return [Integer] the draft number
    attribute :draft_number, Shale::Type::Integer

    # @!attribute [rw] roster_status
    #   Returns the player's roster status
    #   @api public
    #   @example
    #     entry.roster_status #=> 1
    #   @return [Integer] the roster status
    attribute :roster_status, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns career points per game
    #   @api public
    #   @example
    #     entry.pts #=> 24.8
    #   @return [Float] points per game
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns career rebounds per game
    #   @api public
    #   @example
    #     entry.reb #=> 4.7
    #   @return [Float] rebounds per game
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns career assists per game
    #   @api public
    #   @example
    #     entry.ast #=> 6.5
    #   @return [Float] assists per game
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] stats_timeframe
    #   Returns the stats timeframe
    #   @api public
    #   @example
    #     entry.stats_timeframe #=> "Season"
    #   @return [String] the stats timeframe
    attribute :stats_timeframe, Shale::Type::String

    # @!attribute [rw] from_year
    #   Returns the first year played
    #   @api public
    #   @example
    #     entry.from_year #=> 2009
    #   @return [Integer] the first year
    attribute :from_year, Shale::Type::Integer

    # @!attribute [rw] to_year
    #   Returns the last year played
    #   @api public
    #   @example
    #     entry.to_year #=> 2024
    #   @return [Integer] the last year
    attribute :to_year, Shale::Type::Integer

    # @!attribute [rw] is_defunct
    #   Returns whether the player's team is defunct
    #   @api public
    #   @example
    #     entry.is_defunct #=> 0
    #   @return [Integer] defunct flag (0 or 1)
    attribute :is_defunct, Shale::Type::Integer

    # Returns the player's full name
    #
    # @api public
    # @example
    #   entry.full_name #=> "Stephen Curry"
    # @return [String] the full name
    def full_name
      "#{first_name} #{last_name}".strip
    end

    # Returns whether the player is currently on a roster
    #
    # @api public
    # @example
    #   entry.active? #=> true
    # @return [Boolean] true if on a roster
    def active?
      roster_status.eql?(1)
    end

    # Returns whether the player's team is defunct
    #
    # @api public
    # @example
    #   entry.defunct? #=> false
    # @return [Boolean] true if team is defunct
    def defunct?
      is_defunct.eql?(1)
    end

    # Returns the player object
    #
    # @api public
    # @example
    #   entry.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(id)
    end

    # Returns the team object
    #
    # @api public
    # @example
    #   entry.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end

  # Provides methods to search and retrieve the player index
  #
  # @api public
  module PlayerIndex
    # Result set name for player index
    # @return [String] the result set name
    RESULT_SET_NAME = "PlayerIndex".freeze

    # Historical flag: include historical players
    # @return [Integer] the flag value
    HISTORICAL = 1

    # Historical flag: current players only
    # @return [Integer] the flag value
    CURRENT = 0

    # Retrieves the player index with optional filters
    #
    # @api public
    # @example
    #   # Get all current players
    #   players = NBA::PlayerIndex.all
    #   players.size #=> 450
    #
    # @example
    #   # Get players from a specific college
    #   duke_players = NBA::PlayerIndex.all(college: "Duke")
    #
    # @example
    #   # Get players from a specific country
    #   canadian = NBA::PlayerIndex.all(country: "Canada")
    #
    # @param season [Integer] the season year
    # @param historical [Integer] whether to include historical players (0 or 1)
    # @param active [String, nil] filter by active status ("1" for active)
    # @param all_star [String, nil] filter by all-star status
    # @param college [String, nil] filter by college
    # @param country [String, nil] filter by country
    # @param draft_pick [String, nil] filter by draft pick
    # @param draft_year [String, nil] filter by draft year
    # @param height [String, nil] filter by height
    # @param team [Integer, Team, nil] filter by team
    # @param weight [String, nil] filter by weight
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player index entries
    def self.all(season: Utils.current_season, historical: CURRENT, active: nil, all_star: nil,
      college: nil, country: nil, draft_pick: nil, draft_year: nil, height: nil,
      team: nil, weight: nil, client: CLIENT)
      params = {season: season, historical: historical, active: active, all_star: all_star,
                college: college, country: country, draft_pick: draft_pick, draft_year: draft_year,
                height: height, team: team, weight: weight}
      path = build_path(params)
      ResponseParser.parse(client.get(path), result_set: RESULT_SET_NAME) do |data|
        build_entry(data)
      end
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(params)
      season_str = Utils.format_season(params.fetch(:season))
      team_id = Utils.extract_id(params.fetch(:team))
      "playerindex?LeagueID=00&Season=#{season_str}&Historical=#{params[:historical]}" \
        "&Active=#{params[:active]}&AllStar=#{params[:all_star]}&College=#{params[:college]}" \
        "&Country=#{params[:country]}&DraftPick=#{params[:draft_pick]}&DraftYear=#{params[:draft_year]}" \
        "&Height=#{params[:height]}&TeamID=#{team_id}&Weight=#{params[:weight]}"
    end
    private_class_method :build_path

    # Builds a player index entry from API data
    # @api private
    # @return [PlayerIndexEntry]
    def self.build_entry(data)
      PlayerIndexEntry.new(**identity_info(data), **team_info(data), **physical_info(data),
        **draft_info(data), **stats_info(data))
    end
    private_class_method :build_entry

    # Extracts identity information from data
    # @api private
    # @return [Hash]
    def self.identity_info(data)
      {id: data.fetch("PERSON_ID", nil), last_name: data.fetch("PLAYER_LAST_NAME", nil),
       first_name: data.fetch("PLAYER_FIRST_NAME", nil), slug: data.fetch("PLAYER_SLUG", nil)}
    end
    private_class_method :identity_info

    # Extracts team information from data
    # @api private
    # @return [Hash]
    def self.team_info(data)
      {team_id: data.fetch("TEAM_ID", nil), team_slug: data.fetch("TEAM_SLUG", nil),
       team_city: data.fetch("TEAM_CITY", nil), team_name: data.fetch("TEAM_NAME", nil),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil)}
    end
    private_class_method :team_info

    # Extracts physical information from data
    # @api private
    # @return [Hash]
    def self.physical_info(data)
      {jersey_number: data.fetch("JERSEY_NUMBER", nil), position: data.fetch("POSITION", nil),
       height: data.fetch("HEIGHT", nil), weight: data.fetch("WEIGHT", nil),
       college: data.fetch("COLLEGE", nil), country: data.fetch("COUNTRY", nil)}
    end
    private_class_method :physical_info

    # Extracts draft information from data
    # @api private
    # @return [Hash]
    def self.draft_info(data)
      {draft_year: data.fetch("DRAFT_YEAR", nil), draft_round: data.fetch("DRAFT_ROUND", nil),
       draft_number: data.fetch("DRAFT_NUMBER", nil), roster_status: data.fetch("ROSTER_STATUS", nil)}
    end
    private_class_method :draft_info

    # Extracts stats information from data
    # @api private
    # @return [Hash]
    def self.stats_info(data)
      {pts: data.fetch("PTS", nil), reb: data.fetch("REB", nil), ast: data.fetch("AST", nil),
       stats_timeframe: data.fetch("STATS_TIMEFRAME", nil), from_year: data.fetch("FROM_YEAR", nil),
       to_year: data.fetch("TO_YEAR", nil), is_defunct: data.fetch("IS_DEFUNCT", nil)}
    end
    private_class_method :stats_info
  end
end
