require_relative "../../test_helper"

module NBA
  class PlayerNextNGamesMissingKeysTest < Minitest::Test
    cover PlayerNextNGames

    def test_handles_missing_game_id
      stub_request(:get, /playernextngames/).to_return(body: response_without("GAME_ID").to_json)

      game = PlayerNextNGames.find(player: 201_939).first

      assert_nil game.game_id
    end

    def test_handles_missing_game_date
      stub_request(:get, /playernextngames/).to_return(body: response_without("GAME_DATE").to_json)

      game = PlayerNextNGames.find(player: 201_939).first

      assert_nil game.game_date
    end

    def test_handles_missing_game_time
      stub_request(:get, /playernextngames/).to_return(body: response_without("GAME_TIME").to_json)

      game = PlayerNextNGames.find(player: 201_939).first

      assert_nil game.game_time
    end

    def test_handles_missing_home_team_id
      stub_request(:get, /playernextngames/).to_return(body: response_without("HOME_TEAM_ID").to_json)

      game = PlayerNextNGames.find(player: 201_939).first

      assert_nil game.home_team_id
    end

    def test_handles_missing_visitor_team_id
      stub_request(:get, /playernextngames/).to_return(body: response_without("VISITOR_TEAM_ID").to_json)

      game = PlayerNextNGames.find(player: 201_939).first

      assert_nil game.visitor_team_id
    end

    def test_handles_missing_home_team_name
      stub_request(:get, /playernextngames/).to_return(body: response_without("HOME_TEAM_NAME").to_json)

      game = PlayerNextNGames.find(player: 201_939).first

      assert_nil game.home_team_name
    end

    def test_handles_missing_visitor_team_name
      stub_request(:get, /playernextngames/).to_return(body: response_without("VISITOR_TEAM_NAME").to_json)

      game = PlayerNextNGames.find(player: 201_939).first

      assert_nil game.visitor_team_name
    end

    def test_handles_missing_home_team_abbreviation
      stub_request(:get, /playernextngames/).to_return(body: response_without("HOME_TEAM_ABBREVIATION").to_json)

      game = PlayerNextNGames.find(player: 201_939).first

      assert_nil game.home_team_abbreviation
    end

    def test_handles_missing_visitor_team_abbreviation
      stub_request(:get, /playernextngames/).to_return(body: response_without("VISITOR_TEAM_ABBREVIATION").to_json)

      game = PlayerNextNGames.find(player: 201_939).first

      assert_nil game.visitor_team_abbreviation
    end

    def test_handles_missing_home_team_nickname
      stub_request(:get, /playernextngames/).to_return(body: response_without("HOME_TEAM_NICKNAME").to_json)

      game = PlayerNextNGames.find(player: 201_939).first

      assert_nil game.home_team_nickname
    end

    def test_handles_missing_visitor_team_nickname
      stub_request(:get, /playernextngames/).to_return(body: response_without("VISITOR_TEAM_NICKNAME").to_json)

      game = PlayerNextNGames.find(player: 201_939).first

      assert_nil game.visitor_team_nickname
    end

    private

    def all_headers
      %w[GAME_ID GAME_DATE GAME_TIME HOME_TEAM_ID VISITOR_TEAM_ID HOME_TEAM_NAME VISITOR_TEAM_NAME
        HOME_TEAM_ABBREVIATION VISITOR_TEAM_ABBREVIATION HOME_TEAM_NICKNAME VISITOR_TEAM_NICKNAME]
    end

    def all_values
      ["0022400100", "JAN 15, 2025", "7:30 PM ET", 1_610_612_744, 1_610_612_747,
        "Golden State Warriors", "Los Angeles Lakers", "GSW", "LAL", "Warriors", "Lakers"]
    end

    def response_without(key)
      index = all_headers.index(key)
      headers = all_headers.reject { |h| h.eql?(key) }
      values = all_values.reject.with_index { |_, i| i.eql?(index) }
      {resultSets: [{name: "NextNGames", headers: headers, rowSet: [values]}]}
    end
  end
end
