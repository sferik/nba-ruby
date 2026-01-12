require_relative "../../test_helper"

module NBA
  class BoxScoreMiscPlayerMissingKeysTest < Minitest::Test
    cover BoxScoreMisc

    def test_missing_game_id
      assert_missing_key_returns_nil("GAME_ID", 0, :game_id)
    end

    def test_missing_team_id
      assert_missing_key_returns_nil("TEAM_ID", 1, :team_id)
    end

    def test_missing_team_abbreviation
      assert_missing_key_returns_nil("TEAM_ABBREVIATION", 2, :team_abbreviation)
    end

    def test_missing_team_city
      assert_missing_key_returns_nil("TEAM_CITY", 3, :team_city)
    end

    def test_missing_player_id
      assert_missing_key_returns_nil("PLAYER_ID", 4, :player_id)
    end

    def test_missing_player_name
      assert_missing_key_returns_nil("PLAYER_NAME", 5, :player_name)
    end

    def test_missing_start_position
      assert_missing_key_returns_nil("START_POSITION", 6, :start_position)
    end

    def test_missing_comment
      assert_missing_key_returns_nil("COMMENT", 7, :comment)
    end

    def test_missing_min
      assert_missing_key_returns_nil("MIN", 8, :min)
    end

    def test_missing_pts_off_tov
      assert_missing_key_returns_nil("PTS_OFF_TOV", 9, :pts_off_tov)
    end

    def test_missing_pts_2nd_chance
      assert_missing_key_returns_nil("PTS_2ND_CHANCE", 10, :pts_2nd_chance)
    end

    def test_missing_pts_fb
      assert_missing_key_returns_nil("PTS_FB", 11, :pts_fb)
    end

    def test_missing_pts_paint
      assert_missing_key_returns_nil("PTS_PAINT", 12, :pts_paint)
    end

    def test_missing_opp_pts_off_tov
      assert_missing_key_returns_nil("OPP_PTS_OFF_TOV", 13, :opp_pts_off_tov)
    end

    def test_missing_opp_pts_2nd_chance
      assert_missing_key_returns_nil("OPP_PTS_2ND_CHANCE", 14, :opp_pts_2nd_chance)
    end

    def test_missing_opp_pts_fb
      assert_missing_key_returns_nil("OPP_PTS_FB", 15, :opp_pts_fb)
    end

    def test_missing_opp_pts_paint
      assert_missing_key_returns_nil("OPP_PTS_PAINT", 16, :opp_pts_paint)
    end

    def test_missing_blk
      assert_missing_key_returns_nil("BLK", 17, :blk)
    end

    def test_missing_blka
      assert_missing_key_returns_nil("BLKA", 18, :blka)
    end

    def test_missing_pf
      assert_missing_key_returns_nil("PF", 19, :pf)
    end

    def test_missing_pfd
      assert_missing_key_returns_nil("PFD", 20, :pfd)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = player_headers.reject { |h| h == key }
      row = player_row[0...index] + player_row[(index + 1)..]
      response = {resultSets: [{name: "PlayerStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)
      stat = BoxScoreMisc.player_stats(game: "001").first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN PTS_OFF_TOV PTS_2ND_CHANCE PTS_FB PTS_PAINT OPP_PTS_OFF_TOV OPP_PTS_2ND_CHANCE
        OPP_PTS_FB OPP_PTS_PAINT BLK BLKA PF PFD]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 5, 4, 8, 12, 6, 3, 4, 10, 0, 1, 2, 3]
    end
  end
end
