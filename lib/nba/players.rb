require_relative "client"
require_relative "response_parser"
require_relative "player"
require_relative "utils"

module NBA
  # Provides methods to retrieve NBA players
  module Players
    # Retrieves all NBA players
    #
    # @api public
    # @example
    #   players = NBA::Players.all
    #   players.each { |player| puts player.full_name }
    # @param season [Integer] the season year (defaults to current season)
    # @param only_current [Boolean] whether to only return current players
    # @param client [Client] the API client to use
    # @return [Collection] a collection of all players
    def self.all(season: Utils.current_season, only_current: true, client: CLIENT)
      current_flag = only_current ? 1 : 0
      path = "commonallplayers?LeagueID=00&Season=#{Utils.format_season(season)}&IsOnlyCurrentSeason=#{current_flag}"
      ResponseParser.parse(client.get(path)) { |data| build_player_summary(data) }
    end

    # Finds a player by ID
    #
    # @api public
    # @example
    #   roster = NBA::Roster.find(team: NBA::Team::GSW)
    #   curry = roster.find { |p| p.jersey_number == 30 }
    #   player = NBA::Players.find(curry.id)
    # @param player_id [Integer, Player] the player ID or Player object
    # @param client [Client] the API client to use
    # @return [Player, nil] the player with the given ID, or nil if not found
    def self.find(player_id, client: CLIENT)
      id = Utils.extract_id(player_id)
      return unless id

      path = "commonplayerinfo?PlayerID=#{id}"
      ResponseParser.parse_single(client.get(path)) { |data| build_player_detail(data) }
    end

    # Builds a player summary from list data
    #
    # @api private
    # @param data [Hash] the player row data
    # @return [Player] the player object
    def self.build_player_summary(data)
      full_name = data.fetch("DISPLAY_FIRST_LAST")
      Player.new(
        id: data.fetch("PERSON_ID"),
        full_name: full_name,
        first_name: full_name&.split&.first,
        last_name: full_name&.split&.last,
        is_active: [1, "Active"].include?(data["ROSTERSTATUS"])
      )
    end
    private_class_method :build_player_summary

    # Builds a player detail from API data
    # @api private
    # @return [Player]
    def self.build_player_detail(data)
      Player.new(**identity_info(data), **physical_info(data), **draft_info(data))
    end
    private_class_method :build_player_detail

    # Extracts identity information from data
    # @api private
    # @return [Hash]
    def self.identity_info(data)
      {id: data.fetch("PERSON_ID"), full_name: data.fetch("DISPLAY_FIRST_LAST"),
       first_name: data["FIRST_NAME"], last_name: data["LAST_NAME"],
       is_active: [1, "Active"].include?(data["ROSTERSTATUS"])}
    end
    private_class_method :identity_info

    # Extracts physical information from data
    # @api private
    # @return [Hash]
    def self.physical_info(data)
      {jersey_number: Utils.parse_integer(data["JERSEY"]), height: data["HEIGHT"],
       weight: Utils.parse_integer(data["WEIGHT"]), college: data["SCHOOL"], country: data["COUNTRY"]}
    end
    private_class_method :physical_info

    # Extracts draft information from data
    # @api private
    # @return [Hash]
    def self.draft_info(data)
      {draft_year: Utils.parse_integer(data["DRAFT_YEAR"]), draft_round: Utils.parse_integer(data["DRAFT_ROUND"]),
       draft_number: Utils.parse_integer(data["DRAFT_NUMBER"])}
    end
    private_class_method :draft_info
  end
end
