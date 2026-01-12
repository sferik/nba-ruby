require_relative "../../test_helper"
require_relative "../box_score/box_score_v3_test_helpers"

module NBA
  class BoxScoreAdvancedV3ParamsTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreAdvancedV3

    def test_constants_defined
      assert_equal "PlayerStats", BoxScoreAdvancedV3::PLAYER_STATS
      assert_equal "TeamStats", BoxScoreAdvancedV3::TEAM_STATS
    end

    def test_player_stats_with_period_params
      stub_request(:get, /boxscoreadvancedv3.*GameID=0022400001/)
        .to_return(body: advanced_v3_response.to_json)

      BoxScoreAdvancedV3.player_stats(game: "0022400001", start_period: 1, end_period: 2)

      assert_requested :get, /boxscoreadvancedv3.*StartPeriod=1/
      assert_requested :get, /boxscoreadvancedv3.*EndPeriod=2/
    end

    def test_player_stats_uses_default_period_params
      stub_request(:get, /boxscoreadvancedv3.*GameID=0022400001/)
        .to_return(body: advanced_v3_response.to_json)

      BoxScoreAdvancedV3.player_stats(game: "0022400001")

      assert_requested :get, /boxscoreadvancedv3.*StartPeriod=0/
      assert_requested :get, /boxscoreadvancedv3.*EndPeriod=0/
    end

    def test_player_stats_accepts_game_object
      stub_request(:get, /boxscoreadvancedv3.*GameID=0022400001/)
        .to_return(body: advanced_v3_response.to_json)

      game = Game.new(id: "0022400001")
      BoxScoreAdvancedV3.player_stats(game: game)

      assert_requested :get, /boxscoreadvancedv3.*GameID=0022400001/
    end

    def test_team_stats_with_period_params
      stub_request(:get, /boxscoreadvancedv3.*GameID=0022400001/)
        .to_return(body: advanced_v3_response.to_json)

      BoxScoreAdvancedV3.team_stats(game: "0022400001", start_period: 1, end_period: 2)

      assert_requested :get, /boxscoreadvancedv3.*StartPeriod=1/
      assert_requested :get, /boxscoreadvancedv3.*EndPeriod=2/
    end

    def test_team_stats_uses_default_period_params
      stub_request(:get, /boxscoreadvancedv3.*GameID=0022400001/)
        .to_return(body: advanced_v3_response.to_json)

      BoxScoreAdvancedV3.team_stats(game: "0022400001")

      assert_requested :get, /boxscoreadvancedv3.*StartPeriod=0/
      assert_requested :get, /boxscoreadvancedv3.*EndPeriod=0/
    end

    def test_team_stats_accepts_game_object
      stub_request(:get, /boxscoreadvancedv3.*GameID=0022400001/)
        .to_return(body: advanced_v3_response.to_json)

      game = Game.new(id: "0022400001")
      BoxScoreAdvancedV3.team_stats(game: game)

      assert_requested :get, /boxscoreadvancedv3.*GameID=0022400001/
    end

    private

    def advanced_v3_response
      {boxScoreAdvanced: {homeTeam: home_team_data, awayTeam: away_team_data}}
    end

    def home_team_data
      {teamId: Team::GSW, teamName: "Warriors", teamTricode: "GSW",
       teamCity: "Golden State", statistics: team_advanced_stats,
       players: [player_advanced_data]}
    end

    def away_team_data
      {teamId: Team::LAL, teamName: "Lakers", teamTricode: "LAL",
       teamCity: "Los Angeles", statistics: team_advanced_stats, players: []}
    end
  end
end
