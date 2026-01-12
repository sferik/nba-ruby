require_relative "../../test_helper"

module NBA
  class LeadersConstantsTest < Minitest::Test
    cover Leaders

    def test_scoring_constants
      assert_equal "PTS", Leaders::PTS
      assert_equal "FG_PCT", Leaders::FG_PCT
      assert_equal "FG3_PCT", Leaders::FG3_PCT
      assert_equal "FT_PCT", Leaders::FT_PCT
    end

    def test_other_category_constants
      assert_equal "REB", Leaders::REB
      assert_equal "AST", Leaders::AST
      assert_equal "STL", Leaders::STL
      assert_equal "BLK", Leaders::BLK
      assert_equal "EFF", Leaders::EFF
    end
  end
end
