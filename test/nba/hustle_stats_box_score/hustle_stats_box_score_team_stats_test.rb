require_relative "../../test_helper"

module NBA
  class HustleStatsBoxScoreTeamStatsTest < Minitest::Test
    cover HustleStatsBoxScore

    def test_team_stats_returns_collection
      stub_hustle_request

      result = HustleStatsBoxScore.team_stats(game: "0022400001")

      assert_instance_of Collection, result
    end

    def test_team_stats_uses_correct_game_id_in_path
      stub_hustle_request

      HustleStatsBoxScore.team_stats(game: "0022400001")

      assert_requested :get, /hustlestatsboxscore\?GameID=0022400001/
    end

    def test_team_stats_parses_successfully
      stub_hustle_request

      stats = HustleStatsBoxScore.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_team_stats_sets_game_id
      stub_hustle_request

      stats = HustleStatsBoxScore.team_stats(game: "0022400001")

      assert_equal "0022400001", stats.first.game_id
    end

    def test_team_stats_accepts_game_object
      stub_hustle_request
      game = Game.new(id: "0022400001")

      HustleStatsBoxScore.team_stats(game: game)

      assert_requested :get, /GameID=0022400001/
    end

    def test_team_stats_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, team_stats_response.to_json, [String]

      HustleStatsBoxScore.team_stats(game: "0022400001", client: mock_client)

      mock_client.verify
    end

    private

    def stub_hustle_request
      stub_request(:get, /hustlestatsboxscore/).to_return(body: team_stats_response.to_json)
    end

    def team_stats_response
      {resultSets: [{name: "TeamStats", headers: team_headers, rowSet: [team_row]}]}
    end

    def team_headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MINUTES PTS CONTESTED_SHOTS CONTESTED_SHOTS_2PT
        CONTESTED_SHOTS_3PT DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS SCREEN_AST_PTS
        LOOSE_BALLS_RECOVERED OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED
        BOX_OUTS OFF_BOXOUTS DEF_BOXOUTS]
    end

    def team_row
      [Team::GSW, "Warriors", "GSW", "Golden State", "240:00", 118,
        45, 30, 15, 12, 2, 18, 36, 8, 3, 5, 25, 8, 17]
    end
  end
end
