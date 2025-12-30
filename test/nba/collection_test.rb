require_relative "../test_helper"

module NBA
  class CollectionTest < Minitest::Test
    cover Collection

    def test_objects_with_same_elements_are_equal
      collection0 = Collection.new([1, 2, 3])
      collection1 = Collection.new([1, 2, 3])

      assert_equal collection0, collection1
    end

    def test_size_returns_number_of_elements
      collection = Collection.new([1, 2, 3])

      assert_equal 3, collection.size
    end

    def test_each_iterates_over_elements
      collection = Collection.new([1, 2, 3])
      result = collection.map { |element| element }

      assert_equal [1, 2, 3], result
    end
  end
end
