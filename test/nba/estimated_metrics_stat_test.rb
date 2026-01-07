require_relative "../test_helper"

module NBA
  class EstimatedMetricsStatTest < Minitest::Test
    cover EstimatedMetricsStat

    def test_equality_based_on_player_id
      stat1 = EstimatedMetricsStat.new(player_id: 201_939, player_name: "Stephen Curry")
      stat2 = EstimatedMetricsStat.new(player_id: 201_939, player_name: "Steph")

      assert_equal stat1, stat2
    end

    def test_inequality_when_player_ids_differ
      stat1 = EstimatedMetricsStat.new(player_id: 201_939)
      stat2 = EstimatedMetricsStat.new(player_id: 2544)

      refute_equal stat1, stat2
    end

    def test_player_fetches_player_by_id
      stub_request(:get, /commonplayerinfo\?PlayerID=201939/).to_return(body: player_response.to_json)

      stat = EstimatedMetricsStat.new(player_id: 201_939)
      player = stat.player

      assert_equal 201_939, player.id
    end

    private

    def player_response
      {
        resultSets: [{
          name: "CommonPlayerInfo",
          headers: %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS],
          rowSet: [[201_939, "Stephen Curry", "Stephen", "Curry", "Active"]]
        }]
      }
    end
  end
end
