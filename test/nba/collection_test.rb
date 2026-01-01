require_relative "../test_helper"

module NBA
  class CollectionTest < Minitest::Test
    cover Collection

    def test_default_initialization_creates_empty_collection
      collection = Collection.new

      assert_equal 0, collection.size
    end

    def test_objects_with_same_elements_are_equal
      collection0 = Collection.new([1, 2, 3])
      collection1 = Collection.new([1, 2, 3])

      assert_equal collection0, collection1
    end

    def test_size_returns_number_of_elements
      collection = Collection.new([1, 2, 3])

      assert_equal 3, collection.size
    end

    def test_length_returns_number_of_elements
      collection = Collection.new([1, 2, 3])

      assert_equal 3, collection.length
    end

    def test_count_returns_number_of_elements
      collection = Collection.new([1, 2, 3])

      assert_equal 3, collection.count
    end

    def test_each_iterates_over_elements
      collection = Collection.new([1, 2, 3])
      result = collection.map { |element| element }

      assert_equal [1, 2, 3], result
    end

    def test_each_returns_enumerator_when_no_block_given
      collection = Collection.new([1, 2, 3])

      assert_instance_of Enumerator, collection.each
    end

    def test_each_enumerator_iterates_correctly
      collection = Collection.new([1, 2, 3])

      assert_equal [1, 2, 3], collection.each.to_a
    end

    def test_each_returns_self_when_block_given
      collection = Collection.new([1, 2, 3])
      sum = 0
      result = collection.each { |element| sum += element }

      assert_same collection, result
    end

    def test_empty_returns_true_for_empty_collection
      collection = Collection.new

      assert_empty collection
    end

    def test_empty_returns_false_for_non_empty_collection
      collection = Collection.new([1, 2, 3])

      refute_empty collection
    end

    def test_first_returns_first_element
      collection = Collection.new([1, 2, 3])

      assert_equal 1, collection.first
    end

    def test_first_returns_nil_for_empty_collection
      collection = Collection.new

      assert_nil collection.first
    end

    def test_last_returns_last_element
      collection = Collection.new([1, 2, 3])

      assert_equal 3, collection.last
    end

    def test_last_returns_nil_for_empty_collection
      collection = Collection.new

      assert_nil collection.last
    end

    def test_any_returns_true_when_block_matches
      collection = Collection.new([1, 2, 3])

      assert(collection.any? { |e| e == 2 })
    end

    def test_any_returns_false_when_block_does_not_match
      collection = Collection.new([1, 2, 3])

      refute(collection.any? { |e| e == 5 })
    end

    def test_any_returns_false_for_empty_collection
      collection = Collection.new

      refute(collection.any? { |e| e == 1 })
    end
  end
end
