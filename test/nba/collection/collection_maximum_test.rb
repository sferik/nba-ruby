require_relative "../../test_helper"

module NBA
  class CollectionMaximumTest < Minitest::Test
    cover Collection

    def test_maximum_returns_highest_value
      collection = Collection.new([
        GameLog.new(pts: 20),
        GameLog.new(pts: 35),
        GameLog.new(pts: 15)
      ])

      assert_equal 35, collection.maximum(:pts)
    end

    def test_maximum_returns_nil_for_empty_collection
      collection = Collection.new

      assert_nil collection.maximum(:pts)
    end

    def test_maximum_ignores_nil_values
      collection = Collection.new([
        GameLog.new(pts: 20),
        GameLog.new(pts: nil),
        GameLog.new(pts: 15)
      ])

      assert_equal 20, collection.maximum(:pts)
    end
  end
end
