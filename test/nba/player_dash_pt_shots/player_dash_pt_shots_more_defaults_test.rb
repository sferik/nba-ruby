require_relative "../../test_helper"

module NBA
  class PlayerDashPtShotsMoreDefaultsTest < Minitest::Test
    cover PlayerDashPtShots

    def test_shot_clock_default_team_is_zero
      request = stub_request(:get, /playerdashptshots.*TeamID=0/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.shot_clock(player: 201_939)

      assert_requested request
    end

    def test_shot_clock_default_per_mode_is_per_game
      request = stub_request(:get, /playerdashptshots.*PerMode=PerGame/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.shot_clock(player: 201_939)

      assert_requested request
    end

    def test_shot_clock_default_season_type_is_regular_season
      request = stub_request(:get, /playerdashptshots.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      PlayerDashPtShots.shot_clock(player: 201_939)

      assert_requested request
    end

    def test_closest_defender_default_team_is_zero
      request = stub_request(:get, /playerdashptshots.*TeamID=0/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.closest_defender(player: 201_939)

      assert_requested request
    end

    def test_closest_defender_default_per_mode_is_per_game
      request = stub_request(:get, /playerdashptshots.*PerMode=PerGame/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.closest_defender(player: 201_939)

      assert_requested request
    end

    def test_closest_defender_default_season_type_is_regular_season
      request = stub_request(:get, /playerdashptshots.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      PlayerDashPtShots.closest_defender(player: 201_939)

      assert_requested request
    end

    def test_closest_defender_10ft_default_team_is_zero
      request = stub_request(:get, /playerdashptshots.*TeamID=0/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.closest_defender_10ft(player: 201_939)

      assert_requested request
    end

    def test_closest_defender_10ft_default_per_mode_is_per_game
      request = stub_request(:get, /playerdashptshots.*PerMode=PerGame/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.closest_defender_10ft(player: 201_939)

      assert_requested request
    end

    def test_closest_defender_10ft_default_season_type_is_regular_season
      request = stub_request(:get, /playerdashptshots.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      PlayerDashPtShots.closest_defender_10ft(player: 201_939)

      assert_requested request
    end

    private

    def empty_response
      {resultSets: [{name: "Overall", headers: [], rowSet: []}]}
    end
  end
end
