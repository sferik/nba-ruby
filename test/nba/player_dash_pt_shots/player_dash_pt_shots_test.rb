require_relative "../../test_helper"

module NBA
  class PlayerDashPtShotsTest < Minitest::Test
    cover PlayerDashPtShots

    def test_overall_returns_collection
      stub_request(:get, /playerdashptshots/).to_return(body: overall_response.to_json)

      assert_instance_of Collection, PlayerDashPtShots.overall(player: 201_939)
    end

    def test_overall_uses_correct_result_set
      stub_request(:get, /playerdashptshots/).to_return(body: response_with_all_result_sets.to_json)

      assert_equal "Overall", PlayerDashPtShots.overall(player: 201_939).first.shot_type
    end

    def test_general_uses_correct_result_set
      stub_request(:get, /playerdashptshots/).to_return(body: response_with_all_result_sets.to_json)

      assert_equal "General", PlayerDashPtShots.general(player: 201_939).first.shot_type
    end

    def test_dribble_uses_correct_result_set
      stub_request(:get, /playerdashptshots/).to_return(body: response_with_all_result_sets.to_json)

      assert_equal "Dribble", PlayerDashPtShots.dribble(player: 201_939).first.shot_type
    end

    def test_touch_time_uses_correct_result_set
      stub_request(:get, /playerdashptshots/).to_return(body: response_with_all_result_sets.to_json)

      assert_equal "TouchTime", PlayerDashPtShots.touch_time(player: 201_939).first.shot_type
    end

    def test_shot_clock_uses_correct_result_set
      stub_request(:get, /playerdashptshots/).to_return(body: response_with_all_result_sets.to_json)

      assert_equal "ShotClock", PlayerDashPtShots.shot_clock(player: 201_939).first.shot_type
    end

    def test_closest_defender_uses_correct_result_set
      stub_request(:get, /playerdashptshots/).to_return(body: response_with_all_result_sets.to_json)

      assert_equal "Defender", PlayerDashPtShots.closest_defender(player: 201_939).first.shot_type
    end

    def test_closest_defender_10ft_uses_correct_result_set
      stub_request(:get, /playerdashptshots/).to_return(body: response_with_all_result_sets.to_json)

      assert_equal "Defender10ft", PlayerDashPtShots.closest_defender_10ft(player: 201_939).first.shot_type
    end

    def test_returns_empty_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_empty PlayerDashPtShots.overall(player: 201_939, client: mock_client)
      mock_client.verify
    end

    def test_returns_empty_for_empty_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, "", [String]

      assert_empty PlayerDashPtShots.overall(player: 201_939, client: mock_client)
      mock_client.verify
    end

    private

    def overall_response
      {resultSets: [{name: "Overall", headers: headers, rowSet: [row_data("Overall")]}]}
    end

    def response_with_all_result_sets
      {resultSets: all_result_sets}
    end

    def all_result_sets
      [result_set("Overall"), result_set("GeneralShooting", "General"),
        result_set("DribbleShooting", "Dribble"), result_set("TouchTimeShooting", "TouchTime"),
        result_set("ShotClockShooting", "ShotClock"), result_set("ClosestDefenderShooting", "Defender"),
        result_set("ClosestDefender10ftPlusShooting", "Defender10ft")]
    end

    def result_set(name, shot_type = nil)
      {name: name, headers: headers, rowSet: [row_data(shot_type || name)]}
    end

    def row_data(shot_type)
      [201_939, "Curry", 1, 74, 74, shot_type, 1.0, 8.5, 18.2, 0.467, 0.563, 0.45, 4.2, 8.1, 0.519,
        0.55, 4.3, 10.1, 0.426]
    end

    def headers
      %w[PLAYER_ID PLAYER_NAME_LAST_FIRST SORT_ORDER GP G SHOT_TYPE FGA_FREQUENCY FGM FGA FG_PCT
        EFG_PCT FG2A_FREQUENCY FG2M FG2A FG2_PCT FG3A_FREQUENCY FG3M FG3A FG3_PCT]
    end
  end
end
