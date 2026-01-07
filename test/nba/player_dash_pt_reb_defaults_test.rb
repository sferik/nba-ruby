require_relative "../test_helper"

module NBA
  class PlayerDashPtRebDefaultsTest < Minitest::Test
    cover PlayerDashPtReb

    def test_overall_default_team
      request = stub_request(:get, /playerdashptreb.*TeamID=0/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.overall(player: 201_939)

      assert_requested request
    end

    def test_overall_default_per_mode
      request = stub_request(:get, /playerdashptreb.*PerMode=PerGame/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.overall(player: 201_939)

      assert_requested request
    end

    def test_overall_default_season_type
      request = stub_request(:get, /playerdashptreb.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)

      PlayerDashPtReb.overall(player: 201_939)

      assert_requested request
    end

    def test_num_contested_default_team
      request = stub_request(:get, /playerdashptreb.*TeamID=0/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.num_contested(player: 201_939)

      assert_requested request
    end

    def test_num_contested_default_per_mode
      request = stub_request(:get, /playerdashptreb.*PerMode=PerGame/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.num_contested(player: 201_939)

      assert_requested request
    end

    def test_num_contested_default_season_type
      request = stub_request(:get, /playerdashptreb.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)

      PlayerDashPtReb.num_contested(player: 201_939)

      assert_requested request
    end

    def test_reb_distance_default_team
      request = stub_request(:get, /playerdashptreb.*TeamID=0/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.reb_distance(player: 201_939)

      assert_requested request
    end

    def test_reb_distance_default_per_mode
      request = stub_request(:get, /playerdashptreb.*PerMode=PerGame/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.reb_distance(player: 201_939)

      assert_requested request
    end

    def test_reb_distance_default_season_type
      request = stub_request(:get, /playerdashptreb.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)

      PlayerDashPtReb.reb_distance(player: 201_939)

      assert_requested request
    end

    def test_shot_distance_default_team
      request = stub_request(:get, /playerdashptreb.*TeamID=0/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.shot_distance(player: 201_939)

      assert_requested request
    end

    def test_shot_distance_default_per_mode
      request = stub_request(:get, /playerdashptreb.*PerMode=PerGame/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.shot_distance(player: 201_939)

      assert_requested request
    end

    def test_shot_distance_default_season_type
      request = stub_request(:get, /playerdashptreb.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)

      PlayerDashPtReb.shot_distance(player: 201_939)

      assert_requested request
    end

    def test_shot_type_default_team
      request = stub_request(:get, /playerdashptreb.*TeamID=0/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.shot_type(player: 201_939)

      assert_requested request
    end

    def test_shot_type_default_per_mode
      request = stub_request(:get, /playerdashptreb.*PerMode=PerGame/).to_return(body: empty_response.to_json)

      PlayerDashPtReb.shot_type(player: 201_939)

      assert_requested request
    end

    def test_shot_type_default_season_type
      request = stub_request(:get, /playerdashptreb.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)

      PlayerDashPtReb.shot_type(player: 201_939)

      assert_requested request
    end

    private

    def empty_response
      {resultSets: [{name: "OverallRebounding", headers: [], rowSet: []}]}
    end
  end
end
