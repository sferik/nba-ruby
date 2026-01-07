require_relative "../test_helper"

module NBA
  class PlayerProfileV2MissingKeysTest < Minitest::Test
    cover PlayerProfileV2

    def test_handles_missing_season_id
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("SEASON_ID").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.season_id
    end

    def test_handles_missing_team_id
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("TEAM_ID").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.team_id
    end

    def test_handles_missing_team_abbreviation
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("TEAM_ABBREVIATION").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.team_abbreviation
    end

    def test_handles_missing_player_age
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("PLAYER_AGE").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.player_age
    end

    def test_handles_missing_gp
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("GP").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.gp
    end

    def test_handles_missing_gs
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("GS").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.gs
    end

    def test_handles_missing_min
      stub_request(:get, /playerprofilev2/).to_return(body: response_without("MIN").to_json)

      assert_nil PlayerProfileV2.career_regular_season(player: 201_939).first.min
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
