require_relative "../test_helper"

module NBA
  class PlayerAwardsFindTest < Minitest::Test
    cover PlayerAwards

    def test_find_returns_collection
      stub_awards_request

      assert_instance_of Collection, PlayerAwards.find(player: 201_939)
    end

    def test_find_uses_correct_player_id_in_path
      stub_awards_request

      PlayerAwards.find(player: 201_939)

      assert_requested :get, /playerawards.*PlayerID=201939/
    end

    def test_find_accepts_player_object
      stub_awards_request
      player = Player.new(id: 201_939)

      PlayerAwards.find(player: player)

      assert_requested :get, /playerawards.*PlayerID=201939/
    end

    def test_find_parses_awards_successfully
      stub_awards_request

      awards = PlayerAwards.find(player: 201_939)

      assert_equal 1, awards.size
      assert_equal "NBA Champion", awards.first.description
    end

    private

    def stub_awards_request
      stub_request(:get, /playerawards/).to_return(body: awards_response.to_json)
    end

    def awards_response
      {resultSets: [{
        name: "PlayerAwards",
        headers: %w[FIRST_NAME LAST_NAME TEAM DESCRIPTION ALL_NBA_TEAM_NUMBER SEASON MONTH WEEK CONFERENCE TYPE SUBTYPE1 SUBTYPE2 SUBTYPE3],
        rowSet: [["Stephen", "Curry", "Warriors", "NBA Champion", nil, "2021-22", nil, nil, nil, "Playoff", nil, nil, nil]]
      }]}
    end
  end
end
