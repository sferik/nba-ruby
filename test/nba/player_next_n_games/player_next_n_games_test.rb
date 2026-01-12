require_relative "../../test_helper"

module NBA
  class PlayerNextNGamesTest < Minitest::Test
    cover PlayerNextNGames

    def test_find_returns_collection
      stub_games_request

      result = PlayerNextNGames.find(player: 201_939)

      assert_instance_of Collection, result
    end

    def test_find_sends_correct_endpoint
      stub_request(:get, /playernextngames.*PlayerID=201939/).to_return(body: games_response.to_json)

      PlayerNextNGames.find(player: 201_939)

      assert_requested :get, /playernextngames.*PlayerID=201939/
    end

    def test_find_sends_number_of_games_param
      stub_request(:get, /NumberOfGames=10/).to_return(body: games_response.to_json)

      PlayerNextNGames.find(player: 201_939, number_of_games: 10)

      assert_requested :get, /NumberOfGames=10/
    end

    def test_find_defaults_to_five_games
      stub_request(:get, /NumberOfGames=5/).to_return(body: games_response.to_json)

      PlayerNextNGames.find(player: 201_939)

      assert_requested :get, /NumberOfGames=5/
    end

    def test_find_parses_game_info
      stub_games_request

      game = PlayerNextNGames.find(player: 201_939).first

      assert_equal "0022400100", game.game_id
      assert_equal "JAN 15, 2025", game.game_date
      assert_equal "7:30 PM ET", game.game_time
    end

    def test_find_parses_home_team_info
      stub_games_request

      game = PlayerNextNGames.find(player: 201_939).first

      assert_equal 1_610_612_744, game.home_team_id
      assert_equal "Golden State Warriors", game.home_team_name
      assert_equal "GSW", game.home_team_abbreviation
    end

    def test_find_parses_visitor_team_info
      stub_games_request

      game = PlayerNextNGames.find(player: 201_939).first

      assert_equal 1_610_612_747, game.visitor_team_id
      assert_equal "Los Angeles Lakers", game.visitor_team_name
      assert_equal "LAL", game.visitor_team_abbreviation
    end

    def test_find_parses_team_nicknames
      stub_games_request

      game = PlayerNextNGames.find(player: 201_939).first

      assert_equal "Warriors", game.home_team_nickname
      assert_equal "Lakers", game.visitor_team_nickname
    end

    def test_find_with_player_object
      player = Player.new(id: 201_939)
      stub_request(:get, /PlayerID=201939/).to_return(body: games_response.to_json)

      PlayerNextNGames.find(player: player)

      assert_requested :get, /PlayerID=201939/
    end

    def test_find_returns_empty_collection_for_nil_response
      stub_request(:get, /playernextngames/).to_return(body: nil)

      result = PlayerNextNGames.find(player: 201_939)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_find_parses_from_correct_result_set
      stub_request(:get, /playernextngames/).to_return(body: multi_result_response.to_json)

      game = PlayerNextNGames.find(player: 201_939).first

      assert_equal "0022400100", game.game_id
    end

    def test_constants_defined
      assert_equal "NextNGames", PlayerNextNGames::RESULT_SET_NAME
    end

    private

    def stub_games_request
      stub_request(:get, /playernextngames/).to_return(body: games_response.to_json)
    end

    def multi_result_response
      {resultSets: [
        {name: "OtherResultSet", headers: ["GAME_ID"], rowSet: [["9999999"]]},
        {name: "NextNGames", headers: games_headers, rowSet: [games_row]}
      ]}
    end

    def games_headers
      %w[GAME_ID GAME_DATE GAME_TIME HOME_TEAM_ID VISITOR_TEAM_ID HOME_TEAM_NAME VISITOR_TEAM_NAME
        HOME_TEAM_ABBREVIATION VISITOR_TEAM_ABBREVIATION HOME_TEAM_NICKNAME VISITOR_TEAM_NICKNAME]
    end

    def games_row
      ["0022400100", "JAN 15, 2025", "7:30 PM ET", 1_610_612_744, 1_610_612_747,
        "Golden State Warriors", "Los Angeles Lakers", "GSW", "LAL", "Warriors", "Lakers"]
    end

    def games_response
      {resultSets: [{name: "NextNGames", headers: games_headers, rowSet: [games_row]}]}
    end
  end
end
