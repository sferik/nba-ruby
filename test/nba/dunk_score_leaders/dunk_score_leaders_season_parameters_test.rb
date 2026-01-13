require_relative "../../test_helper"

module NBA
  class DunkScoreLeadersSeasonParametersTest < Minitest::Test
    cover DunkScoreLeaders

    def test_all_with_custom_season
      stub_request(:get, /dunkscoreleaders.*Season=2022-23/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all(season: 2022)

      assert_requested :get, /dunkscoreleaders.*Season=2022-23/
    end

    def test_all_with_playoffs_season_type
      stub_request(:get, /dunkscoreleaders.*SeasonType=Playoffs/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all(season_type: "Playoffs")

      assert_requested :get, /dunkscoreleaders.*SeasonType=Playoffs/
    end

    def test_all_default_season_type_is_regular_season
      stub_request(:get, /dunkscoreleaders.*SeasonType=Regular%20Season/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all

      assert_requested :get, /dunkscoreleaders.*SeasonType=Regular%20Season/
    end

    private

    def dunk_score_leaders_response
      {resultSets: [{name: "DunkScoreLeaders",
                     headers: %w[RANK PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION DUNK_SCORE],
                     rowSet: [[1, 1_631_094, "Paolo Banchero", Team::ORL, "ORL", 85.5]]}]}
    end
  end
end
