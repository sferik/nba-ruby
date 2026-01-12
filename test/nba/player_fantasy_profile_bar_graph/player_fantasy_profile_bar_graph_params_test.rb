require_relative "../../test_helper"

module NBA
  class PlayerFantasyProfileBarGraphParamsTest < Minitest::Test
    cover PlayerFantasyProfileBarGraph

    def test_includes_player_id_in_path
      request = stub_request(:get, /playerfantasyprofilebargraph.*PlayerID=201939/)
        .to_return(body: empty_response.to_json)
      PlayerFantasyProfileBarGraph.last_five_games_avg(player: 201_939)

      assert_requested request
    end

    def test_extracts_id_from_player_object
      player = Minitest::Mock.new
      player.expect :id, 201_939
      request = stub_request(:get, /playerfantasyprofilebargraph.*PlayerID=201939/)
        .to_return(body: empty_response.to_json)
      PlayerFantasyProfileBarGraph.last_five_games_avg(player: player)

      assert_requested request
      player.verify
    end

    def test_includes_season_in_path
      request = stub_request(:get, /playerfantasyprofilebargraph.*Season=2023-24/)
        .to_return(body: empty_response.to_json)
      PlayerFantasyProfileBarGraph.last_five_games_avg(player: 201_939, season: 2023)

      assert_requested request
    end

    def test_includes_season_type_in_path
      request = stub_request(:get, /playerfantasyprofilebargraph.*SeasonType=Playoffs/)
        .to_return(body: empty_response.to_json)
      PlayerFantasyProfileBarGraph.last_five_games_avg(player: 201_939, season_type: "Playoffs")

      assert_requested request
    end

    def test_includes_league_id_in_path
      request = stub_request(:get, /playerfantasyprofilebargraph.*LeagueID=00/)
        .to_return(body: empty_response.to_json)
      PlayerFantasyProfileBarGraph.last_five_games_avg(player: 201_939)

      assert_requested request
    end

    def test_default_season_type_is_regular_season
      request = stub_request(:get, /playerfantasyprofilebargraph.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      PlayerFantasyProfileBarGraph.last_five_games_avg(player: 201_939)

      assert_requested request
    end

    def test_season_avg_includes_player_id_in_path
      request = stub_request(:get, /playerfantasyprofilebargraph.*PlayerID=201939/)
        .to_return(body: empty_response.to_json)
      PlayerFantasyProfileBarGraph.season_avg(player: 201_939)

      assert_requested request
    end

    def test_season_avg_extracts_id_from_player_object
      player = Minitest::Mock.new
      player.expect :id, 201_939
      request = stub_request(:get, /playerfantasyprofilebargraph.*PlayerID=201939/)
        .to_return(body: empty_response.to_json)
      PlayerFantasyProfileBarGraph.season_avg(player: player)

      assert_requested request
      player.verify
    end

    def test_season_avg_default_season_type_is_regular_season
      request = stub_request(:get, /playerfantasyprofilebargraph.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      PlayerFantasyProfileBarGraph.season_avg(player: 201_939)

      assert_requested request
    end

    private

    def empty_response
      {resultSets: [{name: "LastFiveGamesAvg", headers: [], rowSet: []}]}
    end
  end
end
