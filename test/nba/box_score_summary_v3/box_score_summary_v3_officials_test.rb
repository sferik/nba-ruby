require_relative "../../test_helper"

module NBA
  class BoxScoreSummaryV3OfficialsTest < Minitest::Test
    cover BoxScoreSummaryV3

    def test_handles_missing_officials_key
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response_without(:officials).to_json)

      assert_empty BoxScoreSummaryV3.find(game: "0022400001").officials
    end

    def test_handles_nil_officials
      response = base_response
      response[:boxScoreSummary][:officials] = nil
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_empty BoxScoreSummaryV3.find(game: "0022400001").officials
    end

    def test_handles_empty_officials_array
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_empty BoxScoreSummaryV3.find(game: "0022400001").officials
    end

    def test_parses_officials_names
      response = base_response
      response[:boxScoreSummary][:officials] = [{personId: 1, firstName: "Scott", familyName: "Foster"},
        {personId: 2, firstName: "Tony", familyName: "Brothers"}]
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_equal ["Scott Foster", "Tony Brothers"], BoxScoreSummaryV3.find(game: "0022400001").officials
    end

    def test_handles_official_missing_first_name
      response = base_response
      response[:boxScoreSummary][:officials] = [{personId: 1, familyName: "Foster"}]
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_empty BoxScoreSummaryV3.find(game: "0022400001").officials
    end

    def test_handles_official_missing_family_name
      response = base_response
      response[:boxScoreSummary][:officials] = [{personId: 1, firstName: "Scott"}]
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_empty BoxScoreSummaryV3.find(game: "0022400001").officials
    end

    def test_handles_official_nil_first_name
      response = base_response
      response[:boxScoreSummary][:officials] = [{personId: 1, firstName: nil, familyName: "Foster"}]
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_empty BoxScoreSummaryV3.find(game: "0022400001").officials
    end

    def test_handles_official_nil_family_name
      response = base_response
      response[:boxScoreSummary][:officials] = [{personId: 1, firstName: "Scott", familyName: nil}]
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_empty BoxScoreSummaryV3.find(game: "0022400001").officials
    end

    def test_filters_invalid_officials_from_list
      response = base_response
      response[:boxScoreSummary][:officials] = [{personId: 1, firstName: "Scott", familyName: "Foster"},
        {personId: 2, firstName: nil, familyName: "Brothers"},
        {personId: 3, firstName: "Marc", familyName: "Davis"}]
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_equal ["Scott Foster", "Marc Davis"], BoxScoreSummaryV3.find(game: "0022400001").officials
    end

    def test_officials_returns_array_of_strings
      response = base_response
      response[:boxScoreSummary][:officials] = [{personId: 1, firstName: "Scott", familyName: "Foster"}]
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)
      officials = BoxScoreSummaryV3.find(game: "0022400001").officials

      assert_instance_of String, officials.first
    end

    def test_officials_first_element_is_string_with_space
      response = base_response
      response[:boxScoreSummary][:officials] = [{personId: 1, firstName: "Scott", familyName: "Foster"}]
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)
      officials = BoxScoreSummaryV3.find(game: "0022400001").officials

      assert_includes officials.first, " "
    end

    private

    def base_response
      {boxScoreSummary: {gameId: "0022400001", gameStatus: 3, homeTeam: {}, awayTeam: {}, officials: []}}
    end

    def response_without(key)
      response = base_response
      response[:boxScoreSummary].delete(key)
      response
    end
  end
end
