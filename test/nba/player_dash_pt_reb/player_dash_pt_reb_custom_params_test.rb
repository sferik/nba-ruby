require_relative "../../test_helper"

module NBA
  class PlayerDashPtRebCustomParamsTest < Minitest::Test
    cover PlayerDashPtReb

    def test_num_contested_custom_team
      request = stub_request(:get, /playerdashptreb.*TeamID=1610612744/)
        .to_return(body: empty_response.to_json)

      PlayerDashPtReb.num_contested(player: 201_939, team: 1_610_612_744)

      assert_requested request
    end

    def test_num_contested_custom_season
      request = stub_request(:get, /playerdashptreb.*Season=2022-23/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.num_contested(player: 201_939, season: 2022)

      assert_requested request
    end

    def test_num_contested_custom_season_type
      request = stub_request(:get, /playerdashptreb.*SeasonType=Playoffs/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.num_contested(player: 201_939, season_type: "Playoffs")

      assert_requested request
    end

    def test_num_contested_custom_per_mode
      request = stub_request(:get, /playerdashptreb.*PerMode=Totals/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.num_contested(player: 201_939, per_mode: "Totals")

      assert_requested request
    end

    def test_reb_distance_custom_team
      request = stub_request(:get, /playerdashptreb.*TeamID=1610612744/)
        .to_return(body: empty_response.to_json)

      PlayerDashPtReb.reb_distance(player: 201_939, team: 1_610_612_744)

      assert_requested request
    end

    def test_reb_distance_custom_season
      request = stub_request(:get, /playerdashptreb.*Season=2022-23/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.reb_distance(player: 201_939, season: 2022)

      assert_requested request
    end

    def test_reb_distance_custom_season_type
      request = stub_request(:get, /playerdashptreb.*SeasonType=Playoffs/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.reb_distance(player: 201_939, season_type: "Playoffs")

      assert_requested request
    end

    def test_reb_distance_custom_per_mode
      request = stub_request(:get, /playerdashptreb.*PerMode=Totals/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.reb_distance(player: 201_939, per_mode: "Totals")

      assert_requested request
    end

    def test_shot_distance_custom_team
      request = stub_request(:get, /playerdashptreb.*TeamID=1610612744/)
        .to_return(body: empty_response.to_json)

      PlayerDashPtReb.shot_distance(player: 201_939, team: 1_610_612_744)

      assert_requested request
    end

    def test_shot_distance_custom_season
      request = stub_request(:get, /playerdashptreb.*Season=2022-23/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.shot_distance(player: 201_939, season: 2022)

      assert_requested request
    end

    def test_shot_distance_custom_season_type
      request = stub_request(:get, /playerdashptreb.*SeasonType=Playoffs/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.shot_distance(player: 201_939, season_type: "Playoffs")

      assert_requested request
    end

    def test_shot_distance_custom_per_mode
      request = stub_request(:get, /playerdashptreb.*PerMode=Totals/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.shot_distance(player: 201_939, per_mode: "Totals")

      assert_requested request
    end

    def test_shot_type_custom_team
      request = stub_request(:get, /playerdashptreb.*TeamID=1610612744/)
        .to_return(body: empty_response.to_json)

      PlayerDashPtReb.shot_type(player: 201_939, team: 1_610_612_744)

      assert_requested request
    end

    def test_shot_type_custom_season
      request = stub_request(:get, /playerdashptreb.*Season=2022-23/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.shot_type(player: 201_939, season: 2022)

      assert_requested request
    end

    def test_shot_type_custom_season_type
      request = stub_request(:get, /playerdashptreb.*SeasonType=Playoffs/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.shot_type(player: 201_939, season_type: "Playoffs")

      assert_requested request
    end

    def test_shot_type_custom_per_mode
      request = stub_request(:get, /playerdashptreb.*PerMode=Totals/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.shot_type(player: 201_939, per_mode: "Totals")

      assert_requested request
    end

    private

    def empty_response
      {resultSets: [{name: "OverallRebounding", headers: [], rowSet: []}]}
    end
  end
end
