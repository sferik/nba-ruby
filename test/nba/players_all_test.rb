require_relative "../test_helper"

module NBA
  class PlayersAllTest < Minitest::Test
    cover Players

    def test_all_returns_collection_of_players
      stub_players_request

      players = Players.all

      assert_instance_of Collection, players
    end

    def test_all_parses_player_id_and_name
      stub_players_request

      curry = Players.all.first

      assert_equal 201_939, curry.id
      assert_equal "Stephen Curry", curry.full_name
      assert_equal "Stephen", curry.first_name
      assert_equal "Curry", curry.last_name
    end

    def test_all_parses_active_status
      stub_players_request

      curry = Players.all.first

      assert curry.is_active
    end

    def test_all_with_custom_season
      stub_request(:get, /commonallplayers.*Season=2023-24/).to_return(body: players_response.to_json)

      Players.all(season: 2023)

      assert_requested :get, /commonallplayers.*Season=2023-24/
    end

    def test_all_with_only_current_false
      stub_request(:get, /commonallplayers.*IsOnlyCurrentSeason=0/).to_return(body: players_response.to_json)

      Players.all(only_current: false)

      assert_requested :get, /commonallplayers.*IsOnlyCurrentSeason=0/
    end

    def test_all_default_only_current_is_true
      stub_request(:get, /commonallplayers.*IsOnlyCurrentSeason=1/).to_return(body: players_response.to_json)

      Players.all

      assert_requested :get, /commonallplayers.*IsOnlyCurrentSeason=1/
    end

    def test_all_only_current_true_sets_flag
      stub_request(:get, /commonallplayers.*IsOnlyCurrentSeason=1/).to_return(body: players_response.to_json)

      Players.all(only_current: true)

      assert_requested :get, /commonallplayers.*IsOnlyCurrentSeason=1/
    end

    private

    def stub_players_request
      stub_request(:get, /commonallplayers/).to_return(body: players_response.to_json)
    end

    def player_headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS]

    def players_response
      {resultSets: [{headers: player_headers, rowSet: [[201_939, "Stephen Curry", "Stephen", "Curry", "Active"]]}]}
    end
  end
end
