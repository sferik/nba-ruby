require_relative "../../test_helper"

module NBA
  class CollectionMinimumTest < Minitest::Test
    cover Collection

    def test_minimum_returns_lowest_value
      collection = Collection.new([
        GameLog.new(pts: 20),
        GameLog.new(pts: 35),
        GameLog.new(pts: 15)
      ])

      assert_equal 15, collection.minimum(:pts)
    end

    def test_minimum_returns_nil_for_empty_collection
      collection = Collection.new

      assert_nil collection.minimum(:pts)
    end

    def test_minimum_ignores_nil_values
      collection = Collection.new([
        GameLog.new(pts: 20),
        GameLog.new(pts: nil),
        GameLog.new(pts: 15)
      ])

      assert_equal 15, collection.minimum(:pts)
    end
  end
end
