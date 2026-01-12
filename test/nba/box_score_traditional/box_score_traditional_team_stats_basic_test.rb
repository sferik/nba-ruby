require_relative "../../test_helper"

module NBA
  class BoxScoreTraditionalTeamStatsBasicTest < Minitest::Test
    cover BoxScoreTraditional

    def test_team_stats_returns_collection
      stub_box_score_request

      assert_instance_of Collection, BoxScoreTraditional.team_stats(game: "0022400001")
    end

    def test_team_stats_uses_correct_game_id_in_path
      stub_box_score_request

      BoxScoreTraditional.team_stats(game: "0022400001")

      assert_requested :get, /boxscoretraditionalv2.*GameID=0022400001/
    end

    def test_team_stats_parses_result_set_successfully
      stub_box_score_request

      stats = BoxScoreTraditional.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_team_stats_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreTraditional.team_stats(game: "001").size
    end

    def test_team_stats_returns_empty_when_no_headers
      response = {resultSets: [{name: "TeamStats", headers: nil, rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreTraditional.team_stats(game: "001").size
    end

    def test_team_stats_returns_empty_when_no_rows
      response = {resultSets: [{name: "TeamStats", headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreTraditional.team_stats(game: "001").size
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [
        {name: "PlayerStats", headers: [], rowSet: []},
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]}
      ]}
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST STL BLK TO PF PTS PLUS_MINUS]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00", 42, 88, 0.477, 15, 40,
        0.375, 20, 25, 0.8, 10, 35, 45, 28, 8, 5, 12, 18, 119, 12]
    end
  end
end
