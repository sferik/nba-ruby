require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreTraditionalV3Test < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreTraditionalV3

    def test_player_stats_returns_collection
      stub_traditional_v3_request

      assert_instance_of Collection, BoxScoreTraditionalV3.player_stats(game: "0022400001")
    end

    def test_player_stats_parses_identity_attributes
      stub_traditional_v3_request

      stat = BoxScoreTraditionalV3.player_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
    end

    def test_player_stats_parses_shooting_stats
      stub_traditional_v3_request

      stat = BoxScoreTraditionalV3.player_stats(game: "0022400001").first

      assert_equal 10, stat.fgm
      assert_equal 20, stat.fga
      assert_in_delta 0.5, stat.fg_pct
      assert_equal 6, stat.fg3m
      assert_equal 12, stat.fg3a
    end

    def test_player_stats_parses_free_throw_stats
      stub_traditional_v3_request

      stat = BoxScoreTraditionalV3.player_stats(game: "0022400001").first

      assert_equal 6, stat.ftm
      assert_equal 7, stat.fta
      assert_in_delta 0.857, stat.ft_pct
    end

    def test_player_stats_parses_counting_stats
      stub_traditional_v3_request

      stat = BoxScoreTraditionalV3.player_stats(game: "0022400001").first

      assert_equal 1, stat.oreb
      assert_equal 4, stat.dreb
      assert_equal 5, stat.reb
      assert_equal 8, stat.ast
      assert_equal 2, stat.stl
    end

    def test_player_stats_parses_minutes
      stub_traditional_v3_request

      stat = BoxScoreTraditionalV3.player_stats(game: "0022400001").first

      assert_equal "32:45", stat.min
    end

    def test_team_stats_returns_collection
      stub_traditional_v3_request

      assert_instance_of Collection, BoxScoreTraditionalV3.team_stats(game: "0022400001")
    end

    def test_team_stats_parses_identity_attributes
      stub_traditional_v3_request

      stat = BoxScoreTraditionalV3.team_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
    end

    def test_team_stats_parses_shooting_stats
      stub_traditional_v3_request

      stat = BoxScoreTraditionalV3.team_stats(game: "0022400001").first

      assert_equal 42, stat.fgm
      assert_equal 88, stat.fga
      assert_in_delta 0.477, stat.fg_pct
      assert_equal 15, stat.fg3m
      assert_equal 38, stat.fg3a
    end

    def test_team_stats_parses_counting_stats
      stub_traditional_v3_request

      stat = BoxScoreTraditionalV3.team_stats(game: "0022400001").first

      assert_equal 10, stat.oreb
      assert_equal 35, stat.dreb
      assert_equal 45, stat.reb
      assert_equal 28, stat.ast
      assert_equal 8, stat.stl
    end

    def test_team_stats_parses_minutes
      stub_traditional_v3_request

      stat = BoxScoreTraditionalV3.team_stats(game: "0022400001").first

      assert_equal "240:00", stat.min
    end

    private

    def stub_traditional_v3_request
      stub_request(:get, /boxscoretraditionalv3.*GameID=0022400001/)
        .to_return(body: traditional_v3_response.to_json)
    end

    def traditional_v3_response
      {boxScoreTraditional: {homeTeam: home_team_data, awayTeam: away_team_data}}
    end

    def home_team_data
      {teamId: Team::GSW, teamName: "Warriors", teamTricode: "GSW",
       teamCity: "Golden State", statistics: traditional_team_stats,
       players: [traditional_player_data]}
    end

    def away_team_data
      {teamId: Team::LAL, teamName: "Lakers", teamTricode: "LAL",
       teamCity: "Los Angeles", statistics: traditional_team_stats, players: []}
    end
  end
end
