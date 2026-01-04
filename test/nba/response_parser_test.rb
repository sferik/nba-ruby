require_relative "../test_helper"

module NBA
  class ResponseParserTest < Minitest::Test
    cover ResponseParser

    def test_parse_returns_empty_collection_for_nil_response
      result = ResponseParser.parse(nil, &:itself)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_parse_returns_empty_collection_for_invalid_json
      result = ResponseParser.parse("not valid json", &:itself)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_parse_returns_empty_collection_when_result_sets_missing
      result = ResponseParser.parse("{}", &:itself)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_parse_returns_empty_collection_when_result_set_not_found
      json = '{"resultSets": []}'
      result = ResponseParser.parse(json, result_set: "Missing", &:itself)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_parse_returns_empty_when_result_set_lacks_name_field
      json = '{"resultSets": [{"headers": ["A"], "rowSet": [[1]]}]}'
      result = ResponseParser.parse(json, result_set: "Named", &:itself)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_parse_skips_result_sets_with_missing_name_key
      json = '{"resultSets": [{"headers": ["X"], "rowSet": [[0]]}, {"name": "Test", "headers": ["A"], "rowSet": [[1]]}]}'
      result = ResponseParser.parse(json, result_set: "Test") { |data| data }

      assert_equal 1, result.size
      assert_equal({"A" => 1}, result.first)
    end

    def test_parse_returns_empty_when_result_set_name_does_not_match
      json = '{"resultSets": [{"name": "Other", "headers": ["A"], "rowSet": [[1]]}]}'
      result = ResponseParser.parse(json, result_set: "Expected", &:itself)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_parse_returns_empty_collection_when_headers_missing
      json = '{"resultSets": [{"name": "Test", "rowSet": []}]}'
      result = ResponseParser.parse(json, result_set: "Test", &:itself)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_parse_returns_empty_collection_when_rows_missing
      json = '{"resultSets": [{"name": "Test", "headers": ["A"]}]}'
      result = ResponseParser.parse(json, result_set: "Test", &:itself)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_parse_builds_objects_from_rows
      json = '{"resultSets": [{"name": "Test", "headers": ["A", "B"], "rowSet": [[1, 2], [3, 4]]}]}'
      result = ResponseParser.parse(json, result_set: "Test") { |data| data }

      assert_instance_of Collection, result
      assert_equal 2, result.size
      assert_equal({"A" => 1, "B" => 2}, result.first)
      assert_equal({"A" => 3, "B" => 4}, result.last)
    end

    def test_parse_uses_first_result_set_when_name_not_specified
      json = '{"resultSets": [{"name": "First", "headers": ["X"], "rowSet": [[100]]}, ' \
             '{"name": "Second", "headers": ["Y"], "rowSet": [[200]]}]}'
      result = ResponseParser.parse(json) { |data| data["X"] || data["Y"] }

      assert_equal 1, result.size
      assert_equal 100, result.first
    end

    def test_parse_returns_empty_when_headers_is_nil
      json = '{"resultSets": [{"name": "Test", "headers": null, "rowSet": [[1]]}]}'
      result = ResponseParser.parse(json, result_set: "Test", &:itself)

      assert_empty result
    end

    def test_parse_returns_empty_when_row_set_is_nil
      json = '{"resultSets": [{"name": "Test", "headers": ["A"], "rowSet": null}]}'
      result = ResponseParser.parse(json, result_set: "Test", &:itself)

      assert_empty result
    end

    def test_zip_to_hash_creates_hash_from_headers_and_row
      headers = %w[name age city]
      row = ["John", 30, "NYC"]

      result = ResponseParser.zip_to_hash(headers, row)

      assert_equal({"name" => "John", "age" => 30, "city" => "NYC"}, result)
    end
  end
end
