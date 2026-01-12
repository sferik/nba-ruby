require_relative "../../test_helper"

module NBA
  class TeamGameLogFindSeasonTest < Minitest::Test
    cover TeamGameLog

    def test_find_with_custom_season
      stub_request(:get, /teamgamelog.*Season=2023-24/).to_return(body: team_game_log_response.to_json)

      TeamGameLog.find(team: Team::GSW, season: 2023)

      assert_requested :get, /teamgamelog.*Season=2023-24/
    end

    def test_find_default_season_type_is_regular_season
      stub_request(:get, /teamgamelog.*SeasonType=Regular%20Season/).to_return(body: team_game_log_response.to_json)

      TeamGameLog.find(team: Team::GSW)

      assert_requested :get, /teamgamelog.*SeasonType=Regular%20Season/
    end

    def test_find_with_playoffs_season_type
      stub_request(:get, /teamgamelog.*SeasonType=Playoffs/).to_return(body: team_game_log_response.to_json)

      TeamGameLog.find(team: Team::GSW, season_type: TeamGameLog::PLAYOFFS)

      assert_requested :get, /teamgamelog.*SeasonType=Playoffs/
    end

    private

    def team_game_log_response
      {resultSets: [{headers: %w[Team_ID], rowSet: [[Team::GSW]]}]}
    end
  end
end
