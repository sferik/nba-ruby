require_relative "../../test_helper"
require_relative "draft_board_missing_keys_test_helper"

module NBA
  class DraftBoardMissingTeamKeysTest < Minitest::Test
    cover DraftBoard

    include DraftBoardMissingKeysHelper

    HEADERS = %w[TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION].freeze
    ROW = [1_610_612_759, "San Antonio", "Spurs", "SAS"].freeze

    def test_handles_missing_team_id_key
      stub_with_headers_except("TEAM_ID")

      assert_nil DraftBoard.all(season: 2023).first.team_id
    end

    def test_handles_missing_team_city_key
      stub_with_headers_except("TEAM_CITY")

      assert_nil DraftBoard.all(season: 2023).first.team_city
    end

    def test_handles_missing_team_name_key
      stub_with_headers_except("TEAM_NAME")

      assert_nil DraftBoard.all(season: 2023).first.team_name
    end

    def test_handles_missing_team_abbreviation_key
      stub_with_headers_except("TEAM_ABBREVIATION")

      assert_nil DraftBoard.all(season: 2023).first.team_abbreviation
    end
  end
end
