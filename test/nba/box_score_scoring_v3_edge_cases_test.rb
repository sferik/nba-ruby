require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreScoringV3EdgeCasesTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreScoringV3

    def test_constants_defined
      assert_equal "PlayerStats", BoxScoreScoringV3::PLAYER_STATS
      assert_equal "TeamStats", BoxScoreScoringV3::TEAM_STATS
    end

    def test_player_stats_with_period_params
      stub_request(:get, /boxscorescoringv3.*GameID=0022400001/)
        .to_return(body: scoring_v3_response.to_json)

      BoxScoreScoringV3.player_stats(
        game: "0022400001",
        start_period: 1,
        end_period: 2
      )

      assert_requested :get, /boxscorescoringv3.*StartPeriod=1/
      assert_requested :get, /boxscorescoringv3.*EndPeriod=2/
    end

    def test_player_stats_uses_default_period_params
      stub_request(:get, /boxscorescoringv3.*GameID=0022400001/)
        .to_return(body: scoring_v3_response.to_json)

      BoxScoreScoringV3.player_stats(game: "0022400001")

      assert_requested :get, /boxscorescoringv3.*StartPeriod=0/
      assert_requested :get, /boxscorescoringv3.*EndPeriod=0/
    end

    def test_player_stats_accepts_game_object
      stub_request(:get, /boxscorescoringv3.*GameID=0022400001/)
        .to_return(body: scoring_v3_response.to_json)

      game = Game.new(id: "0022400001")
      BoxScoreScoringV3.player_stats(game: game)

      assert_requested :get, /boxscorescoringv3.*GameID=0022400001/
    end

    def test_team_stats_with_period_params
      stub_request(:get, /boxscorescoringv3.*GameID=0022400001/)
        .to_return(body: scoring_v3_response.to_json)

      BoxScoreScoringV3.team_stats(
        game: "0022400001",
        start_period: 1,
        end_period: 2
      )

      assert_requested :get, /boxscorescoringv3.*StartPeriod=1/
      assert_requested :get, /boxscorescoringv3.*EndPeriod=2/
    end

    def test_team_stats_uses_default_period_params
      stub_request(:get, /boxscorescoringv3.*GameID=0022400001/)
        .to_return(body: scoring_v3_response.to_json)

      BoxScoreScoringV3.team_stats(game: "0022400001")

      assert_requested :get, /boxscorescoringv3.*StartPeriod=0/
      assert_requested :get, /boxscorescoringv3.*EndPeriod=0/
    end

    def test_team_stats_accepts_game_object
      stub_request(:get, /boxscorescoringv3.*GameID=0022400001/)
        .to_return(body: scoring_v3_response.to_json)

      game = Game.new(id: "0022400001")
      BoxScoreScoringV3.team_stats(game: game)

      assert_requested :get, /boxscorescoringv3.*GameID=0022400001/
    end
  end
end
