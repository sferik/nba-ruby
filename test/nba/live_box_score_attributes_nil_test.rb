require_relative "../test_helper"
require_relative "../support/live_box_score_test_helpers"

module NBA
  class LiveBoxScoreAttributesNilTest < Minitest::Test
    include LiveBoxScoreTestHelpers

    cover LiveBoxScore

    def test_handles_missing_starter
      player_data = base_player_data.except(:starter).merge(statistics: all_stats)
      response = build_response_with_player(player_data)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.starter
    end

    def test_parses_starter_value
      player_data = base_player_data.merge(starter: "1", statistics: all_stats)
      response = build_response_with_player(player_data)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_equal "1", stat.starter
    end

    def test_handles_missing_person_id
      player_data = base_player_data.except(:personId).merge(statistics: all_stats)
      response = build_response_with_player(player_data)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.player_id
    end

    def test_handles_missing_name
      player_data = base_player_data.except(:name).merge(statistics: all_stats)
      response = build_response_with_player(player_data)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.name
    end

    def test_handles_missing_first_name
      player_data = base_player_data.except(:firstName).merge(statistics: all_stats)
      response = build_response_with_player(player_data)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.first_name
    end

    def test_handles_missing_family_name
      player_data = base_player_data.except(:familyName).merge(statistics: all_stats)
      response = build_response_with_player(player_data)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.family_name
    end

    def test_handles_missing_jersey_num
      player_data = base_player_data.except(:jerseyNum).merge(statistics: all_stats)
      response = build_response_with_player(player_data)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.jersey_num
    end

    def test_handles_missing_position
      player_data = base_player_data.except(:position).merge(statistics: all_stats)
      response = build_response_with_player(player_data)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.position
    end
  end
end
