require_relative "../../test_helper"
require_relative "../box_score/box_score_v3_test_helpers"

module NBA
  class BoxScoreMiscV3EdgeCasesStatsTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreMiscV3

    def test_player_stats_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, BoxScoreMiscV3.player_stats(game: "0022400001", client: mock_client).size
      mock_client.verify
    end

    def test_team_stats_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, BoxScoreMiscV3.team_stats(game: "0022400001", client: mock_client).size
      mock_client.verify
    end

    def test_player_stats_returns_empty_when_no_box_score
      stub_request(:get, /boxscoremiscv3/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreMiscV3.player_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_no_box_score
      stub_request(:get, /boxscoremiscv3/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreMiscV3.team_stats(game: "0022400001").size
    end

    def test_handles_empty_players_array
      response = {boxScoreMisc: {homeTeam: {players: []}, awayTeam: {players: []}}}
      stub_request(:get, /boxscoremiscv3/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreMiscV3.player_stats(game: "0022400001").size
    end

    def test_handles_nil_away_team
      home_stats = misc_team_stats
      response = {boxScoreMisc: {homeTeam: {teamId: Team::GSW, teamName: "Warriors", statistics: home_stats}, awayTeam: nil}}
      stub_request(:get, /boxscoremiscv3/).to_return(body: response.to_json)

      stats = BoxScoreMiscV3.team_stats(game: "0022400001")

      assert_equal 1, stats.size
    end

    def test_handles_nil_players_in_team
      response = {boxScoreMisc: {homeTeam: {players: nil}, awayTeam: {players: nil}}}
      stub_request(:get, /boxscoremiscv3/).to_return(body: response.to_json)

      stats = BoxScoreMiscV3.player_stats(game: "0022400001")

      assert_equal 0, stats.size
    end

    def test_handles_missing_home_team
      response = {boxScoreMisc: {awayTeam: {players: [misc_player_data]}}}
      stub_request(:get, /boxscoremiscv3/).to_return(body: response.to_json)

      stats = BoxScoreMiscV3.player_stats(game: "0022400001")

      assert_equal 1, stats.size
    end

    def test_handles_missing_away_team
      response = {boxScoreMisc: {homeTeam: {players: [misc_player_data]}}}
      stub_request(:get, /boxscoremiscv3/).to_return(body: response.to_json)

      stats = BoxScoreMiscV3.player_stats(game: "0022400001")

      assert_equal 1, stats.size
    end

    def test_handles_missing_home_team_for_teams
      away_stats = misc_team_stats
      response = {boxScoreMisc: {awayTeam: {teamId: Team::LAL, teamName: "Lakers", statistics: away_stats}}}
      stub_request(:get, /boxscoremiscv3/).to_return(body: response.to_json)

      stats = BoxScoreMiscV3.team_stats(game: "0022400001")

      assert_equal 1, stats.size
    end
  end
end
