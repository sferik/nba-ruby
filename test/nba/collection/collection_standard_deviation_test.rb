require_relative "../../test_helper"

module NBA
  class CollectionStandardDeviationTest < Minitest::Test
    cover Collection

    def test_standard_deviation_returns_sqrt_of_variance
      collection = Collection.new([
        GameLog.new(pts: 10),
        GameLog.new(pts: 20),
        GameLog.new(pts: 30)
      ])

      # Variance = 200/3, std_dev = sqrt(200/3)
      assert_in_delta 8.165, collection.standard_deviation(:pts), 0.001
    end

    def test_standard_deviation_returns_nil_for_empty_collection
      collection = Collection.new

      assert_nil collection.standard_deviation(:pts)
    end
  end
end
