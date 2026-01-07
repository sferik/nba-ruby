require_relative "../test_helper"

module NBA
  class PlayerProfileV2CountingKeysTest < Minitest::Test
    cover PlayerProfileV2

    def test_handles_missing_oreb
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("OREB").to_json)

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_nil stat.oreb
    end

    def test_handles_missing_dreb
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("DREB").to_json)

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_nil stat.dreb
    end

    def test_handles_missing_reb
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("REB").to_json)

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_nil stat.reb
    end

    def test_handles_missing_ast
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("AST").to_json)

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_nil stat.ast
    end

    def test_handles_missing_stl
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("STL").to_json)

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_nil stat.stl
    end

    def test_handles_missing_blk
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("BLK").to_json)

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_nil stat.blk
    end

    def test_handles_missing_tov
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("TOV").to_json)

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_nil stat.tov
    end

    def test_handles_missing_pf
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("PF").to_json)

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_nil stat.pf
    end

    def test_handles_missing_pts
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("PTS").to_json)

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_nil stat.pts
    end

    private

    def all_headers
      %w[PLAYER_ID SEASON_ID TEAM_ID TEAM_ABBREVIATION PLAYER_AGE GP GS MIN
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS]
    end

    def all_values
      [201_939, "2009-10", 1_610_612_744, "GSW", 21, 80, 77, 36.2,
        8.2, 17.8, 0.462, 3.1, 7.7, 0.401, 4.2, 4.8, 0.880, 0.5, 3.2, 3.7, 5.9, 1.5, 0.2, 3.0, 2.5, 23.7]
    end

    def response_without(key)
      index = all_headers.index(key)
      headers = all_headers.reject { |h| h.eql?(key) }
      values = all_values.reject.with_index { |_, i| i.eql?(index) }
      {resultSets: [{name: "CareerTotalsRegularSeason", headers: headers, rowSet: [values]}]}
    end
  end
end
