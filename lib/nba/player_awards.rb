require "json"
require_relative "client"
require_relative "collection"

module NBA
  # Represents a player's award
  class Award < Shale::Mapper
    include Equalizer.new(:player_id, :description, :season)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     award.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] first_name
    #   Returns the player's first name
    #   @api public
    #   @example
    #     award.first_name #=> "Stephen"
    #   @return [String] the first name
    attribute :first_name, Shale::Type::String

    # @!attribute [rw] last_name
    #   Returns the player's last name
    #   @api public
    #   @example
    #     award.last_name #=> "Curry"
    #   @return [String] the last name
    attribute :last_name, Shale::Type::String

    # @!attribute [rw] team
    #   Returns the team name
    #   @api public
    #   @example
    #     award.team #=> "Golden State Warriors"
    #   @return [String] the team name
    attribute :team, Shale::Type::String

    # @!attribute [rw] description
    #   Returns the award description
    #   @api public
    #   @example
    #     award.description #=> "All-NBA"
    #   @return [String] the award description
    attribute :description, Shale::Type::String

    # @!attribute [rw] all_nba_team_number
    #   Returns the All-NBA team number (1st, 2nd, 3rd)
    #   @api public
    #   @example
    #     award.all_nba_team_number #=> 1
    #   @return [Integer] the team number
    attribute :all_nba_team_number, Shale::Type::Integer

    # @!attribute [rw] season
    #   Returns the season
    #   @api public
    #   @example
    #     award.season #=> "2023-24"
    #   @return [String] the season
    attribute :season, Shale::Type::String

    # @!attribute [rw] month
    #   Returns the month (for monthly awards)
    #   @api public
    #   @example
    #     award.month #=> 11
    #   @return [Integer] the month
    attribute :month, Shale::Type::Integer

    # @!attribute [rw] week
    #   Returns the week (for weekly awards)
    #   @api public
    #   @example
    #     award.week #=> 5
    #   @return [Integer] the week
    attribute :week, Shale::Type::Integer

    # @!attribute [rw] conference
    #   Returns the conference
    #   @api public
    #   @example
    #     award.conference #=> "West"
    #   @return [String] the conference
    attribute :conference, Shale::Type::String

    # @!attribute [rw] award_type
    #   Returns the award type
    #   @api public
    #   @example
    #     award.award_type #=> "All-Star"
    #   @return [String] the award type
    attribute :award_type, Shale::Type::String

    # @!attribute [rw] subtype1
    #   Returns the award subtype 1
    #   @api public
    #   @example
    #     award.subtype1 #=> "Guard"
    #   @return [String] the subtype
    attribute :subtype1, Shale::Type::String

    # @!attribute [rw] subtype2
    #   Returns the award subtype 2
    #   @api public
    #   @example
    #     award.subtype2 #=> "Starter"
    #   @return [String] the subtype
    attribute :subtype2, Shale::Type::String

    # @!attribute [rw] subtype3
    #   Returns the award subtype 3
    #   @api public
    #   @example
    #     award.subtype3 #=> nil
    #   @return [String] the subtype
    attribute :subtype3, Shale::Type::String

    # Returns the player object
    #
    # @api public
    # @example
    #   award.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end
  end

  # Provides methods to retrieve player awards
  module PlayerAwards
    # Result set name for player awards
    # @return [String] the result set name
    PLAYER_AWARDS = "PlayerAwards".freeze

    # Retrieves all awards for a player
    #
    # @api public
    # @example
    #   awards = NBA::PlayerAwards.find(player: 201939)
    #   awards.each { |a| puts "#{a.season}: #{a.description}" }
    # @param player [Integer, Player] the player ID or Player object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of awards
    def self.find(player:, client: CLIENT)
      player_id = extract_player_id(player)
      path = "playerawards?PlayerID=#{player_id}"
      response = client.get(path)
      parse_response(response, player_id)
    end

    # Parses the API response into award objects
    # @api private
    # @return [Collection] collection of awards
    def self.parse_response(response, player_id)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      awards = rows.map { |row| build_award(headers, row, player_id) }
      Collection.new(awards)
    end
    private_class_method :parse_response

    # Finds the player awards result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name").eql?(PLAYER_AWARDS) }
    end
    private_class_method :find_result_set

    # Builds an Award object from raw data
    # @api private
    # @return [Award] the award object
    def self.build_award(headers, row, player_id)
      data = headers.zip(row).to_h
      Award.new(**award_attributes(data, player_id))
    end
    private_class_method :build_award

    # Combines all award attributes
    # @api private
    # @return [Hash] the combined attributes
    def self.award_attributes(data, player_id)
      identity_attributes(data, player_id).merge(award_info_attributes(data))
    end
    private_class_method :award_attributes

    # Extracts identity attributes from data
    # @api private
    # @return [Hash] identity attributes
    def self.identity_attributes(data, player_id)
      {player_id: player_id, first_name: data.fetch("FIRST_NAME"), last_name: data.fetch("LAST_NAME"),
       team: data.fetch("TEAM"), description: data.fetch("DESCRIPTION")}
    end
    private_class_method :identity_attributes

    # Extracts award info attributes from data
    # @api private
    # @return [Hash] award info attributes
    def self.award_info_attributes(data)
      {all_nba_team_number: data.fetch("ALL_NBA_TEAM_NUMBER"), season: data.fetch("SEASON"),
       month: data.fetch("MONTH"), week: data.fetch("WEEK"), conference: data.fetch("CONFERENCE"),
       award_type: data.fetch("TYPE"), subtype1: data.fetch("SUBTYPE1"),
       subtype2: data.fetch("SUBTYPE2"), subtype3: data.fetch("SUBTYPE3")}
    end
    private_class_method :award_info_attributes

    # Extracts player ID from a Player object or returns the integer
    #
    # @api private
    # @param player [Player, Integer] the player or player ID
    # @return [Integer] the player ID
    def self.extract_player_id(player)
      case player
      when Player then player.id
      else player
      end
    end
    private_class_method :extract_player_id
  end
end
