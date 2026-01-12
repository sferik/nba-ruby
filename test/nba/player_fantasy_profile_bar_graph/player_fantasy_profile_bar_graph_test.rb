require_relative "../../test_helper"

module NBA
  class PlayerFantasyProfileBarGraphTest < Minitest::Test
    cover PlayerFantasyProfileBarGraph

    def test_last_five_games_avg_returns_collection
      stub_request(:get, /playerfantasyprofilebargraph/).to_return(body: last_five_response.to_json)

      assert_instance_of Collection, PlayerFantasyProfileBarGraph.last_five_games_avg(player: 201_939)
    end

    def test_last_five_games_avg_uses_correct_result_set
      stub_request(:get, /playerfantasyprofilebargraph/).to_return(body: response_with_both_result_sets.to_json)

      assert_equal "Last5", PlayerFantasyProfileBarGraph.last_five_games_avg(player: 201_939).first.player_name
    end

    def test_season_avg_returns_collection
      stub_request(:get, /playerfantasyprofilebargraph/).to_return(body: season_response.to_json)

      assert_instance_of Collection, PlayerFantasyProfileBarGraph.season_avg(player: 201_939)
    end

    def test_season_avg_uses_correct_result_set
      stub_request(:get, /playerfantasyprofilebargraph/).to_return(body: response_with_both_result_sets.to_json)

      assert_equal "Season", PlayerFantasyProfileBarGraph.season_avg(player: 201_939).first.player_name
    end

    def test_returns_empty_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_empty PlayerFantasyProfileBarGraph.last_five_games_avg(player: 201_939, client: mock_client)
      mock_client.verify
    end

    def test_returns_empty_for_empty_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, "", [String]

      assert_empty PlayerFantasyProfileBarGraph.last_five_games_avg(player: 201_939, client: mock_client)
      mock_client.verify
    end

    private

    def last_five_response
      {resultSets: [{name: "LastFiveGamesAvg", headers: headers, rowSet: [row_data("Last5")]}]}
    end

    def season_response
      {resultSets: [{name: "SeasonAvg", headers: headers, rowSet: [row_data("Season")]}]}
    end

    def response_with_both_result_sets
      {resultSets: [
        {name: "LastFiveGamesAvg", headers: headers, rowSet: [row_data("Last5")]},
        {name: "SeasonAvg", headers: headers, rowSet: [row_data("Season")]}
      ]}
    end

    def row_data(name)
      [201_939, name, 1_610_612_744, "GSW", 45.2, 52.1, 26.4, 5.7, 6.1, 4.3, 0.467, 0.917, 1.2, 0.3, 3.1]
    end

    def headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION FAN_DUEL_PTS NBA_FANTASY_PTS PTS REB AST
        FG3M FG_PCT FT_PCT STL BLK TOV]
    end
  end
end
