require_relative "../../test_helper"

module NBA
  class PlayerDashPtShotDefendTest < Minitest::Test
    cover PlayerDashPtShotDefend

    def test_find_returns_collection
      stub_request(:get, /playerdashptshotdefend.*PlayerID=201939/).to_return(body: defending_shots_response.to_json)

      result = PlayerDashPtShotDefend.find(player: 201_939)

      assert_instance_of Collection, result
    end

    def test_find_parses_close_def_person_id
      stub_request(:get, /playerdashptshotdefend/).to_return(body: defending_shots_response.to_json)

      assert_equal 201_939, PlayerDashPtShotDefend.find(player: 201_939).first.close_def_person_id
    end

    def test_find_parses_gp
      stub_request(:get, /playerdashptshotdefend/).to_return(body: defending_shots_response.to_json)

      assert_equal 74, PlayerDashPtShotDefend.find(player: 201_939).first.gp
    end

    def test_find_parses_g
      stub_request(:get, /playerdashptshotdefend/).to_return(body: defending_shots_response.to_json)

      assert_equal 74, PlayerDashPtShotDefend.find(player: 201_939).first.g
    end

    def test_find_parses_defense_category
      stub_request(:get, /playerdashptshotdefend/).to_return(body: defending_shots_response.to_json)

      assert_equal "Overall", PlayerDashPtShotDefend.find(player: 201_939).first.defense_category
    end

    def test_find_parses_freq
      stub_request(:get, /playerdashptshotdefend/).to_return(body: defending_shots_response.to_json)

      assert_in_delta 0.15, PlayerDashPtShotDefend.find(player: 201_939).first.freq
    end

    def test_find_returns_empty_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = PlayerDashPtShotDefend.find(player: 201_939, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_find_returns_empty_for_empty_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, "", [String]

      result = PlayerDashPtShotDefend.find(player: 201_939, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    private

    def defending_shots_response
      {resultSets: [{name: "DefendingShots", headers: headers,
                     rowSet: [[201_939, 74, 74, "Overall", 0.15, 3.5, 8.2, 0.427, 0.485, -5.8]]}]}
    end

    def headers
      %w[CLOSE_DEF_PERSON_ID GP G DEFENSE_CATEGORY FREQ D_FGM D_FGA D_FG_PCT NORMAL_FG_PCT PCT_PLUSMINUS]
    end
  end
end
