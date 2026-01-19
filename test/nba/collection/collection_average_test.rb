require_relative "../../test_helper"

module NBA
  class CollectionAverageTest < Minitest::Test
    cover Collection

    def test_average_returns_mean_of_values
      collection = Collection.new([
        GameLog.new(pts: 20),
        GameLog.new(pts: 30),
        GameLog.new(pts: 25)
      ])

      assert_in_delta 25.0, collection.average(:pts)
    end

    def test_average_returns_nil_for_empty_collection
      collection = Collection.new

      assert_nil collection.average(:pts)
    end

    def test_average_ignores_nil_values
      collection = Collection.new([
        GameLog.new(pts: 20),
        GameLog.new(pts: nil),
        GameLog.new(pts: 30)
      ])

      assert_in_delta 25.0, collection.average(:pts)
    end

    def test_mean_is_alias_for_average
      collection = Collection.new([
        GameLog.new(pts: 10),
        GameLog.new(pts: 20)
      ])

      assert_in_delta 15.0, collection.mean(:pts)
    end

    def test_average_works_with_float_stats
      collection = Collection.new([
        CareerStats.new(pts: 20.5),
        CareerStats.new(pts: 25.5),
        CareerStats.new(pts: 30.0)
      ])

      assert_in_delta 25.333, collection.average(:pts), 0.001
    end

    def test_average_returns_nil_when_all_stats_are_nil
      collection = Collection.new([
        GameLog.new(pts: nil),
        GameLog.new(pts: nil)
      ])

      assert_nil collection.average(:pts)
    end

    def test_average_returns_float_for_non_divisible_integers
      collection = Collection.new([
        GameLog.new(pts: 1),
        GameLog.new(pts: 2)
      ])

      assert_in_delta 1.5, collection.average(:pts)
    end
  end
end
