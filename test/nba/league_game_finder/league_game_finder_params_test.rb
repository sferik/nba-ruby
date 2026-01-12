require_relative "../../test_helper"

module NBA
  class LeagueGameFinderParamsTest < Minitest::Test
    cover LeagueGameFinder

    def test_by_team_with_season_param
      path_called = nil
      mock_client = Minitest::Mock.new
      mock_client.expect(:get, team_game_finder_response.to_json) do |path|
        path_called = path
        true
      end

      LeagueGameFinder.by_team(team: Team::GSW, season: 2023, client: mock_client)

      mock_client.verify

      assert_match(/leaguegamefinder\?TeamID=#{Team::GSW}&SeasonType=Regular Season&LeagueID=00&Season=2023-24$/o, path_called)
    end

    def test_by_team_with_season_type_param
      stub_request(:get, /leaguegamefinder.*SeasonType=Playoffs/)
        .to_return(body: team_game_finder_response.to_json)
      LeagueGameFinder.by_team(team: Team::GSW, season_type: LeagueGameFinder::PLAYOFFS)

      assert_requested :get, /leaguegamefinder.*SeasonType=Playoffs/
    end

    def test_by_team_accepts_team_object
      stub_request(:get, /leaguegamefinder.*TeamID=#{Team::GSW}/o)
        .to_return(body: team_game_finder_response.to_json)
      team = Team.new(id: Team::GSW)
      LeagueGameFinder.by_team(team: team)

      assert_requested :get, /leaguegamefinder.*TeamID=#{Team::GSW}/o
    end

    def test_by_player_with_season_param
      path_called = nil
      mock_client = Minitest::Mock.new
      mock_client.expect(:get, player_game_finder_response.to_json) do |path|
        path_called = path
        true
      end

      LeagueGameFinder.by_player(player: 201_939, season: 2023, client: mock_client)

      mock_client.verify

      assert_match(/leaguegamefinder\?PlayerID=201939&SeasonType=Regular Season&LeagueID=00&Season=2023-24$/, path_called)
    end

    def test_by_player_accepts_player_object
      stub_request(:get, /leaguegamefinder.*PlayerID=201939/)
        .to_return(body: player_game_finder_response.to_json)
      player = Player.new(id: 201_939)
      LeagueGameFinder.by_player(player: player)

      assert_requested :get, /leaguegamefinder.*PlayerID=201939/
    end

    def test_by_team_uses_default_season_type
      stub_request(:get, /leaguegamefinder.*SeasonType=Regular%20Season/)
        .to_return(body: team_game_finder_response.to_json)
      LeagueGameFinder.by_team(team: Team::GSW)

      assert_requested :get, /leaguegamefinder.*SeasonType=Regular%20Season/
    end

    def test_by_player_uses_default_season_type
      stub_request(:get, /leaguegamefinder.*PlayerID=201939.*SeasonType=Regular%20Season/)
        .to_return(body: player_game_finder_response.to_json)
      LeagueGameFinder.by_player(player: 201_939)

      assert_requested :get, /leaguegamefinder.*SeasonType=Regular%20Season/
    end

    def test_by_team_without_season_excludes_season_param
      path_called = nil
      mock_client = Minitest::Mock.new
      mock_client.expect(:get, team_game_finder_response.to_json) do |path|
        path_called = path
        true
      end

      LeagueGameFinder.by_team(team: Team::GSW, client: mock_client)

      mock_client.verify

      refute_match(/&Season=/, path_called)
      assert_match(/&LeagueID=00$/, path_called)
    end

    def test_by_player_without_season_excludes_season_param
      path_called = nil
      mock_client = Minitest::Mock.new
      mock_client.expect(:get, player_game_finder_response.to_json) do |path|
        path_called = path
        true
      end

      LeagueGameFinder.by_player(player: 201_939, client: mock_client)

      mock_client.verify

      refute_match(/&Season=/, path_called)
      assert_match(/&LeagueID=00$/, path_called)
    end

    def test_constants_defined
      assert_equal "TeamGameFinderResults", LeagueGameFinder::TEAM_GAMES
      assert_equal "PlayerGameFinderResults", LeagueGameFinder::PLAYER_GAMES
      assert_equal "Regular Season", LeagueGameFinder::REGULAR_SEASON
      assert_equal "Playoffs", LeagueGameFinder::PLAYOFFS
    end

    private

    def team_game_finder_response
      {resultSets: [{name: "TeamGameFinderResults", headers: %w[GAME_ID], rowSet: [["001"]]}]}
    end

    def player_game_finder_response
      {resultSets: [{name: "PlayerGameFinderResults", headers: %w[GAME_ID], rowSet: [["001"]]}]}
    end
  end
end
