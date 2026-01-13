require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

require_relative "box_score_similarity_stat"

module NBA
  # Provides methods to retrieve G League Alum box score similarity scores
  module BoxScoreSimilarityScore
    # Result set name for similarity scores
    # @return [String] the result set name
    RESULT_SET_NAME = "GLeagueAlumBoxScoreSimilarityScores".freeze

    # Regular season type constant
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Playoffs season type constant
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Retrieves box score similarity scores for two players
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreSimilarityScore.find(first_person: 201939, second_person: 203507)
    #   stats.first.similarity_score #=> 0.85
    # @param first_person [Integer, Player] the first player ID or Player object
    # @param second_person [Integer, Player] the second player ID or Player object
    # @param first_season [Integer] the season year for first player
    # @param second_season [Integer] the season year for second player
    # @param first_season_type [String] the season type for first player
    # @param second_season_type [String] the season type for second player
    # @param client [Client] the API client to use
    # @return [Collection] a collection of similarity stats
    def self.find(first_person:, second_person:, first_season: Utils.current_season, second_season: Utils.current_season,
      first_season_type: REGULAR_SEASON, second_season_type: REGULAR_SEASON, client: CLIENT)
      first_id = Utils.extract_id(first_person)
      second_id = Utils.extract_id(second_person)
      path = build_path(first_id: first_id, second_id: second_id, first_season: first_season, second_season: second_season,
        first_season_type: first_season_type, second_season_type: second_season_type)
      response = client.get(path)
      parse_response(response, first_id)
    end

    # Builds the API path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(opts)
      "glalumboxscoresimilarityscore?Person1Id=#{opts[:first_id]}&Person2Id=#{opts[:second_id]}" \
        "&Person1LeagueId=00&Person2LeagueId=00" \
        "&Person1Season=#{Utils.format_season(opts[:first_season])}&Person2Season=#{Utils.format_season(opts[:second_season])}" \
        "&Person1SeasonType=#{opts[:first_season_type]}&Person2SeasonType=#{opts[:second_season_type]}"
    end
    private_class_method :build_path

    # Parses the API response into stat objects
    #
    # @api private
    # @return [Collection] collection of similarity stats
    def self.parse_response(response, first_person_id)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      build_stats(result_set, first_person_id)
    end
    private_class_method :parse_response

    # Finds the result set by name
    #
    # @api private
    # @return [Hash, nil] the result set hash or nil if not found
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(RESULT_SET_NAME) }
    end
    private_class_method :find_result_set

    # Builds stats collection from result set
    #
    # @api private
    # @return [Collection] the stats collection
    def self.build_stats(result_set, first_person_id)
      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      Collection.new(rows.map { |row| build_stat(headers.zip(row).to_h, first_person_id) })
    end
    private_class_method :build_stats

    # Builds a single stat object from API data
    #
    # @api private
    # @return [BoxScoreSimilarityStat] the stat object
    def self.build_stat(data, first_person_id)
      BoxScoreSimilarityStat.new(**stat_attributes(data, first_person_id))
    end
    private_class_method :build_stat

    # Extracts stat attributes from data
    #
    # @api private
    # @return [Hash] the stat attributes
    def self.stat_attributes(data, first_person_id)
      {first_person_id: first_person_id, second_person_id: data["PERSON_2_ID"],
       second_person_name: data["PERSON_2"], team_id: data["TEAM_ID"],
       similarity_score: data["SIMILARITY_SCORE"]}
    end
    private_class_method :stat_attributes
  end
end
