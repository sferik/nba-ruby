require_relative "../../test_helper"

module NBA
  class CollectionVarianceTest < Minitest::Test
    cover Collection

    def test_variance_returns_population_variance
      collection = Collection.new([
        GameLog.new(pts: 10),
        GameLog.new(pts: 20),
        GameLog.new(pts: 30)
      ])

      # Mean = 20, deviations = [-10, 0, 10], squared = [100, 0, 100], variance = 200/3
      assert_in_delta 66.667, collection.variance(:pts), 0.001
    end

    def test_variance_returns_nil_for_empty_collection
      collection = Collection.new

      assert_nil collection.variance(:pts)
    end

    def test_variance_ignores_nil_values
      collection = Collection.new([
        GameLog.new(pts: 10),
        GameLog.new(pts: nil),
        GameLog.new(pts: 30)
      ])

      # Mean = 20, deviations = [-10, 10], squared = [100, 100], variance = 100
      assert_in_delta 100.0, collection.variance(:pts)
    end

    def test_variance_returns_nil_when_all_stats_are_nil
      collection = Collection.new([
        GameLog.new(pts: nil),
        GameLog.new(pts: nil)
      ])

      assert_nil collection.variance(:pts)
    end
  end
end
