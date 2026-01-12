require_relative "../../test_helper"

module NBA
  class PlayerDashPtPassDefaultsTest < Minitest::Test
    cover PlayerDashPtPass

    def test_passes_made_default_team_is_zero
      request = stub_request(:get, /playerdashptpass.*TeamID=0/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_made(player: 201_939)

      assert_requested request
    end

    def test_passes_made_default_per_mode_is_per_game
      request = stub_request(:get, /playerdashptpass.*PerMode=PerGame/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_made(player: 201_939)

      assert_requested request
    end

    def test_passes_made_default_season_type_is_regular_season
      request = stub_request(:get, /playerdashptpass.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_made(player: 201_939)

      assert_requested request
    end

    def test_passes_received_default_team_is_zero
      request = stub_request(:get, /playerdashptpass.*TeamID=0/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_received(player: 201_939)

      assert_requested request
    end

    def test_passes_received_default_per_mode_is_per_game
      request = stub_request(:get, /playerdashptpass.*PerMode=PerGame/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_received(player: 201_939)

      assert_requested request
    end

    def test_passes_received_default_season_type_is_regular_season
      request = stub_request(:get, /playerdashptpass.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_received(player: 201_939)

      assert_requested request
    end

    private

    def empty_response
      {resultSets: [{name: "PassesMade", headers: [], rowSet: []}]}
    end
  end
end
