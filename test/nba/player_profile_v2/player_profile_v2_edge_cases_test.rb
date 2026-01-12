require_relative "../../test_helper"

module NBA
  class PlayerProfileV2EdgeCasesTest < Minitest::Test
    cover PlayerProfileV2

    def test_returns_empty_when_result_sets_missing
      stub_request(:get, /playerprofilev2/).to_return(body: {}.to_json)

      result = PlayerProfileV2.career_regular_season(player: 201_939)

      assert_empty result
    end

    def test_returns_empty_when_result_set_not_found
      stub_request(:get, /playerprofilev2/).to_return(body: {resultSets: []}.to_json)

      result = PlayerProfileV2.career_regular_season(player: 201_939)

      assert_empty result
    end

    def test_returns_empty_when_result_set_missing_name
      stub_request(:get, /playerprofilev2/).to_return(body: {resultSets: [{headers: [], rowSet: []}]}.to_json)

      result = PlayerProfileV2.career_regular_season(player: 201_939)

      assert_empty result
    end

    def test_returns_empty_when_headers_missing_with_data
      response = {resultSets: [{name: "CareerTotalsRegularSeason", rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /playerprofilev2/).to_return(body: response.to_json)

      result = PlayerProfileV2.career_regular_season(player: 201_939)

      assert_empty result
    end

    def test_returns_empty_when_rows_missing
      response = {resultSets: [{name: "CareerTotalsRegularSeason", headers: []}]}
      stub_request(:get, /playerprofilev2/).to_return(body: response.to_json)

      result = PlayerProfileV2.career_regular_season(player: 201_939)

      assert_empty result
    end

    def test_parses_shooting_stats
      stub_profile_request

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_in_delta 8.2, stat.fgm
      assert_in_delta 17.8, stat.fga
      assert_in_delta 0.462, stat.fg_pct
    end

    def test_parses_three_point_stats
      stub_profile_request

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_in_delta 3.1, stat.fg3m
      assert_in_delta 7.7, stat.fg3a
      assert_in_delta 0.401, stat.fg3_pct
    end

    def test_parses_free_throw_stats
      stub_profile_request

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_in_delta 4.2, stat.ftm
      assert_in_delta 4.8, stat.fta
      assert_in_delta 0.880, stat.ft_pct
    end

    def test_parses_rebound_stats
      stub_profile_request

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_in_delta 0.5, stat.oreb
      assert_in_delta 3.2, stat.dreb
      assert_in_delta 3.7, stat.reb
    end

    def test_parses_other_stats
      stub_profile_request

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_in_delta 5.9, stat.ast
      assert_in_delta 1.5, stat.stl
      assert_in_delta 0.2, stat.blk
      assert_in_delta 3.0, stat.tov
    end

    def test_parses_final_stats
      stub_profile_request

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_in_delta 2.5, stat.pf
      assert_in_delta 23.7, stat.pts
    end

    private

    def stub_profile_request
      stub_request(:get, /playerprofilev2/).to_return(body: profile_response.to_json)
    end

    def profile_headers
      %w[PLAYER_ID SEASON_ID TEAM_ID TEAM_ABBREVIATION PLAYER_AGE GP GS MIN
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS]
    end

    def career_regular_row
      [201_939, "2009-10", 1_610_612_744, "GSW", 21, 80, 77, 36.2,
        8.2, 17.8, 0.462, 3.1, 7.7, 0.401, 4.2, 4.8, 0.880, 0.5, 3.2, 3.7, 5.9, 1.5, 0.2, 3.0, 2.5, 23.7]
    end

    def profile_response
      {resultSets: [{name: "CareerTotalsRegularSeason", headers: profile_headers, rowSet: [career_regular_row]}]}
    end
  end
end
