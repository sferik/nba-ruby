require_relative "../test_helper"

module NBA
  class LeadersFindEdgeCasesMissingTest < Minitest::Test
    cover Leaders

    def test_find_handles_minimal_headers
      response = {resultSet: {headers: %w[PLAYER_ID PLAYER RANK PTS], rowSet: [[201_939, "Stephen Curry", 1, 30.0]]}}
      stub_request(:get, /leagueleaders/).to_return(body: response.to_json)

      leader = Leaders.find(category: Leaders::PTS).first

      assert_equal 201_939, leader.player_id
      assert_equal "Stephen Curry", leader.player_name
      assert_nil leader.team_id
      assert_nil leader.team_abbreviation
    end

    def test_find_handles_missing_player_id
      response = {resultSet: {headers: %w[PLAYER RANK PTS], rowSet: [["Stephen Curry", 1, 30.0]]}}
      stub_request(:get, /leagueleaders/).to_return(body: response.to_json)

      leader = Leaders.find(category: Leaders::PTS).first

      assert_nil leader.player_id
      assert_equal "Stephen Curry", leader.player_name
    end

    def test_find_handles_missing_rank
      response = {resultSet: {headers: %w[PLAYER_ID PLAYER PTS], rowSet: [[201_939, "Stephen Curry", 30.0]]}}
      stub_request(:get, /leagueleaders/).to_return(body: response.to_json)

      leader = Leaders.find(category: Leaders::PTS).first

      assert_equal 201_939, leader.player_id
      assert_nil leader.rank
    end

    def test_find_handles_missing_player_name
      response = {resultSet: {headers: %w[PLAYER_ID RANK PTS], rowSet: [[201_939, 1, 30.0]]}}
      stub_request(:get, /leagueleaders/).to_return(body: response.to_json)

      leader = Leaders.find(category: Leaders::PTS).first

      assert_equal 201_939, leader.player_id
      assert_nil leader.player_name
    end

    def test_find_handles_missing_category_column
      response = {resultSet: {headers: %w[PLAYER_ID PLAYER RANK], rowSet: [[201_939, "Stephen Curry", 1]]}}
      stub_request(:get, /leagueleaders/).to_return(body: response.to_json)

      leader = Leaders.find(category: Leaders::PTS).first

      assert_equal 201_939, leader.player_id
      assert_nil leader.value
    end

    def test_find_handles_missing_team_abbreviation
      response = {resultSet: {headers: %w[PLAYER_ID PLAYER TEAM_ID RANK PTS], rowSet: [[201_939, "Stephen Curry", Team::GSW, 1, 30.0]]}}
      stub_request(:get, /leagueleaders/).to_return(body: response.to_json)

      leader = Leaders.find(category: Leaders::PTS).first

      assert_equal Team::GSW, leader.team_id
      assert_nil leader.team_abbreviation
    end
  end
end
