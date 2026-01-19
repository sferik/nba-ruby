require_relative "../../test_helper"

module NBA
  class CollectionToJsonTest < Minitest::Test
    cover Collection

    def test_to_json_returns_json_array_string
      collection = Collection.new([
        GameLog.new(pts: 30, ast: 5),
        GameLog.new(pts: 25, ast: 8)
      ])

      result = JSON.parse(collection.to_json)

      assert_instance_of Array, result
      assert_equal 2, result.size
    end

    def test_to_json_includes_element_attributes
      collection = Collection.new([
        GameLog.new(pts: 30, ast: 5)
      ])

      result = JSON.parse(collection.to_json)

      assert_equal 30, result.first["pts"]
      assert_equal 5, result.first["ast"]
    end

    def test_to_json_returns_empty_array_for_empty_collection
      collection = Collection.new

      assert_equal "[]", collection.to_json
    end

    def test_to_json_works_with_career_stats
      collection = Collection.new([
        CareerStats.new(pts: 26.4, ast: 5.1, season_id: "2024-25")
      ])

      result = JSON.parse(collection.to_json)

      assert_in_delta 26.4, result.first["pts"]
      assert_equal "2024-25", result.first["season_id"]
    end

    def test_to_json_handles_nil_values
      collection = Collection.new([
        GameLog.new(pts: 30, ast: nil)
      ])

      result = JSON.parse(collection.to_json)

      assert_equal 30, result.first["pts"]
      assert_nil result.first["ast"]
    end
  end
end
