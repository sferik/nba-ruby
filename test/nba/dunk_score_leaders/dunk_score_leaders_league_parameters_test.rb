require_relative "../../test_helper"

module NBA
  class DunkScoreLeadersLeagueParametersTest < Minitest::Test
    cover DunkScoreLeaders

    def test_all_with_league_object
      league = League.new(id: "00")
      stub_request(:get, /dunkscoreleaders.*LeagueID=00/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all(league: league)

      assert_requested :get, /dunkscoreleaders.*LeagueID=00/
    end

    def test_all_with_league_string
      stub_request(:get, /dunkscoreleaders.*LeagueID=00/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all(league: "00")

      assert_requested :get, /dunkscoreleaders.*LeagueID=00/
    end

    def test_all_default_league_is_nba
      stub_request(:get, /dunkscoreleaders.*LeagueID=00/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all

      assert_requested :get, /dunkscoreleaders.*LeagueID=00/
    end

    private

    def dunk_score_leaders_response
      {resultSets: [{name: "DunkScoreLeaders",
                     headers: %w[RANK PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION DUNK_SCORE],
                     rowSet: [[1, 1_631_094, "Paolo Banchero", Team::ORL, "ORL", 85.5]]}]}
    end
  end
end
