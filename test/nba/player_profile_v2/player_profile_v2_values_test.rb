require_relative "../../test_helper"

module NBA
  class PlayerProfileV2ValuesTest < Minitest::Test
    cover PlayerProfileV2

    def test_parses_team_id
      stub_profile_request

      assert_equal 1_610_612_744, PlayerProfileV2.career_regular_season(player: 201_939).first.team_id
    end

    def test_parses_team_abbreviation
      stub_profile_request

      assert_equal "GSW", PlayerProfileV2.career_regular_season(player: 201_939).first.team_abbreviation
    end

    def test_parses_player_age
      stub_profile_request

      assert_equal 21, PlayerProfileV2.career_regular_season(player: 201_939).first.player_age
    end

    def test_parses_gp
      stub_profile_request

      assert_equal 80, PlayerProfileV2.career_regular_season(player: 201_939).first.gp
    end

    def test_parses_gs
      stub_profile_request

      assert_equal 77, PlayerProfileV2.career_regular_season(player: 201_939).first.gs
    end

    def test_parses_min
      stub_profile_request

      assert_in_delta 36.2, PlayerProfileV2.career_regular_season(player: 201_939).first.min
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
