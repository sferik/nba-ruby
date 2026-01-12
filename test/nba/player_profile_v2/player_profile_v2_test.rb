require_relative "../../test_helper"

module NBA
  class PlayerProfileV2Test < Minitest::Test
    cover PlayerProfileV2

    def test_career_regular_season_returns_collection
      stub_profile_request

      result = PlayerProfileV2.career_regular_season(player: 201_939)

      assert_instance_of Collection, result
    end

    def test_career_regular_season_sends_correct_endpoint
      stub_request(:get, /playerprofilev2.*PlayerID=201939/).to_return(body: profile_response.to_json)

      PlayerProfileV2.career_regular_season(player: 201_939)

      assert_requested :get, /playerprofilev2.*PlayerID=201939/
    end

    def test_career_regular_season_parses_stats
      stub_profile_request

      stat = PlayerProfileV2.career_regular_season(player: 201_939).first

      assert_equal 201_939, stat.player_id
      assert_equal "2009-10", stat.season_id
    end

    def test_career_post_season_returns_collection
      stub_profile_request

      result = PlayerProfileV2.career_post_season(player: 201_939)

      assert_instance_of Collection, result
    end

    def test_career_post_season_parses_from_correct_result_set
      stub_profile_request

      stat = PlayerProfileV2.career_post_season(player: 201_939).first

      assert_equal 201_939, stat.player_id
      assert_equal "2012-13", stat.season_id
    end

    def test_with_player_object
      player = Player.new(id: 201_939)
      stub_request(:get, /PlayerID=201939/).to_return(body: profile_response.to_json)

      PlayerProfileV2.career_regular_season(player: player)

      assert_requested :get, /PlayerID=201939/
    end

    def test_returns_empty_collection_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = PlayerProfileV2.career_regular_season(player: 201_939, client: mock_client)

      assert_instance_of Collection, result
      assert_empty result
      mock_client.verify
    end

    def test_returns_empty_collection_for_empty_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, "", [String]

      result = PlayerProfileV2.career_regular_season(player: 201_939, client: mock_client)

      assert_instance_of Collection, result
      assert_empty result
      mock_client.verify
    end

    def test_constants_defined
      assert_equal "CareerTotalsRegularSeason", PlayerProfileV2::CAREER_REGULAR_SEASON
      assert_equal "CareerTotalsPostSeason", PlayerProfileV2::CAREER_POST_SEASON
      assert_equal "SeasonTotalsRegularSeason", PlayerProfileV2::SEASON_REGULAR_SEASON
      assert_equal "SeasonTotalsPostSeason", PlayerProfileV2::SEASON_POST_SEASON
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

    def career_post_row
      [201_939, "2012-13", 1_610_612_744, "GSW", 24, 12, 12, 38.5,
        9.1, 19.2, 0.473, 3.8, 8.8, 0.435, 4.9, 5.4, 0.905, 0.6, 3.6, 4.2, 7.1, 1.8, 0.3, 3.5, 2.8, 26.9]
    end

    def profile_response
      {resultSets: [
        {name: "CareerTotalsRegularSeason", headers: profile_headers, rowSet: [career_regular_row]},
        {name: "CareerTotalsPostSeason", headers: profile_headers, rowSet: [career_post_row]}
      ]}
    end
  end
end
