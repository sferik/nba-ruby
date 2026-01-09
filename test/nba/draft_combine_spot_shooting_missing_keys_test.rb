require_relative "../test_helper"

module NBA
  module DraftCombineSpotShootingMissingKeysHelper
    FULL_HEADERS = %w[
      PLAYER_ID PLAYER_NAME FIRST_NAME LAST_NAME POSITION
      FIFTEEN_CORNER_LEFT_MADE FIFTEEN_CORNER_LEFT_ATTEMPT FIFTEEN_CORNER_LEFT_PCT
      FIFTEEN_BREAK_LEFT_MADE FIFTEEN_BREAK_LEFT_ATTEMPT FIFTEEN_BREAK_LEFT_PCT
      FIFTEEN_TOP_KEY_MADE FIFTEEN_TOP_KEY_ATTEMPT FIFTEEN_TOP_KEY_PCT
      FIFTEEN_BREAK_RIGHT_MADE FIFTEEN_BREAK_RIGHT_ATTEMPT FIFTEEN_BREAK_RIGHT_PCT
      FIFTEEN_CORNER_RIGHT_MADE FIFTEEN_CORNER_RIGHT_ATTEMPT FIFTEEN_CORNER_RIGHT_PCT
      COLLEGE_CORNER_LEFT_MADE COLLEGE_CORNER_LEFT_ATTEMPT COLLEGE_CORNER_LEFT_PCT
      COLLEGE_BREAK_LEFT_MADE COLLEGE_BREAK_LEFT_ATTEMPT COLLEGE_BREAK_LEFT_PCT
      COLLEGE_TOP_KEY_MADE COLLEGE_TOP_KEY_ATTEMPT COLLEGE_TOP_KEY_PCT
      COLLEGE_BREAK_RIGHT_MADE COLLEGE_BREAK_RIGHT_ATTEMPT COLLEGE_BREAK_RIGHT_PCT
      COLLEGE_CORNER_RIGHT_MADE COLLEGE_CORNER_RIGHT_ATTEMPT COLLEGE_CORNER_RIGHT_PCT
      NBA_CORNER_LEFT_MADE NBA_CORNER_LEFT_ATTEMPT NBA_CORNER_LEFT_PCT
      NBA_BREAK_LEFT_MADE NBA_BREAK_LEFT_ATTEMPT NBA_BREAK_LEFT_PCT
      NBA_TOP_KEY_MADE NBA_TOP_KEY_ATTEMPT NBA_TOP_KEY_PCT
      NBA_BREAK_RIGHT_MADE NBA_BREAK_RIGHT_ATTEMPT NBA_BREAK_RIGHT_PCT
      NBA_CORNER_RIGHT_MADE NBA_CORNER_RIGHT_ATTEMPT NBA_CORNER_RIGHT_PCT
    ].freeze

    FULL_ROW = [
      1_630_162, "Victor Wembanyama", "Victor", "Wembanyama", "C",
      3, 5, 0.6, 4, 5, 0.8, 3, 5, 0.6, 4, 5, 0.8, 3, 5, 0.6,
      4, 5, 0.8, 3, 5, 0.6, 4, 5, 0.8, 3, 5, 0.6, 4, 5, 0.8,
      2, 5, 0.4, 3, 5, 0.6, 4, 5, 0.8, 3, 5, 0.6, 2, 5, 0.4
    ].freeze

    def stub_with_headers_except(key)
      headers = FULL_HEADERS.reject { |h| h.eql?(key) }
      row = headers.map { |h| FULL_ROW[FULL_HEADERS.index(h)] }
      response = {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)
    end
  end

  class DraftCombineSpotShootingMissingPlayerKeysTest < Minitest::Test
    include DraftCombineSpotShootingMissingKeysHelper

    cover DraftCombineSpotShooting

    def test_handles_missing_player_id_key
      stub_with_headers_except("PLAYER_ID")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.player_id
    end

    def test_handles_missing_player_name_key
      stub_with_headers_except("PLAYER_NAME")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.player_name
    end

    def test_handles_missing_first_name_key
      stub_with_headers_except("FIRST_NAME")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.first_name
    end

    def test_handles_missing_last_name_key
      stub_with_headers_except("LAST_NAME")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.last_name
    end

    def test_handles_missing_position_key
      stub_with_headers_except("POSITION")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.position
    end
  end

  class DraftCombineSpotShootingMissingFifteenKeysTest < Minitest::Test
    include DraftCombineSpotShootingMissingKeysHelper

    cover DraftCombineSpotShooting

    def test_handles_missing_fifteen_corner_left_made_key
      stub_with_headers_except("FIFTEEN_CORNER_LEFT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_left_made
    end

    def test_handles_missing_fifteen_corner_left_attempt_key
      stub_with_headers_except("FIFTEEN_CORNER_LEFT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_left_attempt
    end

    def test_handles_missing_fifteen_corner_left_pct_key
      stub_with_headers_except("FIFTEEN_CORNER_LEFT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_left_pct
    end

    def test_handles_missing_fifteen_break_left_made_key
      stub_with_headers_except("FIFTEEN_BREAK_LEFT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_left_made
    end

    def test_handles_missing_fifteen_break_left_attempt_key
      stub_with_headers_except("FIFTEEN_BREAK_LEFT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_left_attempt
    end

    def test_handles_missing_fifteen_break_left_pct_key
      stub_with_headers_except("FIFTEEN_BREAK_LEFT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_left_pct
    end

    def test_handles_missing_fifteen_top_key_made_key
      stub_with_headers_except("FIFTEEN_TOP_KEY_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_top_key_made
    end

    def test_handles_missing_fifteen_top_key_attempt_key
      stub_with_headers_except("FIFTEEN_TOP_KEY_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_top_key_attempt
    end

    def test_handles_missing_fifteen_top_key_pct_key
      stub_with_headers_except("FIFTEEN_TOP_KEY_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_top_key_pct
    end

    def test_handles_missing_fifteen_break_right_made_key
      stub_with_headers_except("FIFTEEN_BREAK_RIGHT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_right_made
    end

    def test_handles_missing_fifteen_break_right_attempt_key
      stub_with_headers_except("FIFTEEN_BREAK_RIGHT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_right_attempt
    end

    def test_handles_missing_fifteen_break_right_pct_key
      stub_with_headers_except("FIFTEEN_BREAK_RIGHT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_right_pct
    end

    def test_handles_missing_fifteen_corner_right_made_key
      stub_with_headers_except("FIFTEEN_CORNER_RIGHT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_right_made
    end

    def test_handles_missing_fifteen_corner_right_attempt_key
      stub_with_headers_except("FIFTEEN_CORNER_RIGHT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_right_attempt
    end

    def test_handles_missing_fifteen_corner_right_pct_key
      stub_with_headers_except("FIFTEEN_CORNER_RIGHT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_right_pct
    end
  end

  class DraftCombineSpotShootingMissingCollegeKeysTest < Minitest::Test
    include DraftCombineSpotShootingMissingKeysHelper

    cover DraftCombineSpotShooting

    def test_handles_missing_college_corner_left_made_key
      stub_with_headers_except("COLLEGE_CORNER_LEFT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.college_corner_left_made
    end

    def test_handles_missing_college_corner_left_attempt_key
      stub_with_headers_except("COLLEGE_CORNER_LEFT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.college_corner_left_attempt
    end

    def test_handles_missing_college_corner_left_pct_key
      stub_with_headers_except("COLLEGE_CORNER_LEFT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.college_corner_left_pct
    end

    def test_handles_missing_college_break_left_made_key
      stub_with_headers_except("COLLEGE_BREAK_LEFT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.college_break_left_made
    end

    def test_handles_missing_college_break_left_attempt_key
      stub_with_headers_except("COLLEGE_BREAK_LEFT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.college_break_left_attempt
    end

    def test_handles_missing_college_break_left_pct_key
      stub_with_headers_except("COLLEGE_BREAK_LEFT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.college_break_left_pct
    end

    def test_handles_missing_college_top_key_made_key
      stub_with_headers_except("COLLEGE_TOP_KEY_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.college_top_key_made
    end

    def test_handles_missing_college_top_key_attempt_key
      stub_with_headers_except("COLLEGE_TOP_KEY_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.college_top_key_attempt
    end

    def test_handles_missing_college_top_key_pct_key
      stub_with_headers_except("COLLEGE_TOP_KEY_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.college_top_key_pct
    end

    def test_handles_missing_college_break_right_made_key
      stub_with_headers_except("COLLEGE_BREAK_RIGHT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.college_break_right_made
    end

    def test_handles_missing_college_break_right_attempt_key
      stub_with_headers_except("COLLEGE_BREAK_RIGHT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.college_break_right_attempt
    end

    def test_handles_missing_college_break_right_pct_key
      stub_with_headers_except("COLLEGE_BREAK_RIGHT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.college_break_right_pct
    end

    def test_handles_missing_college_corner_right_made_key
      stub_with_headers_except("COLLEGE_CORNER_RIGHT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.college_corner_right_made
    end

    def test_handles_missing_college_corner_right_attempt_key
      stub_with_headers_except("COLLEGE_CORNER_RIGHT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.college_corner_right_attempt
    end

    def test_handles_missing_college_corner_right_pct_key
      stub_with_headers_except("COLLEGE_CORNER_RIGHT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.college_corner_right_pct
    end
  end

  class DraftCombineSpotShootingMissingNBAKeysTest < Minitest::Test
    include DraftCombineSpotShootingMissingKeysHelper

    cover DraftCombineSpotShooting

    def test_handles_missing_nba_corner_left_made_key
      stub_with_headers_except("NBA_CORNER_LEFT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.nba_corner_left_made
    end

    def test_handles_missing_nba_corner_left_attempt_key
      stub_with_headers_except("NBA_CORNER_LEFT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.nba_corner_left_attempt
    end

    def test_handles_missing_nba_corner_left_pct_key
      stub_with_headers_except("NBA_CORNER_LEFT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.nba_corner_left_pct
    end

    def test_handles_missing_nba_break_left_made_key
      stub_with_headers_except("NBA_BREAK_LEFT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.nba_break_left_made
    end

    def test_handles_missing_nba_break_left_attempt_key
      stub_with_headers_except("NBA_BREAK_LEFT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.nba_break_left_attempt
    end

    def test_handles_missing_nba_break_left_pct_key
      stub_with_headers_except("NBA_BREAK_LEFT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.nba_break_left_pct
    end

    def test_handles_missing_nba_top_key_made_key
      stub_with_headers_except("NBA_TOP_KEY_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.nba_top_key_made
    end

    def test_handles_missing_nba_top_key_attempt_key
      stub_with_headers_except("NBA_TOP_KEY_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.nba_top_key_attempt
    end

    def test_handles_missing_nba_top_key_pct_key
      stub_with_headers_except("NBA_TOP_KEY_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.nba_top_key_pct
    end

    def test_handles_missing_nba_break_right_made_key
      stub_with_headers_except("NBA_BREAK_RIGHT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.nba_break_right_made
    end

    def test_handles_missing_nba_break_right_attempt_key
      stub_with_headers_except("NBA_BREAK_RIGHT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.nba_break_right_attempt
    end

    def test_handles_missing_nba_break_right_pct_key
      stub_with_headers_except("NBA_BREAK_RIGHT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.nba_break_right_pct
    end

    def test_handles_missing_nba_corner_right_made_key
      stub_with_headers_except("NBA_CORNER_RIGHT_MADE")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.nba_corner_right_made
    end

    def test_handles_missing_nba_corner_right_attempt_key
      stub_with_headers_except("NBA_CORNER_RIGHT_ATTEMPT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.nba_corner_right_attempt
    end

    def test_handles_missing_nba_corner_right_pct_key
      stub_with_headers_except("NBA_CORNER_RIGHT_PCT")

      assert_nil DraftCombineSpotShooting.all(season: 2019).first.nba_corner_right_pct
    end
  end
end
