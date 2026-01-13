require "json"
require_relative "client"
require_relative "franchise_leader"

module NBA
  # Provides methods to retrieve franchise leaders
  module FranchiseLeaders
    # Result set name for franchise leaders
    # @return [String] the result set name
    RESULTS = "FranchiseLeaders".freeze

    # Retrieves franchise leaders for a team
    #
    # @api public
    # @example
    #   leader = NBA::FranchiseLeaders.find(team: NBA::Team::GSW)
    #   puts "Points: #{leader.pts_player_name} (#{leader.pts})"
    # @param team [Integer, Team] the team ID or Team object
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [FranchiseLeader, nil] the franchise leader
    def self.find(team:, league: League::NBA, client: CLIENT)
      team_id = extract_team_id(team)
      league_id = Utils.extract_league_id(league)
      path = "franchiseleaders?TeamID=#{team_id}&LeagueID=#{league_id}"
      response = client.get(path)
      parse_response(response)
    end

    # Parses the API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [FranchiseLeader, nil] the franchise leader
    def self.parse_response(response)
      return unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, RESULTS)
      return unless result_set

      headers = result_set["headers"]
      row = result_set.dig("rowSet", 0)
      return unless headers && row

      build_franchise_leader(headers, row)
    end
    private_class_method :parse_response

    # Finds a result set by name
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @param name [String] the result set name
    # @return [Hash, nil] the result set
    def self.find_result_set(data, name)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(name) }
    end
    private_class_method :find_result_set

    # Builds a franchise leader from a row
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [FranchiseLeader] the franchise leader object
    def self.build_franchise_leader(headers, row)
      data = headers.zip(row).to_h
      FranchiseLeader.new(**franchise_leader_attributes(data))
    end
    private_class_method :build_franchise_leader

    # Extracts franchise leader attributes from row data
    #
    # @api private
    # @param data [Hash] the franchise leader row data
    # @return [Hash] the franchise leader attributes
    def self.franchise_leader_attributes(data)
      team_attributes(data).merge(points_attributes(data), assists_attributes(data),
        rebounds_attributes(data), blocks_attributes(data), steals_attributes(data))
    end
    private_class_method :franchise_leader_attributes

    # Extracts team attributes
    #
    # @api private
    # @param data [Hash] the franchise leader data
    # @return [Hash] the team attributes
    def self.team_attributes(data)
      {team_id: data.fetch("TEAM_ID")}
    end
    private_class_method :team_attributes

    # Extracts points leader attributes
    #
    # @api private
    # @param data [Hash] the franchise leader data
    # @return [Hash] the points attributes
    def self.points_attributes(data)
      {pts_person_id: data.fetch("PTS_PERSON_ID"), pts_player_name: data.fetch("PTS_PLAYER"),
       pts: data.fetch("PTS")}
    end
    private_class_method :points_attributes

    # Extracts assists leader attributes
    #
    # @api private
    # @param data [Hash] the franchise leader data
    # @return [Hash] the assists attributes
    def self.assists_attributes(data)
      {ast_person_id: data.fetch("AST_PERSON_ID"), ast_player_name: data.fetch("AST_PLAYER"),
       ast: data.fetch("AST")}
    end
    private_class_method :assists_attributes

    # Extracts rebounds leader attributes
    #
    # @api private
    # @param data [Hash] the franchise leader data
    # @return [Hash] the rebounds attributes
    def self.rebounds_attributes(data)
      {reb_person_id: data.fetch("REB_PERSON_ID"), reb_player_name: data.fetch("REB_PLAYER"),
       reb: data.fetch("REB")}
    end
    private_class_method :rebounds_attributes

    # Extracts blocks leader attributes
    #
    # @api private
    # @param data [Hash] the franchise leader data
    # @return [Hash] the blocks attributes
    def self.blocks_attributes(data)
      {blk_person_id: data.fetch("BLK_PERSON_ID"), blk_player_name: data.fetch("BLK_PLAYER"),
       blk: data.fetch("BLK")}
    end
    private_class_method :blocks_attributes

    # Extracts steals leader attributes
    #
    # @api private
    # @param data [Hash] the franchise leader data
    # @return [Hash] the steals attributes
    def self.steals_attributes(data)
      {stl_person_id: data.fetch("STL_PERSON_ID"), stl_player_name: data.fetch("STL_PLAYER"),
       stl: data.fetch("STL")}
    end
    private_class_method :steals_attributes

    # Extracts team ID from team object or integer
    #
    # @api private
    # @param team [Integer, Team] the team ID or Team object
    # @return [Integer] the team ID
    def self.extract_team_id(team)
      team.instance_of?(Team) ? team.id : team
    end
    private_class_method :extract_team_id
  end
end
