require_relative "../../test_helper"

module NBA
  class PlayerDashPtShotDefendDefaultsTest < Minitest::Test
    cover PlayerDashPtShotDefend

    def test_default_team_is_zero
      request = stub_request(:get, /playerdashptshotdefend.*TeamID=0/).to_return(body: empty_response.to_json)
      PlayerDashPtShotDefend.find(player: 201_939)

      assert_requested request
    end

    def test_default_per_mode_is_per_game
      request = stub_request(:get, /playerdashptshotdefend.*PerMode=PerGame/).to_return(body: empty_response.to_json)
      PlayerDashPtShotDefend.find(player: 201_939)

      assert_requested request
    end

    def test_default_season_type_is_regular_season
      request = stub_request(:get, /playerdashptshotdefend.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      PlayerDashPtShotDefend.find(player: 201_939)

      assert_requested request
    end

    private

    def empty_response
      {resultSets: [{name: "DefendingShots", headers: [], rowSet: []}]}
    end
  end
end
