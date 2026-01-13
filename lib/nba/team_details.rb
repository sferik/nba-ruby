require "json"
require_relative "client"
require_relative "collection"
require_relative "team_detail"
require_relative "team_historical_record"

module NBA
  # Provides methods to retrieve team details
  module TeamDetails
    # Result set name for team background
    # @return [String] the result set name
    TEAM_BACKGROUND = "TeamBackground".freeze

    # Result set name for team history
    # @return [String] the result set name
    TEAM_HISTORY = "TeamHistory".freeze

    # Retrieves detailed information for a team
    #
    # @api public
    # @example
    #   detail = NBA::TeamDetails.find(team: NBA::Team::GSW)
    #   puts "#{detail.full_name} plays at #{detail.arena}"
    # @param team [Integer, Team] the team ID or Team object
    # @param client [Client] the API client to use
    # @return [TeamDetail, nil] the team detail
    def self.find(team:, client: CLIENT)
      team_id = extract_team_id(team)
      path = "teamdetails?TeamID=#{team_id}"
      response = client.get(path)
      parse_detail_response(response)
    end

    # Retrieves historical records for a team
    #
    # @api public
    # @example
    #   history = NBA::TeamDetails.history(team: NBA::Team::GSW)
    #   history.each { |h| puts "#{h.year}: #{h.wins}-#{h.losses}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of historical records
    def self.history(team:, client: CLIENT)
      team_id = extract_team_id(team)
      path = "teamdetails?TeamID=#{team_id}"
      response = client.get(path)
      parse_history_response(response)
    end

    # Parses the API response into a team detail object
    # @api private
    # @return [TeamDetail, nil] the team detail
    def self.parse_detail_response(response)
      return unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, TEAM_BACKGROUND)
      return unless result_set

      headers = result_set["headers"]
      row = result_set.dig("rowSet", 0)
      return unless headers && row

      build_team_detail(headers, row)
    end
    private_class_method :parse_detail_response

    # Parses the API response into historical record objects
    # @api private
    # @return [Collection] collection of historical records
    def self.parse_history_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, TEAM_HISTORY)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      records = rows.map { |row| build_historical_record(headers, row) }
      Collection.new(records)
    end
    private_class_method :parse_history_response

    # Finds the specified result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data, name)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(name) }
    end
    private_class_method :find_result_set

    # Builds a TeamDetail object from raw data
    # @api private
    # @return [TeamDetail] the team detail object
    def self.build_team_detail(headers, row)
      data = headers.zip(row).to_h
      TeamDetail.new(**detail_attributes(data))
    end
    private_class_method :build_team_detail

    # Builds a TeamHistoricalRecord object from raw data
    # @api private
    # @return [TeamHistoricalRecord] the historical record object
    def self.build_historical_record(headers, row)
      data = headers.zip(row).to_h
      TeamHistoricalRecord.new(**history_attributes(data))
    end
    private_class_method :build_historical_record

    # Extracts team detail attributes from data
    # @api private
    # @return [Hash] detail attributes
    def self.detail_attributes(data)
      {team_id: data.fetch("TEAM_ID"), abbreviation: data.fetch("ABBREVIATION"),
       nickname: data.fetch("NICKNAME"), year_founded: data.fetch("YEARFOUNDED"),
       city: data.fetch("CITY"), arena: data.fetch("ARENA"),
       arena_capacity: data.fetch("ARENACAPACITY"), owner: data.fetch("OWNER"),
       general_manager: data.fetch("GENERALMANAGER"), head_coach: data.fetch("HEADCOACH"),
       d_league_affiliation: data.fetch("DLEAGUEAFFILIATION")}
    end
    private_class_method :detail_attributes

    # Combines all history attributes
    # @api private
    # @return [Hash] the combined attributes
    def self.history_attributes(data)
      identity_history_attributes(data).merge(record_attributes(data), playoff_attributes(data))
    end
    private_class_method :history_attributes

    # Extracts identity history attributes from data
    # @api private
    # @return [Hash] identity history attributes
    def self.identity_history_attributes(data)
      {team_id: data.fetch("TEAM_ID"), city: data.fetch("CITY"), nickname: data.fetch("NICKNAME"),
       season_id: data.fetch("SEASON_ID"), year: data.fetch("YEAR")}
    end
    private_class_method :identity_history_attributes

    # Extracts record attributes from data
    # @api private
    # @return [Hash] record attributes
    def self.record_attributes(data)
      {wins: data.fetch("WINS"), losses: data.fetch("LOSSES"), win_pct: data.fetch("WIN_PCT"),
       conf_rank: data.fetch("CONF_RANK"), div_rank: data.fetch("DIV_RANK")}
    end
    private_class_method :record_attributes

    # Extracts playoff attributes from data
    # @api private
    # @return [Hash] playoff attributes
    def self.playoff_attributes(data)
      {po_wins: data.fetch("PO_WINS"), po_losses: data.fetch("PO_LOSSES"),
       conf_count: data.fetch("CONF_COUNT"), div_count: data.fetch("DIV_COUNT"),
       nba_finals_appearance: data.fetch("NBA_FINALS_APPEARANCE")}
    end
    private_class_method :playoff_attributes

    # Extracts team ID from team object or integer
    # @api private
    # @return [Integer] the team ID
    def self.extract_team_id(team)
      team.instance_of?(Team) ? team.id : team
    end
    private_class_method :extract_team_id
  end
end
