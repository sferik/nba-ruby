require_relative "../../test_helper"

module NBA
  class ResponseParserSingleTest < Minitest::Test
    cover ResponseParser

    def test_parse_single_returns_nil_for_nil_response
      assert_nil ResponseParser.parse_single(nil, &:itself)
    end

    def test_parse_single_returns_nil_for_invalid_json
      assert_nil ResponseParser.parse_single("invalid", &:itself)
    end

    def test_parse_single_returns_nil_when_result_sets_missing
      assert_nil ResponseParser.parse_single("{}", &:itself)
    end

    def test_parse_single_returns_nil_when_result_set_not_found
      json = '{"resultSets": []}'

      assert_nil ResponseParser.parse_single(json, result_set: "Missing", &:itself)
    end

    def test_parse_single_returns_nil_when_headers_missing
      json = '{"resultSets": [{"name": "Test", "rowSet": [[1]]}]}'

      assert_nil ResponseParser.parse_single(json, result_set: "Test", &:itself)
    end

    def test_parse_single_returns_nil_when_first_row_missing
      json = '{"resultSets": [{"name": "Test", "headers": ["A"], "rowSet": []}]}'

      assert_nil ResponseParser.parse_single(json, result_set: "Test", &:itself)
    end

    def test_parse_single_builds_object_from_first_row
      json = '{"resultSets": [{"name": "Test", "headers": ["A", "B"], "rowSet": [[1, 2]]}]}'
      result = ResponseParser.parse_single(json, result_set: "Test") { |data| data }

      assert_equal({"A" => 1, "B" => 2}, result)
    end

    def test_parse_single_uses_first_row_when_multiple_exist
      json = '{"resultSets": [{"name": "Test", "headers": ["A"], "rowSet": [[1], [2], [3]]}]}'
      result = ResponseParser.parse_single(json, result_set: "Test") { |data| data["A"] }

      assert_equal 1, result
    end

    def test_parse_single_uses_named_result_set_not_first
      json = '{"resultSets": [{"name": "First", "headers": ["X"], "rowSet": [[100]]}, ' \
             '{"name": "Second", "headers": ["Y"], "rowSet": [[200]]}]}'
      result = ResponseParser.parse_single(json, result_set: "Second") { |data| data["Y"] || data["X"] }

      assert_equal 200, result
    end

    def test_parse_single_returns_nil_when_row_set_key_missing
      json = '{"resultSets": [{"name": "Test", "headers": ["A"]}]}'

      assert_nil ResponseParser.parse_single(json, result_set: "Test", &:itself)
    end
  end
end
