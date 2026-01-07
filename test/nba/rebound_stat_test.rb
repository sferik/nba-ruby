require_relative "../test_helper"

module NBA
  class ReboundStatTest < Minitest::Test
    cover ReboundStat

    def test_player_returns_player_object
      stub_request(:get, /commonplayerinfo.*PlayerID=201939/)
        .to_return(body: player_response.to_json)
      stat = ReboundStat.new(player_id: 201_939)

      result = stat.player

      assert_instance_of Player, result
    end

    private

    def player_response
      {resultSets: [{
        name: "CommonPlayerInfo",
        headers: %w[PERSON_ID DISPLAY_FIRST_LAST],
        rowSet: [[201_939, "Stephen Curry"]]
      }]}
    end
  end
end
