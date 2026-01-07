require_relative "../test_helper"

module NBA
  class PlayerDashPtShotsDefaultsTest < Minitest::Test
    cover PlayerDashPtShots

    def test_overall_default_team_is_zero
      request = stub_request(:get, /playerdashptshots.*TeamID=0/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.overall(player: 201_939)

      assert_requested request
    end

    def test_overall_default_per_mode_is_per_game
      request = stub_request(:get, /playerdashptshots.*PerMode=PerGame/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.overall(player: 201_939)

      assert_requested request
    end

    def test_overall_default_season_type_is_regular_season
      request = stub_request(:get, /playerdashptshots.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      PlayerDashPtShots.overall(player: 201_939)

      assert_requested request
    end

    def test_general_default_team_is_zero
      request = stub_request(:get, /playerdashptshots.*TeamID=0/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.general(player: 201_939)

      assert_requested request
    end

    def test_general_default_per_mode_is_per_game
      request = stub_request(:get, /playerdashptshots.*PerMode=PerGame/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.general(player: 201_939)

      assert_requested request
    end

    def test_general_default_season_type_is_regular_season
      request = stub_request(:get, /playerdashptshots.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      PlayerDashPtShots.general(player: 201_939)

      assert_requested request
    end

    def test_dribble_default_team_is_zero
      request = stub_request(:get, /playerdashptshots.*TeamID=0/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.dribble(player: 201_939)

      assert_requested request
    end

    def test_dribble_default_per_mode_is_per_game
      request = stub_request(:get, /playerdashptshots.*PerMode=PerGame/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.dribble(player: 201_939)

      assert_requested request
    end

    def test_dribble_default_season_type_is_regular_season
      request = stub_request(:get, /playerdashptshots.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      PlayerDashPtShots.dribble(player: 201_939)

      assert_requested request
    end

    def test_touch_time_default_team_is_zero
      request = stub_request(:get, /playerdashptshots.*TeamID=0/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.touch_time(player: 201_939)

      assert_requested request
    end

    def test_touch_time_default_per_mode_is_per_game
      request = stub_request(:get, /playerdashptshots.*PerMode=PerGame/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.touch_time(player: 201_939)

      assert_requested request
    end

    def test_touch_time_default_season_type_is_regular_season
      request = stub_request(:get, /playerdashptshots.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      PlayerDashPtShots.touch_time(player: 201_939)

      assert_requested request
    end

    private

    def empty_response
      {resultSets: [{name: "Overall", headers: [], rowSet: []}]}
    end
  end
end
