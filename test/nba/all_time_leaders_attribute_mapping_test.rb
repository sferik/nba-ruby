require_relative "../test_helper"

module NBA
  class AllTimeLeadersAttributeMappingTest < Minitest::Test
    cover AllTimeLeaders

    def test_maps_player_id
      stub_leaders_request

      leader = AllTimeLeaders.find(category: AllTimeLeaders::PTS).first

      assert_equal 2544, leader.player_id
    end

    def test_maps_player_name
      stub_leaders_request

      leader = AllTimeLeaders.find(category: AllTimeLeaders::PTS).first

      assert_equal "LeBron James", leader.player_name
    end

    def test_maps_category
      stub_leaders_request

      leader = AllTimeLeaders.find(category: AllTimeLeaders::PTS).first

      assert_equal "PTS", leader.category
    end

    def test_maps_value
      stub_leaders_request

      leader = AllTimeLeaders.find(category: AllTimeLeaders::PTS).first

      assert_equal 40_474, leader.value
    end

    def test_maps_rank
      stub_leaders_request

      leader = AllTimeLeaders.find(category: AllTimeLeaders::PTS).first

      assert_equal 1, leader.rank
    end

    def test_maps_is_active_when_y
      stub_leaders_request

      leader = AllTimeLeaders.find(category: AllTimeLeaders::PTS).first

      assert leader.is_active
    end

    def test_maps_is_active_when_n
      headers = %w[PLAYER_ID PLAYER_NAME IS_ACTIVE_FLAG PTS]
      row = [77, "Kareem Abdul-Jabbar", "N", 38_387]
      response = {resultSets: [{name: "PTSLeaders", headers: headers, rowSet: [row]}]}
      stub_request(:get, /alltimeleadersgrids/).to_return(body: response.to_json)

      leader = AllTimeLeaders.find(category: AllTimeLeaders::PTS).first

      refute leader.is_active
    end

    def test_active_predicate_returns_true_when_active
      stub_leaders_request

      leader = AllTimeLeaders.find(category: AllTimeLeaders::PTS).first

      assert_predicate leader, :active?
    end

    def test_active_predicate_returns_false_when_inactive
      headers = %w[PLAYER_ID PLAYER_NAME IS_ACTIVE_FLAG PTS]
      row = [77, "Kareem Abdul-Jabbar", "N", 38_387]
      response = {resultSets: [{name: "PTSLeaders", headers: headers, rowSet: [row]}]}
      stub_request(:get, /alltimeleadersgrids/).to_return(body: response.to_json)

      leader = AllTimeLeaders.find(category: AllTimeLeaders::PTS).first

      refute_predicate leader, :active?
    end

    private

    def stub_leaders_request
      stub_request(:get, /alltimeleadersgrids/).to_return(body: leaders_response.to_json)
    end

    def leaders_response
      {resultSets: [{name: "PTSLeaders", headers: leader_headers, rowSet: [leader_row]}]}
    end

    def leader_headers
      %w[PLAYER_ID PLAYER_NAME IS_ACTIVE_FLAG PTS]
    end

    def leader_row
      [2544, "LeBron James", "Y", 40_474]
    end
  end
end
