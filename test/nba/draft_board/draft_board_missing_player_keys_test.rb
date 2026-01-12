require_relative "../../test_helper"
require_relative "draft_board_missing_keys_test_helper"

module NBA
  class DraftBoardMissingPlayerKeysTest < Minitest::Test
    cover DraftBoard

    include DraftBoardMissingKeysHelper

    HEADERS = %w[PERSON_ID PLAYER_NAME SEASON ROUND_NUMBER ROUND_PICK OVERALL_PICK].freeze
    ROW = [1_630_162, "Victor Wembanyama", "2023", 1, 1, 1].freeze

    def test_handles_missing_person_id_key
      stub_with_headers_except("PERSON_ID")

      assert_nil DraftBoard.all(season: 2023).first.person_id
    end

    def test_handles_missing_player_name_key
      stub_with_headers_except("PLAYER_NAME")

      assert_nil DraftBoard.all(season: 2023).first.player_name
    end

    def test_handles_missing_season_key
      stub_with_headers_except("SEASON")

      assert_nil DraftBoard.all(season: 2023).first.season
    end

    def test_handles_missing_round_number_key
      stub_with_headers_except("ROUND_NUMBER")

      assert_nil DraftBoard.all(season: 2023).first.round_number
    end

    def test_handles_missing_round_pick_key
      stub_with_headers_except("ROUND_PICK")

      assert_nil DraftBoard.all(season: 2023).first.round_pick
    end

    def test_handles_missing_overall_pick_key
      stub_with_headers_except("OVERALL_PICK")

      assert_nil DraftBoard.all(season: 2023).first.overall_pick
    end
  end
end
