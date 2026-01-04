require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreFourFactorsV3EdgeCasesPlayerTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreFourFactorsV3

    def test_player_stats_with_period_params
      stub_request(:get, /boxscorefourfactorsv3.*GameID=0022400001/)
        .to_return(body: four_factors_response.to_json)
      BoxScoreFourFactorsV3.player_stats(game: "0022400001", start_period: 1, end_period: 2)

      assert_requested :get, /boxscorefourfactorsv3.*StartPeriod=1/
      assert_requested :get, /boxscorefourfactorsv3.*EndPeriod=2/
    end

    def test_player_stats_uses_default_period_params
      stub_request(:get, /boxscorefourfactorsv3.*GameID=0022400001/)
        .to_return(body: four_factors_response.to_json)
      BoxScoreFourFactorsV3.player_stats(game: "0022400001")

      assert_requested :get, /boxscorefourfactorsv3.*StartPeriod=0/
      assert_requested :get, /boxscorefourfactorsv3.*EndPeriod=0/
    end

    def test_player_stats_accepts_game_object
      stub_request(:get, /boxscorefourfactorsv3.*GameID=0022400001/)
        .to_return(body: four_factors_response.to_json)
      game = Game.new(id: "0022400001")
      BoxScoreFourFactorsV3.player_stats(game: game)

      assert_requested :get, /boxscorefourfactorsv3.*GameID=0022400001/
    end

    def test_player_stats_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, BoxScoreFourFactorsV3.player_stats(game: "0022400001", client: mock_client).size
      mock_client.verify
    end

    def test_player_stats_returns_empty_when_no_box_score
      stub_request(:get, /boxscorefourfactorsv3/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreFourFactorsV3.player_stats(game: "0022400001").size
    end

    def test_handles_empty_players_array
      response = {boxScoreFourFactors: {homeTeam: {players: []}, awayTeam: {players: []}}}
      stub_request(:get, /boxscorefourfactorsv3/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreFourFactorsV3.player_stats(game: "0022400001").size
    end

    def test_handles_nil_players_in_team
      response = {boxScoreFourFactors: {homeTeam: {players: nil}, awayTeam: {players: nil}}}
      stub_request(:get, /boxscorefourfactorsv3/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreFourFactorsV3.player_stats(game: "0022400001").size
    end

    def test_handles_missing_home_team
      response = {boxScoreFourFactors: {awayTeam: {players: [four_factors_player_data]}}}
      stub_request(:get, /boxscorefourfactorsv3/).to_return(body: response.to_json)

      assert_equal 1, BoxScoreFourFactorsV3.player_stats(game: "0022400001").size
    end

    def test_handles_missing_away_team
      response = {boxScoreFourFactors: {homeTeam: {players: [four_factors_player_data]}}}
      stub_request(:get, /boxscorefourfactorsv3/).to_return(body: response.to_json)

      assert_equal 1, BoxScoreFourFactorsV3.player_stats(game: "0022400001").size
    end

    private

    def four_factors_response
      {boxScoreFourFactors: {homeTeam: home_team, awayTeam: away_team}}
    end

    def home_team
      {teamId: Team::GSW, teamName: "Warriors", teamTricode: "GSW", teamCity: "Golden State",
       statistics: four_factors_team_stats, players: [four_factors_player_data]}
    end

    def away_team
      {teamId: Team::LAL, teamName: "Lakers", teamTricode: "LAL", teamCity: "Los Angeles",
       statistics: four_factors_team_stats, players: []}
    end
  end
end
