require_relative "../test_helper"

module NBA
  class AllTimeLeadersFindTest < Minitest::Test
    cover AllTimeLeaders

    def test_find_returns_collection
      stub_leaders_request

      result = AllTimeLeaders.find(category: AllTimeLeaders::PTS)

      assert_instance_of Collection, result
    end

    def test_find_uses_correct_category_in_result_set
      stub_leaders_request

      leaders = AllTimeLeaders.find(category: AllTimeLeaders::PTS)

      assert_equal 1, leaders.size
      assert_equal "PTS", leaders.first.category
    end

    def test_find_uses_correct_season_type_in_path
      stub_leaders_request

      AllTimeLeaders.find(category: AllTimeLeaders::PTS, season_type: AllTimeLeaders::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_find_uses_correct_per_mode_in_path
      stub_leaders_request

      AllTimeLeaders.find(category: AllTimeLeaders::PTS, per_mode: AllTimeLeaders::PER_GAME)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_find_uses_correct_limit_in_path
      stub_leaders_request

      AllTimeLeaders.find(category: AllTimeLeaders::PTS, limit: 25)

      assert_requested :get, /TopX=25/
    end

    def test_find_parses_leaders_successfully
      stub_leaders_request

      leaders = AllTimeLeaders.find(category: AllTimeLeaders::PTS)

      assert_equal 1, leaders.size
      assert_equal 2544, leaders.first.player_id
      assert_equal "LeBron James", leaders.first.player_name
    end

    def test_find_assigns_rank_based_on_position
      stub_request(:get, /alltimeleadersgrids/).to_return(body: multi_leader_response.to_json)

      leaders = AllTimeLeaders.find(category: AllTimeLeaders::PTS, limit: 3).to_a

      assert_equal 1, leaders[0].rank
      assert_equal 2, leaders[1].rank
      assert_equal 3, leaders[2].rank
    end

    def test_find_limits_results_to_limit_parameter
      stub_request(:get, /alltimeleadersgrids/).to_return(body: multi_leader_response.to_json)

      leaders = AllTimeLeaders.find(category: AllTimeLeaders::PTS, limit: 2)

      assert_equal 2, leaders.size
    end

    def test_find_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, leaders_response.to_json, [String]

      AllTimeLeaders.find(category: AllTimeLeaders::PTS, client: mock_client)

      mock_client.verify
    end

    def test_find_uses_default_parameters
      stub_leaders_request

      AllTimeLeaders.find(category: AllTimeLeaders::PTS)

      assert_requested :get, /SeasonType=Regular%20Season/
      assert_requested :get, /PerMode=Totals/
      assert_requested :get, /TopX=10/
    end

    private

    def stub_leaders_request
      stub_request(:get, /alltimeleadersgrids/).to_return(body: leaders_response.to_json)
    end

    def leaders_response
      {resultSets: [{name: "PTSLeaders", headers: leader_headers, rowSet: [leader_row]}]}
    end

    def multi_leader_response
      rows = [
        [2544, "LeBron James", "Y", 40_474],
        [201_939, "Stephen Curry", "Y", 35_000],
        [1_628_983, "Luka Doncic", "Y", 20_000]
      ]
      {resultSets: [{name: "PTSLeaders", headers: leader_headers, rowSet: rows}]}
    end

    def leader_headers
      %w[PLAYER_ID PLAYER_NAME IS_ACTIVE_FLAG PTS]
    end

    def leader_row
      [2544, "LeBron James", "Y", 40_474]
    end
  end
end
