require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreAdvancedV3TeamBasicTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreAdvancedV3

    def test_team_stats_returns_collection
      stub_advanced_v3_request

      assert_instance_of Collection, BoxScoreAdvancedV3.team_stats(game: "0022400001")
    end

    def test_team_stats_parses_identity_attributes
      stub_advanced_v3_request

      stat = BoxScoreAdvancedV3.team_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
    end

    def test_team_stats_parses_minutes
      stub_advanced_v3_request

      stat = BoxScoreAdvancedV3.team_stats(game: "0022400001").first

      assert_equal "240:00", stat.min
    end

    def test_team_stats_parses_offensive_ratings
      stub_advanced_v3_request

      stat = BoxScoreAdvancedV3.team_stats(game: "0022400001").first

      assert_in_delta 114.0, stat.e_off_rating
      assert_in_delta 115.2, stat.off_rating
      assert_in_delta 106.0, stat.e_def_rating
    end

    def test_team_stats_parses_defensive_and_net_ratings
      stub_advanced_v3_request

      stat = BoxScoreAdvancedV3.team_stats(game: "0022400001").first

      assert_in_delta 105.5, stat.def_rating
      assert_in_delta 8.0, stat.e_net_rating
      assert_in_delta 9.7, stat.net_rating
    end

    def test_team_stats_parses_tempo_stats
      stub_advanced_v3_request

      stat = BoxScoreAdvancedV3.team_stats(game: "0022400001").first

      assert_in_delta 100.0, stat.e_pace
      assert_in_delta 101.0, stat.pace
      assert_in_delta 100.5, stat.pace_per40
      assert_equal 100, stat.poss
    end

    private

    def stub_advanced_v3_request
      stub_request(:get, /boxscoreadvancedv3.*GameID=0022400001/)
        .to_return(body: advanced_v3_response.to_json)
    end

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
