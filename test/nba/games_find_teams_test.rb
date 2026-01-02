require_relative "../test_helper"

module NBA
  class GamesFindTeamsTest < Minitest::Test
    cover Games

    def test_find_hydrates_home_team
      stub_box_score_summary_request

      game = Games.find("0022400001")

      assert_instance_of Team, game.home_team
      assert_equal Team::GSW, game.home_team.id
      assert_equal "Golden State Warriors", game.home_team.full_name
    end

    def test_find_hydrates_away_team
      stub_box_score_summary_request

      game = Games.find("0022400001")

      assert_instance_of Team, game.away_team
      assert_equal Team::LAL, game.away_team.id
      assert_equal "Los Angeles Lakers", game.away_team.full_name
    end

    private

    def stub_box_score_summary_request
      stub_request(:get, /boxscoresummaryv2/).to_return(body: box_score_summary_response.to_json)
    end

    def box_score_summary_response
      {resultSets: [{name: "GameSummary", headers: %w[GAME_ID HOME_TEAM_ID VISITOR_TEAM_ID],
                     rowSet: [["0022400001", Team::GSW, Team::LAL]]}]}
    end
  end
end
