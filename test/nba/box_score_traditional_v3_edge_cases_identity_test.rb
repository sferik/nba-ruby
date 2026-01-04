require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreTraditionalV3EdgeCasesIdentityTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreTraditionalV3

    def test_player_stats_accepts_game_object
      verify_accepts_game_object(:player_stats, traditional_v3_response)
    end

    def test_team_stats_accepts_game_object
      verify_accepts_game_object(:team_stats, traditional_v3_response)
    end

    def test_starter_bench_stats_accepts_game_object
      verify_accepts_game_object(:starter_bench_stats, starter_bench_response)
    end

    def test_constants_defined
      assert_equal "PlayerStats", BoxScoreTraditionalV3::PLAYER_STATS
      assert_equal "TeamStats", BoxScoreTraditionalV3::TEAM_STATS
      assert_equal "TeamStarterBenchStats", BoxScoreTraditionalV3::STARTER_BENCH_STATS
    end

    def test_handles_empty_players_array
      response = build_response_with_empty_players
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreTraditionalV3.player_stats(game: "0022400001").size
    end

    def test_handles_nil_away_team
      response = {boxScoreTraditional: {homeTeam: team_with_stats, awayTeam: nil}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      assert_equal 1, BoxScoreTraditionalV3.team_stats(game: "0022400001").size
    end

    def test_player_stats_handles_missing_statistics_key
      player = build_player_without_statistics
      response = build_response_with_players([player])
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      stat = BoxScoreTraditionalV3.player_stats(game: "0022400001").first

      assert_statistics_fields_nil(stat)
    end

    def test_team_stats_handles_missing_statistics_key
      team = {teamId: Team::GSW, teamName: "Warriors"}
      response = {boxScoreTraditional: {homeTeam: team, awayTeam: nil}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      stat = BoxScoreTraditionalV3.team_stats(game: "0022400001").first

      assert_statistics_fields_nil(stat)
    end

    def test_handles_empty_starter_bench_stats
      response = build_response_with_empty_starter_bench
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreTraditionalV3.starter_bench_stats(game: "0022400001").size
    end

    private

    def verify_accepts_game_object(method_name, response)
      stub_request(:get, /boxscoretraditionalv3.*GameID=0022400001/)
        .to_return(body: response.to_json)
      game = Game.new(id: "0022400001")
      BoxScoreTraditionalV3.send(method_name, game: game)

      assert_requested :get, /boxscoretraditionalv3.*GameID=0022400001/
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

    def team_with_stats(team_id = Team::GSW)
      {teamId: team_id, statistics: traditional_team_stats, players: []}
    end

    def starter_bench_response
      {boxScoreTraditional: {homeTeam: home_team_with_starter_bench, awayTeam: nil}}
    end

    def home_team_with_starter_bench
      {teamId: Team::GSW, teamName: "Warriors", teamTricode: "GSW",
       teamCity: "Golden State",
       statistics: {starters: starter_bench_stats, bench: starter_bench_stats}}
    end

    def build_response_with_empty_players
      {boxScoreTraditional: {homeTeam: {players: []}, awayTeam: {players: []}}}
    end

    def build_player_without_statistics
      {personId: 201_939, firstName: "Stephen", familyName: "Curry",
       teamId: Team::GSW, teamTricode: "GSW", teamCity: "Golden State", position: "G"}
    end

    def build_response_with_players(players)
      {boxScoreTraditional: {homeTeam: {players: players}, awayTeam: {players: []}}}
    end

    def build_response_with_empty_starter_bench
      {boxScoreTraditional: {homeTeam: {teamId: Team::GSW, statistics: {}}, awayTeam: nil}}
    end

    def assert_statistics_fields_nil(stat)
      assert_nil stat.min
      assert_nil stat.fgm
    end
  end
end
