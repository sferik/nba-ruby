require "json"
require_relative "client"
require_relative "collection"
require_relative "team_year"

module NBA
  # Provides methods to retrieve team year history
  module CommonTeamYears
    # Result set name
    # @return [String] the result set name
    TEAM_YEARS = "TeamYears".freeze

    # Retrieves all years a team has participated in the league
    #
    # @api public
    # @example
    #   years = NBA::CommonTeamYears.all
    #   gsw_years = years.select { |y| y.team_id == NBA::Team::GSW }
    #   puts "Warriors have played #{gsw_years.size} seasons"
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team years
    def self.all(client: CLIENT)
      path = "commonteamyears?LeagueID=00"
      response = client.get(path)
      parse_response(response)
    end

    # Retrieves years for a specific team
    #
    # @api public
    # @example
    #   years = NBA::CommonTeamYears.find(team: NBA::Team::GSW)
    #   puts "First year: #{years.first.year}, Latest: #{years.last.year}"
    # @param team [Integer, Team] the team ID or Team object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team years for the team
    def self.find(team:, client: CLIENT)
      team_id = extract_team_id(team)
      years = all(client: client)
      Collection.new(years.select { |y| y.team_id.eql?(team_id) })
    end

    # Parses the API response
    # @api private
    # @param response [String, nil] the JSON response
    # @return [Collection] collection of team years
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      build_team_years(result_set)
    end
    private_class_method :parse_response

    # Finds the result set
    # @api private
    # @param data [Hash] the parsed JSON
    # @return [Hash, nil] the result set
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name").eql?(TEAM_YEARS) }
    end
    private_class_method :find_result_set

    # Builds team years collection
    # @api private
    # @param result_set [Hash] the result set
    # @return [Collection] collection of team years
    def self.build_team_years(result_set)
      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      years = rows.map { |row| build_team_year(headers, row) }
      Collection.new(years)
    end
    private_class_method :build_team_years

    # Builds a team year
    # @api private
    # @param headers [Array<String>] the headers
    # @param row [Array] the row data
    # @return [TeamYear] the team year
    def self.build_team_year(headers, row)
      data = headers.zip(row).to_h
      TeamYear.new(**team_year_attributes(data))
    end
    private_class_method :build_team_year

    # Extracts team year attributes
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] the attributes
    def self.team_year_attributes(data)
      {team_id: data.fetch("TEAM_ID"), year: data.fetch("MAX_YEAR"), abbreviation: data.fetch("ABBREVIATION")}
    end
    private_class_method :team_year_attributes

    # Extracts team ID
    # @api private
    # @param team [Team, Integer] the team
    # @return [Integer, nil] the team ID
    def self.extract_team_id(team)
      team.instance_of?(Team) ? team.id : team
    end
    private_class_method :extract_team_id
  end
end
