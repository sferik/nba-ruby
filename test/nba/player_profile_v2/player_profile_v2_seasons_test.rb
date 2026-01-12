require_relative "../../test_helper"

module NBA
  class PlayerProfileV2SeasonsTest < Minitest::Test
    cover PlayerProfileV2

    def test_season_regular_season_returns_collection
      stub_profile_request

      result = PlayerProfileV2.season_regular_season(player: 201_939)

      assert_instance_of Collection, result
    end

    def test_season_regular_season_parses_from_correct_result_set
      stub_profile_request

      stat = PlayerProfileV2.season_regular_season(player: 201_939).first

      assert_equal 201_939, stat.player_id
      assert_equal "2024-25", stat.season_id
    end

    def test_season_post_season_returns_collection
      stub_profile_request

      result = PlayerProfileV2.season_post_season(player: 201_939)

      assert_instance_of Collection, result
    end

    def test_season_post_season_parses_from_correct_result_set
      stub_profile_request

      stat = PlayerProfileV2.season_post_season(player: 201_939).first

      assert_equal 201_939, stat.player_id
      assert_equal "2014-15", stat.season_id
    end

    private

    def stub_profile_request
      stub_request(:get, /playerprofilev2/).to_return(body: profile_response.to_json)
    end

    def profile_headers
      %w[PLAYER_ID SEASON_ID TEAM_ID TEAM_ABBREVIATION PLAYER_AGE GP GS MIN
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS]
    end

    def season_regular_row
      [201_939, "2024-25", 1_610_612_744, "GSW", 36, 45, 45, 32.5,
        7.8, 17.2, 0.455, 3.5, 8.5, 0.412, 4.0, 4.5, 0.889, 0.4, 3.0, 3.4, 5.5, 1.2, 0.1, 2.8, 2.3, 23.1]
    end

    def season_post_row
      [201_939, "2014-15", 1_610_612_744, "GSW", 26, 21, 21, 39.8,
        9.5, 20.1, 0.472, 4.1, 9.5, 0.432, 5.2, 5.8, 0.897, 0.7, 3.9, 4.6, 7.5, 2.0, 0.4, 3.8, 2.9, 28.3]
    end

    def profile_response
      {resultSets: [
        {name: "SeasonTotalsRegularSeason", headers: profile_headers, rowSet: [season_regular_row]},
        {name: "SeasonTotalsPostSeason", headers: profile_headers, rowSet: [season_post_row]}
      ]}
    end
  end
end
