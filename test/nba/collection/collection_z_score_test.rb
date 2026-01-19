require_relative "../../test_helper"

module NBA
  class CollectionZScoreTest < Minitest::Test
    cover Collection

    def test_z_score_returns_standard_score
      collection = Collection.new([
        GameLog.new(pts: 10),
        GameLog.new(pts: 20),
        GameLog.new(pts: 30)
      ])

      # Mean = 20, std_dev = 8.165, z_score for 30 = (30-20)/8.165 = 1.225
      assert_in_delta 1.225, collection.z_score(:pts, 30), 0.001
    end

    def test_z_score_returns_zero_for_mean_value
      collection = Collection.new([
        GameLog.new(pts: 10),
        GameLog.new(pts: 20),
        GameLog.new(pts: 30)
      ])

      assert_in_delta 0.0, collection.z_score(:pts, 20)
    end

    def test_z_score_returns_negative_for_below_mean
      collection = Collection.new([
        GameLog.new(pts: 10),
        GameLog.new(pts: 20),
        GameLog.new(pts: 30)
      ])

      assert_in_delta(-1.225, collection.z_score(:pts, 10), 0.001)
    end

    def test_z_score_returns_nil_for_empty_collection
      collection = Collection.new

      assert_nil collection.z_score(:pts, 20)
    end

    def test_z_score_returns_nil_when_all_values_are_same
      collection = Collection.new([
        GameLog.new(pts: 20),
        GameLog.new(pts: 20),
        GameLog.new(pts: 20)
      ])

      # Std dev is 0, so z_score is undefined
      assert_nil collection.z_score(:pts, 20)
    end

    def test_z_score_works_with_different_stat_types
      collection = Collection.new([
        GameLog.new(ast: 5, reb: 10),
        GameLog.new(ast: 10, reb: 5),
        GameLog.new(ast: 15, reb: 8)
      ])

      assert_equal 15, collection.maximum(:ast)
      assert_equal 5, collection.minimum(:reb)
    end

    def test_z_score_converts_value_to_float
      collection = Collection.new([
        GameLog.new(pts: 10),
        GameLog.new(pts: 20),
        GameLog.new(pts: 30)
      ])

      mock_value = Minitest::Mock.new
      mock_value.expect(:to_f, 30.0)

      collection.z_score(:pts, mock_value)

      mock_value.verify
    end

    def test_z_score_returns_nil_when_all_stats_are_nil
      collection = Collection.new([
        GameLog.new(pts: nil),
        GameLog.new(pts: nil)
      ])

      assert_nil collection.z_score(:pts, 20)
    end

    def test_z_score_converts_average_to_float
      collection = Collection.new([GameLog.new(pts: 10), GameLog.new(pts: 20), GameLog.new(pts: 30)])
      mock_average = Minitest::Mock.new
      mock_average.expect(:to_f, 20.0)

      collection.stub(:average, mock_average) { collection.z_score(:pts, 30) }

      mock_average.verify
    end
  end
end
