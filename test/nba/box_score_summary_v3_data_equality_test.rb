require_relative "../test_helper"

module NBA
  class BoxScoreSummaryV3DataEqualityTest < Minitest::Test
    cover BoxScoreSummaryV3Data

    def test_objects_with_same_game_id_are_equal
      summary0 = BoxScoreSummaryV3Data.new(game_id: "0022400001")
      summary1 = BoxScoreSummaryV3Data.new(game_id: "0022400001")

      assert_equal summary0, summary1
    end

    def test_objects_with_different_game_id_are_not_equal
      summary0 = BoxScoreSummaryV3Data.new(game_id: "0022400001")
      summary1 = BoxScoreSummaryV3Data.new(game_id: "0022400002")

      refute_equal summary0, summary1
    end
  end
end
