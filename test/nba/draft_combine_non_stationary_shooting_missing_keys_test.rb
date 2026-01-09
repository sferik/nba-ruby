require_relative "../test_helper"

module NBA
  module DraftCombineNonStationaryShootingMissingKeysHelper
    FULL_HEADERS = %w[
      TEMP_PLAYER_ID PLAYER_ID PLAYER_NAME FIRST_NAME LAST_NAME POSITION
      OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_MADE OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_ATTEMPT
      OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_PCT OFF_DRIBBLE_FIFTEEN_TOP_KEY_MADE
      OFF_DRIBBLE_FIFTEEN_TOP_KEY_ATTEMPT OFF_DRIBBLE_FIFTEEN_TOP_KEY_PCT
      OFF_DRIBBLE_FIFTEEN_BREAK_RIGHT_MADE OFF_DRIBBLE_FIFTEEN_BREAK_RIGHT_ATTEMPT
      OFF_DRIBBLE_FIFTEEN_BREAK_RIGHT_PCT
      ON_MOVE_FIFTEEN_BREAK_LEFT_MADE ON_MOVE_FIFTEEN_BREAK_LEFT_ATTEMPT
      ON_MOVE_FIFTEEN_BREAK_LEFT_PCT ON_MOVE_FIFTEEN_TOP_KEY_MADE
      ON_MOVE_FIFTEEN_TOP_KEY_ATTEMPT ON_MOVE_FIFTEEN_TOP_KEY_PCT
      ON_MOVE_FIFTEEN_BREAK_RIGHT_MADE ON_MOVE_FIFTEEN_BREAK_RIGHT_ATTEMPT
      ON_MOVE_FIFTEEN_BREAK_RIGHT_PCT
      OFF_DRIBBLE_COLLEGE_BREAK_LEFT_MADE OFF_DRIBBLE_COLLEGE_BREAK_LEFT_ATTEMPT
      OFF_DRIBBLE_COLLEGE_BREAK_LEFT_PCT OFF_DRIBBLE_COLLEGE_TOP_KEY_MADE
      OFF_DRIBBLE_COLLEGE_TOP_KEY_ATTEMPT OFF_DRIBBLE_COLLEGE_TOP_KEY_PCT
      OFF_DRIBBLE_COLLEGE_BREAK_RIGHT_MADE OFF_DRIBBLE_COLLEGE_BREAK_RIGHT_ATTEMPT
      OFF_DRIBBLE_COLLEGE_BREAK_RIGHT_PCT
      ON_MOVE_COLLEGE_BREAK_LEFT_MADE ON_MOVE_COLLEGE_BREAK_LEFT_ATTEMPT
      ON_MOVE_COLLEGE_BREAK_LEFT_PCT ON_MOVE_COLLEGE_TOP_KEY_MADE
      ON_MOVE_COLLEGE_TOP_KEY_ATTEMPT ON_MOVE_COLLEGE_TOP_KEY_PCT
      ON_MOVE_COLLEGE_BREAK_RIGHT_MADE ON_MOVE_COLLEGE_BREAK_RIGHT_ATTEMPT
      ON_MOVE_COLLEGE_BREAK_RIGHT_PCT
    ].freeze

    FULL_ROW = [
      1, 1_630_162, "Victor Wembanyama", "Victor", "Wembanyama", "C",
      3, 5, 0.6, 4, 5, 0.8, 3, 5, 0.6,
      2, 5, 0.4, 3, 5, 0.6, 2, 5, 0.4,
      2, 5, 0.4, 3, 5, 0.6, 2, 5, 0.4,
      1, 5, 0.2, 2, 5, 0.4, 1, 5, 0.2
    ].freeze

    def stub_with_headers_except(key)
      headers = FULL_HEADERS.reject { |h| h.eql?(key) }
      row = headers.map { |h| FULL_ROW[FULL_HEADERS.index(h)] }
      response = {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)
    end
  end

  class DraftCombineNonStationaryShootingMissingPlayerKeysTest < Minitest::Test
    include DraftCombineNonStationaryShootingMissingKeysHelper

    cover DraftCombineNonStationaryShooting

    def test_handles_missing_temp_player_id_key
      stub_with_headers_except("TEMP_PLAYER_ID")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.temp_player_id
    end

    def test_handles_missing_player_id_key
      stub_with_headers_except("PLAYER_ID")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.player_id
    end

    def test_handles_missing_player_name_key
      stub_with_headers_except("PLAYER_NAME")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.player_name
    end

    def test_handles_missing_first_name_key
      stub_with_headers_except("FIRST_NAME")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.first_name
    end

    def test_handles_missing_last_name_key
      stub_with_headers_except("LAST_NAME")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.last_name
    end

    def test_handles_missing_position_key
      stub_with_headers_except("POSITION")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.position
    end
  end

  class DraftCombineNonStationaryShootingMissingOffDribbleFifteenKeysTest < Minitest::Test
    include DraftCombineNonStationaryShootingMissingKeysHelper

    cover DraftCombineNonStationaryShooting

    def test_handles_missing_off_dribble_fifteen_break_left_made_key
      stub_with_headers_except("OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_MADE")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_break_left_made
    end

    def test_handles_missing_off_dribble_fifteen_break_left_attempt_key
      stub_with_headers_except("OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_ATTEMPT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_break_left_attempt
    end

    def test_handles_missing_off_dribble_fifteen_break_left_pct_key
      stub_with_headers_except("OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_PCT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_break_left_pct
    end

    def test_handles_missing_off_dribble_fifteen_top_key_made_key
      stub_with_headers_except("OFF_DRIBBLE_FIFTEEN_TOP_KEY_MADE")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_top_key_made
    end

    def test_handles_missing_off_dribble_fifteen_top_key_attempt_key
      stub_with_headers_except("OFF_DRIBBLE_FIFTEEN_TOP_KEY_ATTEMPT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_top_key_attempt
    end

    def test_handles_missing_off_dribble_fifteen_top_key_pct_key
      stub_with_headers_except("OFF_DRIBBLE_FIFTEEN_TOP_KEY_PCT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_top_key_pct
    end

    def test_handles_missing_off_dribble_fifteen_break_right_made_key
      stub_with_headers_except("OFF_DRIBBLE_FIFTEEN_BREAK_RIGHT_MADE")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_break_right_made
    end

    def test_handles_missing_off_dribble_fifteen_break_right_attempt_key
      stub_with_headers_except("OFF_DRIBBLE_FIFTEEN_BREAK_RIGHT_ATTEMPT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_break_right_attempt
    end

    def test_handles_missing_off_dribble_fifteen_break_right_pct_key
      stub_with_headers_except("OFF_DRIBBLE_FIFTEEN_BREAK_RIGHT_PCT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_break_right_pct
    end
  end

  class DraftCombineNonStationaryShootingMissingOnMoveFifteenKeysTest < Minitest::Test
    include DraftCombineNonStationaryShootingMissingKeysHelper

    cover DraftCombineNonStationaryShooting

    def test_handles_missing_on_move_fifteen_break_left_made_key
      stub_with_headers_except("ON_MOVE_FIFTEEN_BREAK_LEFT_MADE")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_left_made
    end

    def test_handles_missing_on_move_fifteen_break_left_attempt_key
      stub_with_headers_except("ON_MOVE_FIFTEEN_BREAK_LEFT_ATTEMPT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_left_attempt
    end

    def test_handles_missing_on_move_fifteen_break_left_pct_key
      stub_with_headers_except("ON_MOVE_FIFTEEN_BREAK_LEFT_PCT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_left_pct
    end

    def test_handles_missing_on_move_fifteen_top_key_made_key
      stub_with_headers_except("ON_MOVE_FIFTEEN_TOP_KEY_MADE")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_top_key_made
    end

    def test_handles_missing_on_move_fifteen_top_key_attempt_key
      stub_with_headers_except("ON_MOVE_FIFTEEN_TOP_KEY_ATTEMPT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_top_key_attempt
    end

    def test_handles_missing_on_move_fifteen_top_key_pct_key
      stub_with_headers_except("ON_MOVE_FIFTEEN_TOP_KEY_PCT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_top_key_pct
    end

    def test_handles_missing_on_move_fifteen_break_right_made_key
      stub_with_headers_except("ON_MOVE_FIFTEEN_BREAK_RIGHT_MADE")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_right_made
    end

    def test_handles_missing_on_move_fifteen_break_right_attempt_key
      stub_with_headers_except("ON_MOVE_FIFTEEN_BREAK_RIGHT_ATTEMPT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_right_attempt
    end

    def test_handles_missing_on_move_fifteen_break_right_pct_key
      stub_with_headers_except("ON_MOVE_FIFTEEN_BREAK_RIGHT_PCT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_right_pct
    end
  end

  class DraftCombineNonStationaryShootingMissingOffDribbleCollegeKeysTest < Minitest::Test
    include DraftCombineNonStationaryShootingMissingKeysHelper

    cover DraftCombineNonStationaryShooting

    def test_handles_missing_off_dribble_college_break_left_made_key
      stub_with_headers_except("OFF_DRIBBLE_COLLEGE_BREAK_LEFT_MADE")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_break_left_made
    end

    def test_handles_missing_off_dribble_college_break_left_attempt_key
      stub_with_headers_except("OFF_DRIBBLE_COLLEGE_BREAK_LEFT_ATTEMPT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_break_left_attempt
    end

    def test_handles_missing_off_dribble_college_break_left_pct_key
      stub_with_headers_except("OFF_DRIBBLE_COLLEGE_BREAK_LEFT_PCT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_break_left_pct
    end

    def test_handles_missing_off_dribble_college_top_key_made_key
      stub_with_headers_except("OFF_DRIBBLE_COLLEGE_TOP_KEY_MADE")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_top_key_made
    end

    def test_handles_missing_off_dribble_college_top_key_attempt_key
      stub_with_headers_except("OFF_DRIBBLE_COLLEGE_TOP_KEY_ATTEMPT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_top_key_attempt
    end

    def test_handles_missing_off_dribble_college_top_key_pct_key
      stub_with_headers_except("OFF_DRIBBLE_COLLEGE_TOP_KEY_PCT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_top_key_pct
    end

    def test_handles_missing_off_dribble_college_break_right_made_key
      stub_with_headers_except("OFF_DRIBBLE_COLLEGE_BREAK_RIGHT_MADE")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_break_right_made
    end

    def test_handles_missing_off_dribble_college_break_right_attempt_key
      stub_with_headers_except("OFF_DRIBBLE_COLLEGE_BREAK_RIGHT_ATTEMPT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_break_right_attempt
    end

    def test_handles_missing_off_dribble_college_break_right_pct_key
      stub_with_headers_except("OFF_DRIBBLE_COLLEGE_BREAK_RIGHT_PCT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_break_right_pct
    end
  end

  class DraftCombineNonStationaryShootingMissingOnMoveCollegeKeysTest < Minitest::Test
    include DraftCombineNonStationaryShootingMissingKeysHelper

    cover DraftCombineNonStationaryShooting

    def test_handles_missing_on_move_college_break_left_made_key
      stub_with_headers_except("ON_MOVE_COLLEGE_BREAK_LEFT_MADE")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_left_made
    end

    def test_handles_missing_on_move_college_break_left_attempt_key
      stub_with_headers_except("ON_MOVE_COLLEGE_BREAK_LEFT_ATTEMPT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_left_attempt
    end

    def test_handles_missing_on_move_college_break_left_pct_key
      stub_with_headers_except("ON_MOVE_COLLEGE_BREAK_LEFT_PCT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_left_pct
    end

    def test_handles_missing_on_move_college_top_key_made_key
      stub_with_headers_except("ON_MOVE_COLLEGE_TOP_KEY_MADE")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_top_key_made
    end

    def test_handles_missing_on_move_college_top_key_attempt_key
      stub_with_headers_except("ON_MOVE_COLLEGE_TOP_KEY_ATTEMPT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_top_key_attempt
    end

    def test_handles_missing_on_move_college_top_key_pct_key
      stub_with_headers_except("ON_MOVE_COLLEGE_TOP_KEY_PCT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_top_key_pct
    end

    def test_handles_missing_on_move_college_break_right_made_key
      stub_with_headers_except("ON_MOVE_COLLEGE_BREAK_RIGHT_MADE")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_right_made
    end

    def test_handles_missing_on_move_college_break_right_attempt_key
      stub_with_headers_except("ON_MOVE_COLLEGE_BREAK_RIGHT_ATTEMPT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_right_attempt
    end

    def test_handles_missing_on_move_college_break_right_pct_key
      stub_with_headers_except("ON_MOVE_COLLEGE_BREAK_RIGHT_PCT")

      assert_nil DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_right_pct
    end
  end
end
