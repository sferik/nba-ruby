require_relative "../../test_helper"

module NBA
  class PlayerDashPtPassCustomParamsTest < Minitest::Test
    cover PlayerDashPtPass

    def test_passes_received_with_custom_team
      request = stub_request(:get, /playerdashptpass.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_received(player: 201_939, team: 1_610_612_744)

      assert_requested request
    end

    def test_passes_received_with_custom_season
      request = stub_request(:get, /playerdashptpass.*Season=2022-23/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_received(player: 201_939, season: 2022)

      assert_requested request
    end

    def test_passes_received_with_custom_season_type
      request = stub_request(:get, /playerdashptpass.*SeasonType=Playoffs/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_received(player: 201_939, season_type: "Playoffs")

      assert_requested request
    end

    def test_passes_received_with_custom_per_mode
      request = stub_request(:get, /playerdashptpass.*PerMode=Totals/).to_return(body: empty_response.to_json)
      PlayerDashPtPass.passes_received(player: 201_939, per_mode: "Totals")

      assert_requested request
    end

    private

    def empty_response
      {resultSets: [{name: "PassesMade", headers: [], rowSet: []}]}
    end
  end
end
