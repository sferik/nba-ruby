require_relative "../../test_helper"

module NBA
  class PlayerProfileV2ShootingKeysTest < Minitest::Test
    cover PlayerProfileV2

    def test_handles_missing_fgm
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("FGM").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.fgm
    end

    def test_handles_missing_fga
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("FGA").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.fga
    end

    def test_handles_missing_fg_pct
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("FG_PCT").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.fg_pct
    end

    def test_handles_missing_fg3m
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("FG3M").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.fg3m
    end

    def test_handles_missing_fg3a
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("FG3A").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.fg3a
    end

    def test_handles_missing_fg3_pct
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("FG3_PCT").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.fg3_pct
    end

    def test_handles_missing_ftm
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("FTM").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.ftm
    end

    def test_handles_missing_fta
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("FTA").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.fta
    end

    def test_handles_missing_ft_pct
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("FT_PCT").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.ft_pct
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
