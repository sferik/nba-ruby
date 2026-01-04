require_relative "../test_helper"

module NBA
  class PlayerDashboardStatTest < Minitest::Test
    cover PlayerDashboardStat

    def test_equality_based_on_player_id_and_group_value
      stat1 = PlayerDashboardStat.new(player_id: 201_939, group_value: "Overall")
      stat2 = PlayerDashboardStat.new(player_id: 201_939, group_value: "Overall")
      stat3 = PlayerDashboardStat.new(player_id: 201_939, group_value: "Home")
      stat4 = PlayerDashboardStat.new(player_id: 2544, group_value: "Overall")

      assert_equal stat1, stat2
      refute_equal stat1, stat3
      refute_equal stat1, stat4
    end

    def test_player_returns_player_object
      stub_request(:get, /commonplayerinfo.*PlayerID=201939/)
        .to_return(body: player_info_response.to_json)

      stat = PlayerDashboardStat.new(player_id: 201_939)

      assert_equal 201_939, stat.player.id
    end

    def test_identity_attributes_assignable
      stat = sample_stat

      assert_equal "OverallPlayerDashboard", stat.group_set
      assert_equal "Overall", stat.group_value
      assert_equal 201_939, stat.player_id
      assert_equal 82, stat.gp
      assert_in_delta 34.5, stat.min
    end

    def test_record_attributes_assignable
      stat = sample_stat

      assert_equal 50, stat.w
      assert_equal 32, stat.l
      assert_in_delta 0.610, stat.w_pct
    end

    private

    def sample_stat
      PlayerDashboardStat.new(
        group_set: "OverallPlayerDashboard", group_value: "Overall", player_id: 201_939,
        gp: 82, w: 50, l: 32, w_pct: 0.610, min: 34.5
      )
    end

    def player_info_response
      {
        resultSets: [{
          name: "CommonPlayerInfo",
          headers: %w[PERSON_ID DISPLAY_FIRST_LAST TEAM_ID],
          rowSet: [[201_939, "Stephen Curry", 1_610_612_744]]
        }]
      }
    end
  end
end
