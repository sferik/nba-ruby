require_relative "../../test_helper"

module NBA
  class BoxScoreSimilarityScoreEdgeCasesTest < Minitest::Test
    cover BoxScoreSimilarityScore

    def test_find_uses_default_regular_season_type
      stub_similarity_request

      BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_requested :get, /Person1SeasonType=Regular%20Season/
      assert_requested :get, /Person2SeasonType=Regular%20Season/
    end

    def test_find_accepts_custom_season_types
      stub_similarity_request

      BoxScoreSimilarityScore.find(
        first_person: 201_939, second_person: 203_507,
        first_season_type: BoxScoreSimilarityScore::PLAYOFFS,
        second_season_type: BoxScoreSimilarityScore::PLAYOFFS
      )

      assert_requested :get, /Person1SeasonType=Playoffs/
      assert_requested :get, /Person2SeasonType=Playoffs/
    end

    def test_find_returns_empty_collection_for_missing_headers
      response = {resultSets: [{name: "GLeagueAlumBoxScoreSimilarityScores", rowSet: [[203_507, "Giannis", Team::MIL, 0.85]]}]}
      stub_request(:get, /glalumboxscoresimilarityscore/).to_return(body: response.to_json)

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_instance_of Collection, result
      assert_predicate result, :empty?
    end

    def test_find_returns_empty_collection_for_missing_row_set
      response = {resultSets: [{name: "GLeagueAlumBoxScoreSimilarityScores", headers: similarity_headers}]}
      stub_request(:get, /glalumboxscoresimilarityscore/).to_return(body: response.to_json)

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_instance_of Collection, result
      assert_predicate result, :empty?
    end

    def test_find_returns_empty_collection_when_result_sets_is_nil
      response = {resultSets: nil}
      stub_request(:get, /glalumboxscoresimilarityscore/).to_return(body: response.to_json)

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_empty result
    end

    def test_find_returns_empty_collection_when_result_set_name_does_not_match
      response = {resultSets: [{name: "DifferentName", headers: similarity_headers, rowSet: [similarity_row]}]}
      stub_request(:get, /glalumboxscoresimilarityscore/).to_return(body: response.to_json)

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_empty result
    end

    def test_find_uses_result_set_name_constant
      response = {resultSets: [{name: BoxScoreSimilarityScore::RESULT_SET_NAME, headers: similarity_headers, rowSet: [similarity_row]}]}
      stub_request(:get, /glalumboxscoresimilarityscore/).to_return(body: response.to_json)

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_equal 1, result.size
    end

    def test_find_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: similarity_headers, rowSet: [similarity_row]}]}
      stub_request(:get, /glalumboxscoresimilarityscore/).to_return(body: response.to_json)

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_empty result
    end

    private

    def stub_similarity_request
      stub_request(:get, /glalumboxscoresimilarityscore/).to_return(body: similarity_response.to_json)
    end

    def similarity_response
      {resultSets: [{name: "GLeagueAlumBoxScoreSimilarityScores", headers: similarity_headers, rowSet: [similarity_row]}]}
    end

    def similarity_headers
      %w[PERSON_2_ID PERSON_2 TEAM_ID SIMILARITY_SCORE]
    end

    def similarity_row
      [203_507, "Giannis Antetokounmpo", Team::MIL, 0.85]
    end
  end
end
