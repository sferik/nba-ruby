require_relative "../../test_helper"

module NBA
  class BoxScoreSimilarityScoreTest < Minitest::Test
    cover BoxScoreSimilarityScore

    def test_find_returns_collection
      stub_similarity_request

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_instance_of Collection, result
    end

    def test_find_builds_correct_path
      stub_similarity_request

      BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507, first_season: 2023, second_season: 2023)

      assert_requested :get, /Person1Id=201939/
      assert_requested :get, /Person2Id=203507/
      assert_requested :get, /Person1Season=2023-24/
      assert_requested :get, /Person2Season=2023-24/
    end

    def test_find_returns_empty_collection_for_missing_result_sets
      stub_request(:get, /glalumboxscoresimilarityscore/).to_return(body: {}.to_json)

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_instance_of Collection, result
      assert_predicate result, :empty?
    end

    def test_find_returns_empty_collection_for_missing_named_result_set
      response = {resultSets: [{name: "OtherResultSet", headers: [], rowSet: []}]}
      stub_request(:get, /glalumboxscoresimilarityscore/).to_return(body: response.to_json)

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_instance_of Collection, result
      assert_predicate result, :empty?
    end

    def test_find_parses_similarity_scores
      stub_similarity_request

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_equal 1, result.size
      assert_equal 201_939, result.first.first_person_id
      assert_equal 203_507, result.first.second_person_id
      assert_equal "Giannis Antetokounmpo", result.first.second_person_name
      assert_equal Team::MIL, result.first.team_id
    end

    def test_find_accepts_player_objects
      stub_similarity_request
      player1 = Player.new(id: 201_939)
      player2 = Player.new(id: 203_507)

      BoxScoreSimilarityScore.find(first_person: player1, second_person: player2)

      assert_requested :get, /Person1Id=201939/
      assert_requested :get, /Person2Id=203507/
    end

    def test_find_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, similarity_response.to_json, [String]

      BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507, client: mock_client)

      mock_client.verify
    end

    def test_find_returns_empty_collection_when_client_returns_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_find_extracts_similarity_score_attribute
      stub_similarity_request

      result = BoxScoreSimilarityScore.find(first_person: 201_939, second_person: 203_507)

      assert_in_delta 0.85, result.first.similarity_score, 0.001
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
