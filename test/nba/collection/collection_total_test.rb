require_relative "../../test_helper"

module NBA
  class CollectionTotalTest < Minitest::Test
    cover Collection

    def test_total_returns_sum_of_values
      collection = Collection.new([
        GameLog.new(pts: 20),
        GameLog.new(pts: 35),
        GameLog.new(pts: 15)
      ])

      assert_equal 70, collection.total(:pts)
    end

    def test_total_returns_zero_for_empty_collection
      collection = Collection.new

      assert_equal 0, collection.total(:pts)
    end

    def test_total_ignores_nil_values
      collection = Collection.new([
        GameLog.new(pts: 20),
        GameLog.new(pts: nil),
        GameLog.new(pts: 15)
      ])

      assert_equal 35, collection.total(:pts)
    end
  end
end
