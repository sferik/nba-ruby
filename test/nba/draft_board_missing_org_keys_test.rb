require_relative "../test_helper"
require_relative "draft_board_missing_keys_test_helper"

module NBA
  class DraftBoardMissingOrgKeysTest < Minitest::Test
    cover DraftBoard

    include DraftBoardMissingKeysHelper

    HEADERS = %w[ORGANIZATION ORGANIZATION_TYPE].freeze
    ROW = ["Metropolitans 92", "International"].freeze

    def test_handles_missing_organization_key
      stub_with_headers_except("ORGANIZATION")

      assert_nil DraftBoard.all(season: 2023).first.organization
    end

    def test_handles_missing_organization_type_key
      stub_with_headers_except("ORGANIZATION_TYPE")

      assert_nil DraftBoard.all(season: 2023).first.organization_type
    end
  end
end
