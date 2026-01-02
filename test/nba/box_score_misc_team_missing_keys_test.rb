require_relative "../test_helper"

module NBA
  class BoxScoreMiscTeamMissingKeysTest < Minitest::Test
    cover BoxScoreMisc

    def test_missing_game_id
      assert_missing_key_returns_nil("GAME_ID", 0, :game_id)
    end

    def test_missing_team_id
      assert_missing_key_returns_nil("TEAM_ID", 1, :team_id)
    end

    def test_missing_team_name
      assert_missing_key_returns_nil("TEAM_NAME", 2, :team_name)
    end

    def test_missing_team_abbreviation
      assert_missing_key_returns_nil("TEAM_ABBREVIATION", 3, :team_abbreviation)
    end

    def test_missing_team_city
      assert_missing_key_returns_nil("TEAM_CITY", 4, :team_city)
    end

    def test_missing_min
      assert_missing_key_returns_nil("MIN", 5, :min)
    end

    def test_missing_pts_off_tov
      assert_missing_key_returns_nil("PTS_OFF_TOV", 6, :pts_off_tov)
    end

    def test_missing_pts_2nd_chance
      assert_missing_key_returns_nil("PTS_2ND_CHANCE", 7, :pts_2nd_chance)
    end

    def test_missing_pts_fb
      assert_missing_key_returns_nil("PTS_FB", 8, :pts_fb)
    end

    def test_missing_pts_paint
      assert_missing_key_returns_nil("PTS_PAINT", 9, :pts_paint)
    end

    def test_missing_opp_pts_off_tov
      assert_missing_key_returns_nil("OPP_PTS_OFF_TOV", 10, :opp_pts_off_tov)
    end

    def test_missing_opp_pts_2nd_chance
      assert_missing_key_returns_nil("OPP_PTS_2ND_CHANCE", 11, :opp_pts_2nd_chance)
    end

    def test_missing_opp_pts_fb
      assert_missing_key_returns_nil("OPP_PTS_FB", 12, :opp_pts_fb)
    end

    def test_missing_opp_pts_paint
      assert_missing_key_returns_nil("OPP_PTS_PAINT", 13, :opp_pts_paint)
    end

    def test_missing_blk
      assert_missing_key_returns_nil("BLK", 14, :blk)
    end

    def test_missing_blka
      assert_missing_key_returns_nil("BLKA", 15, :blka)
    end

    def test_missing_pf
      assert_missing_key_returns_nil("PF", 16, :pf)
    end

    def test_missing_pfd
      assert_missing_key_returns_nil("PFD", 17, :pfd)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = team_headers.reject { |h| h == key }
      row = team_row[0...index] + team_row[(index + 1)..]
      response = {resultSets: [{name: "TeamStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)
      stat = BoxScoreMisc.team_stats(game: "001").first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN PTS_OFF_TOV PTS_2ND_CHANCE
        PTS_FB PTS_PAINT OPP_PTS_OFF_TOV OPP_PTS_2ND_CHANCE OPP_PTS_FB OPP_PTS_PAINT BLK BLKA PF PFD]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        18, 14, 22, 48, 15, 12, 16, 40, 5, 3, 20, 22]
    end
  end
end
