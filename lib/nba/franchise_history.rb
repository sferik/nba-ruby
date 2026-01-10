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

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
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
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(name) }
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
      {league_id: data.fetch("LEAGUE_ID", nil), team_id: data.fetch("TEAM_ID", nil), team_city: data.fetch("TEAM_CITY", nil),
       team_name: data.fetch("TEAM_NAME", nil)}
    end
    private_class_method :identity_attributes

    # Extracts history attributes
    #
    # @api private
    # @param data [Hash] the franchise data
    # @return [Hash] the history attributes
    def self.history_attributes(data)
      {start_year: data.fetch("START_YEAR", nil), end_year: data.fetch("END_YEAR", nil),
       years: data.fetch("YEARS", nil), games: data.fetch("GAMES", nil),
       wins: data.fetch("WINS", nil), losses: data.fetch("LOSSES", nil),
       win_pct: data.fetch("WIN_PCT", nil)}
    end
    private_class_method :history_attributes

    # Extracts title/championship attributes
    #
    # @api private
    # @param data [Hash] the franchise data
    # @return [Hash] the title attributes
    def self.title_attributes(data)
      {po_appearances: data.fetch("PO_APPEARANCES", nil), div_titles: data.fetch("DIV_TITLES", nil),
       conf_titles: data.fetch("CONF_TITLES", nil), league_titles: data.fetch("LEAGUE_TITLES", nil)}
    end
    private_class_method :title_attributes
  end
end
