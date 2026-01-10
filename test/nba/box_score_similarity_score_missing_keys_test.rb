require_relative "../test_helper"

module NBA
  class BoxScoreSimilarityScoreMissingKeysTest < Minitest::Test
    cover BoxScoreSimilarityScore

    def test_find_handles_missing_person_2_id_key
      response = {resultSets: [{name: "GLeagueAlumBoxScoreSimilarityScores",
                                headers: %w[PERSON_2 TEAM_ID SIMILARITY_SCORE],
                                rowSet: [["Giannis", Team::MIL, 0.85]]}]}
      stub_request(:get, /glalumboxscoresimilarityscore/).to_return(body: response.to_json)

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_nil result.first.second_person_id
    end

    def test_find_handles_missing_person_2_key
      response = {resultSets: [{name: "GLeagueAlumBoxScoreSimilarityScores",
                                headers: %w[PERSON_2_ID TEAM_ID SIMILARITY_SCORE],
                                rowSet: [[203_507, Team::MIL, 0.85]]}]}
      stub_request(:get, /glalumboxscoresimilarityscore/).to_return(body: response.to_json)

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_nil result.first.second_person_name
    end

    def test_find_handles_missing_team_id_key
      response = {resultSets: [{name: "GLeagueAlumBoxScoreSimilarityScores",
                                headers: %w[PERSON_2_ID PERSON_2 SIMILARITY_SCORE],
                                rowSet: [[203_507, "Giannis", 0.85]]}]}
      stub_request(:get, /glalumboxscoresimilarityscore/).to_return(body: response.to_json)

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_nil result.first.team_id
    end

    def test_find_handles_missing_similarity_score_key
      response = {resultSets: [{name: "GLeagueAlumBoxScoreSimilarityScores",
                                headers: %w[PERSON_2_ID PERSON_2 TEAM_ID],
                                rowSet: [[203_507, "Giannis", Team::MIL]]}]}
      stub_request(:get, /glalumboxscoresimilarityscore/).to_return(body: response.to_json)

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_nil result.first.similarity_score
    end
  end
end
