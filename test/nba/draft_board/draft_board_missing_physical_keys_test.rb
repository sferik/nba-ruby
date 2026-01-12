require_relative "../../test_helper"
require_relative "draft_board_missing_keys_test_helper"

module NBA
  class DraftBoardMissingPhysicalKeysTest < Minitest::Test
    cover DraftBoard

    include DraftBoardMissingKeysHelper

    HEADERS = %w[HEIGHT WEIGHT POSITION JERSEY_NUMBER BIRTHDATE AGE].freeze
    ROW = ["7-4", "210", "C", "1", "2004-01-04", 19.0].freeze

    def test_handles_missing_height_key
      stub_with_headers_except("HEIGHT")

      assert_nil DraftBoard.all(season: 2023).first.height
    end

    def test_handles_missing_weight_key
      stub_with_headers_except("WEIGHT")

      assert_nil DraftBoard.all(season: 2023).first.weight
    end

    def test_handles_missing_position_key
      stub_with_headers_except("POSITION")

      assert_nil DraftBoard.all(season: 2023).first.position
    end

    def test_handles_missing_jersey_number_key
      stub_with_headers_except("JERSEY_NUMBER")

      assert_nil DraftBoard.all(season: 2023).first.jersey_number
    end

    def test_handles_missing_birthdate_key
      stub_with_headers_except("BIRTHDATE")

      assert_nil DraftBoard.all(season: 2023).first.birthdate
    end

    def test_handles_missing_age_key
      stub_with_headers_except("AGE")

      assert_nil DraftBoard.all(season: 2023).first.age
    end
  end
end
