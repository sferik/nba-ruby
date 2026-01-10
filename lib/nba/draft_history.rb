require "json"
require_relative "client"
require_relative "collection"

module NBA
  # Represents a draft pick
  class DraftPick < Shale::Mapper
    include Equalizer.new(:player_id, :season)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     pick.player_id #=> 1630162
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] season
    #   Returns the draft season/year
    #   @api public
    #   @example
    #     pick.season #=> 2023
    #   @return [Integer] the season
    attribute :season, Shale::Type::Integer

    # @!attribute [rw] round_number
    #   Returns the round number
    #   @api public
    #   @example
    #     pick.round_number #=> 1
    #   @return [Integer] the round number
    attribute :round_number, Shale::Type::Integer

    # @!attribute [rw] round_pick
    #   Returns the pick number within the round
    #   @api public
    #   @example
    #     pick.round_pick #=> 1
    #   @return [Integer] the round pick
    attribute :round_pick, Shale::Type::Integer

    # @!attribute [rw] overall_pick
    #   Returns the overall pick number
    #   @api public
    #   @example
    #     pick.overall_pick #=> 1
    #   @return [Integer] the overall pick
    attribute :overall_pick, Shale::Type::Integer

    # @!attribute [rw] draft_type
    #   Returns the draft type
    #   @api public
    #   @example
    #     pick.draft_type #=> "Draft"
    #   @return [String] the draft type
    attribute :draft_type, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID that drafted the player
    #   @api public
    #   @example
    #     pick.team_id #=> 1610612759
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_city
    #   Returns the team city
    #   @api public
    #   @example
    #     pick.team_city #=> "San Antonio"
    #   @return [String] the team city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     pick.team_name #=> "Spurs"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     pick.team_abbreviation #=> "SAS"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     pick.player_name #=> "Victor Wembanyama"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] position
    #   Returns the player's position
    #   @api public
    #   @example
    #     pick.position #=> "C"
    #   @return [String] the position
    attribute :position, Shale::Type::String

    # @!attribute [rw] height
    #   Returns the player's height
    #   @api public
    #   @example
    #     pick.height #=> "7-4"
    #   @return [String] the height
    attribute :height, Shale::Type::String

    # @!attribute [rw] weight
    #   Returns the player's weight
    #   @api public
    #   @example
    #     pick.weight #=> 210
    #   @return [Integer] the weight
    attribute :weight, Shale::Type::Integer

    # @!attribute [rw] college
    #   Returns the player's college
    #   @api public
    #   @example
    #     pick.college #=> "France"
    #   @return [String] the college
    attribute :college, Shale::Type::String

    # @!attribute [rw] country
    #   Returns the player's country
    #   @api public
    #   @example
    #     pick.country #=> "France"
    #   @return [String] the country
    attribute :country, Shale::Type::String

    # Returns the player object
    #
    # @api public
    # @example
    #   pick.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns the team object
    #
    # @api public
    # @example
    #   pick.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end

  # Provides methods to retrieve draft history
  module DraftHistory
    # Result set name for draft history
    # @return [String] the result set name
    DRAFT_HISTORY = "DraftHistory".freeze

    # Retrieves all draft picks for a season
    #
    # @api public
    # @example
    #   picks = NBA::DraftHistory.all(season: 2023)
    #   picks.each { |p| puts "#{p.overall_pick}. #{p.player_name}" }
    # @param season [Integer] the draft year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of draft picks
    def self.all(season: nil, league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      path = build_path(season, league_id)
      response = client.get(path)
      parse_response(response)
    end

    # Retrieves draft picks for a specific team
    #
    # @api public
    # @example
    #   picks = NBA::DraftHistory.by_team(team: NBA::Team::GSW, season: 2023)
    #   picks.each { |p| puts "#{p.round_number}.#{p.round_pick}: #{p.player_name}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the draft year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of draft picks
    def self.by_team(team:, season: nil, league: League::NBA, client: CLIENT)
      team_id = extract_team_id(team)
      all_picks = all(season: season, league: league, client: client)
      filtered = all_picks.select { |pick| pick.team_id.eql?(team_id) }
      Collection.new(filtered)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(season, league_id)
      season_param = season && "&Season=#{season}"
      "drafthistory?LeagueID=#{league_id}#{season_param}"
    end
    private_class_method :build_path

    # Parses the API response into draft pick objects
    # @api private
    # @return [Collection] collection of draft picks
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      picks = rows.map { |row| build_draft_pick(headers, row) }
      Collection.new(picks)
    end
    private_class_method :parse_response

    # Finds the draft history result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(DRAFT_HISTORY) }
    end
    private_class_method :find_result_set

    # Builds a DraftPick object from raw data
    # @api private
    # @return [DraftPick] the draft pick object
    def self.build_draft_pick(headers, row)
      data = headers.zip(row).to_h
      DraftPick.new(**draft_pick_attributes(data))
    end
    private_class_method :build_draft_pick

    # Combines all draft pick attributes
    # @api private
    # @return [Hash] the combined attributes
    def self.draft_pick_attributes(data)
      pick_info_attributes(data).merge(team_attributes(data), player_attributes(data))
    end
    private_class_method :draft_pick_attributes

    # Extracts pick info attributes from data
    # @api private
    # @return [Hash] pick info attributes
    def self.pick_info_attributes(data)
      {player_id: data.fetch("PERSON_ID", nil), season: data.fetch("SEASON", nil),
       round_number: data.fetch("ROUND_NUMBER", nil), round_pick: data.fetch("ROUND_PICK", nil),
       overall_pick: data.fetch("OVERALL_PICK", nil), draft_type: data.fetch("DRAFT_TYPE", nil)}
    end
    private_class_method :pick_info_attributes

    # Extracts team attributes from data
    # @api private
    # @return [Hash] team attributes
    def self.team_attributes(data)
      {team_id: data.fetch("TEAM_ID", nil), team_city: data.fetch("TEAM_CITY", nil),
       team_name: data.fetch("TEAM_NAME", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil)}
    end
    private_class_method :team_attributes

    # Extracts player attributes from data
    # @api private
    # @return [Hash] player attributes
    def self.player_attributes(data)
      {player_name: data.fetch("PLAYER_NAME", nil), position: data.fetch("POSITION", nil),
       height: data.fetch("HEIGHT", nil), weight: data.fetch("WEIGHT", nil),
       college: data.fetch("ORGANIZATION", nil), country: data.fetch("PLAYER_PROFILE_FLAG", nil)}
    end
    private_class_method :player_attributes

    # Extracts team ID from team object or integer
    # @api private
    # @return [Integer] the team ID
    def self.extract_team_id(team)
      team.instance_of?(Team) ? team.id : team
    end
    private_class_method :extract_team_id
  end
end
