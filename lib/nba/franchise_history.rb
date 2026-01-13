require "json"
require_relative "client"
require_relative "collection"
require_relative "franchise"

module NBA
  # Provides methods to retrieve franchise history
  module FranchiseHistory
    # Result set name for franchise history
    # @return [String] the result set name
    FRANCHISE_HISTORY = "FranchiseHistory".freeze

    # Result set name for defunct teams
    # @return [String] the result set name
    DEFUNCT_TEAMS = "DefunctTeams".freeze

    # Retrieves all franchise history data
    #
    # @api public
    # @example
    #   franchises = NBA::FranchiseHistory.all
    #   franchises.each { |f| puts "#{f.team_city} #{f.team_name}: #{f.league_titles} titles" }
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of franchises
    def self.all(league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      path = "franchisehistory?LeagueID=#{league_id}"
      response = client.get(path)
      parse_response(response, FRANCHISE_HISTORY)
    end

    # Retrieves defunct team history data
    #
    # @api public
    # @example
    #   defunct = NBA::FranchiseHistory.defunct
    #   defunct.each { |f| puts "#{f.team_city} #{f.team_name}: #{f.start_year}-#{f.end_year}" }
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of defunct franchises
    def self.defunct(league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      path = "franchisehistory?LeagueID=#{league_id}"
      response = client.get(path)
      parse_response(response, DEFUNCT_TEAMS)
    end

    # Parses the API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @param result_set_name [String] the name of the result set to extract
    # @return [Collection] a collection of franchises
    def self.parse_response(response, result_set_name)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, result_set_name)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      franchises = rows.map { |row| build_franchise(headers, row) }
      Collection.new(franchises)
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

    # Builds a franchise from a row
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [Franchise] the franchise object
    def self.build_franchise(headers, row)
      data = headers.zip(row).to_h
      Franchise.new(**franchise_attributes(data))
    end
    private_class_method :build_franchise

    # Extracts franchise attributes from row data
    #
    # @api private
    # @param data [Hash] the franchise row data
    # @return [Hash] the franchise attributes
    def self.franchise_attributes(data)
      identity_attributes(data).merge(history_attributes(data), title_attributes(data))
    end
    private_class_method :franchise_attributes

    # Extracts identity attributes
    #
    # @api private
    # @param data [Hash] the franchise data
    # @return [Hash] the identity attributes
    def self.identity_attributes(data)
      {league_id: data["LEAGUE_ID"], team_id: data["TEAM_ID"], team_city: data["TEAM_CITY"],
       team_name: data["TEAM_NAME"]}
    end
    private_class_method :identity_attributes

    # Extracts history attributes
    #
    # @api private
    # @param data [Hash] the franchise data
    # @return [Hash] the history attributes
    def self.history_attributes(data)
      {start_year: data["START_YEAR"], end_year: data["END_YEAR"],
       years: data["YEARS"], games: data["GAMES"],
       wins: data["WINS"], losses: data["LOSSES"],
       win_pct: data["WIN_PCT"]}
    end
    private_class_method :history_attributes

    # Extracts title/championship attributes
    #
    # @api private
    # @param data [Hash] the franchise data
    # @return [Hash] the title attributes
    def self.title_attributes(data)
      {po_appearances: data["PO_APPEARANCES"], div_titles: data["DIV_TITLES"],
       conf_titles: data["CONF_TITLES"], league_titles: data["LEAGUE_TITLES"]}
    end
    private_class_method :title_attributes
  end
end
