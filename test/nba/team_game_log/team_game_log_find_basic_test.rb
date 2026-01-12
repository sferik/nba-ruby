require_relative "../../test_helper"

module NBA
  class TeamGameLogFindBasicTest < Minitest::Test
    cover TeamGameLog

    def test_find_returns_collection
      stub_team_game_log_request

      assert_instance_of Collection, TeamGameLog.find(team: Team::GSW)
    end

    def test_find_uses_correct_team_id_in_path
      stub_team_game_log_request

      TeamGameLog.find(team: Team::GSW)

      assert_requested :get, /teamgamelog.*TeamID=#{Team::GSW}/o
    end

    def test_find_accepts_team_object
      stub_team_game_log_request
      team = Team.new(id: Team::GSW)

      TeamGameLog.find(team: team)

      assert_requested :get, /teamgamelog.*TeamID=#{Team::GSW}/o
    end

    private

    def stub_team_game_log_request
      stub_request(:get, /teamgamelog/).to_return(body: team_game_log_response.to_json)
    end

    def team_game_log_response
      {resultSets: [{headers: team_game_log_headers, rowSet: [team_game_log_row]}]}
    end

    def team_game_log_headers
      %w[Team_ID Game_ID GAME_DATE MATCHUP WL MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
    end

    def team_game_log_row
      [Team::GSW, "0022400001", "OCT 22, 2024", "GSW vs. LAL", "W", 240, 42, 88, 0.477, 15, 40, 0.375, 20, 25, 0.8,
        10, 35, 45, 28, 8, 5, 12, 18, 119, 12]
    end
  end
end
