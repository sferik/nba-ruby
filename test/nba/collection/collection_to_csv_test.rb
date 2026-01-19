require_relative "../../test_helper"

module NBA
  class CollectionToCsvTest < Minitest::Test
    cover Collection

    def test_to_csv_returns_csv_string_with_headers
      collection = Collection.new([
        GameLog.new(pts: 30, ast: 5)
      ])

      result = collection.to_csv

      assert_includes result, "pts"
      assert_includes result, "ast"
      assert_includes result, "30"
      assert_includes result, "5"
    end

    def test_to_csv_includes_multiple_rows
      collection = Collection.new([
        GameLog.new(pts: 30),
        GameLog.new(pts: 25)
      ])

      lines = collection.to_csv.lines

      assert_operator lines.size, :>=, 3
    end

    def test_to_csv_without_headers
      collection = Collection.new([
        GameLog.new(pts: 30)
      ])

      result = collection.to_csv(headers: false)
      first_line = result.lines.first

      refute_includes first_line, "pts"
      assert_includes result, "30"
    end

    def test_to_csv_returns_empty_string_for_empty_collection
      collection = Collection.new

      assert_equal "", collection.to_csv
    end

    def test_to_csv_handles_nil_values
      collection = Collection.new([
        GameLog.new(pts: 30, ast: nil)
      ])

      result = collection.to_csv

      assert_includes result, "30"
    end

    def test_to_csv_works_with_career_stats
      collection = Collection.new([
        CareerStats.new(pts: 26.4, season_id: "2024-25")
      ])

      result = collection.to_csv

      assert_includes result, "pts"
      assert_includes result, "season_id"
      assert_includes result, "26.4"
      assert_includes result, "2024-25"
    end

    def test_to_csv_preserves_column_order
      collection = Collection.new([
        GameLog.new(pts: 30, ast: 5, reb: 10)
      ])

      csv = CSV.parse(collection.to_csv, headers: true)
      row = csv.first

      assert_equal "30", row["pts"]
      assert_equal "5", row["ast"]
      assert_equal "10", row["reb"]
    end
  end
end
