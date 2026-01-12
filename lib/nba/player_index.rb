require_relative "client"
require_relative "response_parser"
require_relative "utils"

require_relative "player_index_entry"

module NBA
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
