require_relative "../test_helper"

module NBA
  class LeadersConstantsTest < Minitest::Test
    cover Leaders

    def test_scoring_constants
      assert_equal "PTS", Leaders::PTS
      assert_equal "FG_PCT", Leaders::FG_PCT
      assert_equal "FG3_PCT", Leaders::FG3_PCT
      assert_equal "FT_PCT", Leaders::FT_PCT
    end

    def test_other_category_constants
      assert_equal "REB", Leaders::REB
      assert_equal "AST", Leaders::AST
      assert_equal "STL", Leaders::STL
      assert_equal "BLK", Leaders::BLK
      assert_equal "EFF", Leaders::EFF
    end
  end

  class LeadersFindTest < Minitest::Test
    cover Leaders

    def test_find_returns_collection
      stub_leaders_request

      assert_instance_of Collection, Leaders.find(category: Leaders::PTS)
    end

    def test_find_parses_player_info
      stub_leaders_request

      leader = Leaders.find(category: Leaders::PTS).first

      assert_equal 201_939, leader.player_id
      assert_equal "Stephen Curry", leader.player_name
      assert_equal Team::GSW, leader.team_id
      assert_equal "GSW", leader.team_abbreviation
    end

    def test_find_parses_rank_and_value
      stub_leaders_request

      leader = Leaders.find(category: Leaders::PTS).first

      assert_equal "PTS", leader.category
      assert_equal 1, leader.rank
      assert_in_delta 32.4, leader.value
    end

    def test_find_with_custom_season
      stub_request(:get, /leagueleaders.*Season=2023-24/)
        .to_return(body: leaders_response.to_json)

      Leaders.find(category: Leaders::PTS, season: 2023)

      assert_requested :get, /leagueleaders.*Season=2023-24/
    end

    def test_find_with_playoffs_season_type
      stub_request(:get, /leagueleaders.*SeasonType=Playoffs/)
        .to_return(body: leaders_response.to_json)

      Leaders.find(category: Leaders::PTS, season_type: "Playoffs")

      assert_requested :get, /leagueleaders.*SeasonType=Playoffs/
    end

    def test_find_respects_limit
      stub_leaders_with_rows(20)

      leaders = Leaders.find(category: Leaders::PTS, limit: 5)

      assert_equal 5, leaders.size
    end

    def test_find_default_limit_is_ten
      stub_leaders_with_rows(15)

      leaders = Leaders.find(category: Leaders::PTS)

      assert_equal 10, leaders.size
    end

    def test_find_default_season_type_is_regular_season
      stub_request(:get, /leagueleaders.*SeasonType=Regular%20Season/)
        .to_return(body: leaders_response.to_json)

      Leaders.find(category: Leaders::PTS)

      assert_requested :get, /leagueleaders.*SeasonType=Regular%20Season/
    end

    def test_find_uses_category_in_path
      stub_request(:get, /leagueleaders.*StatCategory=PTS/)
        .to_return(body: leaders_response.to_json)

      Leaders.find(category: Leaders::PTS)

      assert_requested :get, /leagueleaders.*StatCategory=PTS/
    end

    def test_find_uses_per_game_for_counting_stats
      stub_request(:get, /leagueleaders.*PerMode=PerGame/)
        .to_return(body: leaders_response.to_json)

      Leaders.find(category: Leaders::PTS)

      assert_requested :get, /leagueleaders.*PerMode=PerGame/
    end

    def test_find_uses_totals_for_percentage_stats
      stub_request(:get, /leagueleaders.*PerMode=Totals/)
        .to_return(body: fg_pct_response.to_json)

      Leaders.find(category: Leaders::FG_PCT)

      assert_requested :get, /leagueleaders.*PerMode=Totals/
    end

    private

    def fg_pct_response
      {resultSet: {headers: %w[PLAYER_ID PLAYER TEAM_ID TEAM RANK FG_PCT], rowSet: [[201_939, "Stephen Curry", Team::GSW, "GSW", 1, 0.52]]}}
    end

    def stub_leaders_request
      stub_request(:get, /leagueleaders/).to_return(body: leaders_response.to_json)
    end

    def stub_leaders_with_rows(count)
      response = leaders_response
      response[:resultSet][:rowSet] = Array.new(count) { |i| [201_939 + i, "Player #{i}", Team::GSW, "GSW", i + 1, 32.4 - i] }
      stub_request(:get, /leagueleaders/).to_return(body: response.to_json)
    end

    def leaders_response
      {resultSet: {headers: %w[PLAYER_ID PLAYER TEAM_ID TEAM RANK PTS], rowSet: [[201_939, "Stephen Curry", Team::GSW, "GSW", 1, 32.4]]}}
    end
  end

  class LeadersFindEdgeCasesTest < Minitest::Test
    cover Leaders

    def test_find_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, Leaders.find(category: Leaders::PTS, client: mock_client).size
      mock_client.verify
    end

    def test_find_returns_empty_collection_when_no_result_set
      stub_request(:get, /leagueleaders/).to_return(body: {resultSet: nil}.to_json)

      assert_equal 0, Leaders.find(category: Leaders::PTS).size
    end

    def test_find_returns_empty_collection_when_result_set_key_missing
      stub_request(:get, /leagueleaders/).to_return(body: {}.to_json)

      assert_equal 0, Leaders.find(category: Leaders::PTS).size
    end

    def test_find_returns_empty_collection_when_no_headers
      stub_request(:get, /leagueleaders/).to_return(body: {resultSet: {headers: nil, rowSet: [[1, "Curry"]]}}.to_json)

      assert_equal 0, Leaders.find(category: Leaders::PTS).size
    end

    def test_find_returns_empty_collection_when_no_rows
      stub_request(:get, /leagueleaders/).to_return(body: {resultSet: {headers: %w[PLAYER_ID PLAYER], rowSet: nil}}.to_json)

      assert_equal 0, Leaders.find(category: Leaders::PTS).size
    end

    def test_find_handles_nil_category_value
      stub_leaders_with(pts_value: nil)

      assert_nil Leaders.find(category: Leaders::PTS).first.value
    end

    def test_find_encodes_season_type_with_spaces
      stub_request(:get, /leagueleaders.*SeasonType=Regular%20Season/).to_return(body: leaders_response.to_json)

      Leaders.find(category: Leaders::PTS, season_type: "Regular Season")

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_find_encodes_special_characters_in_season_type
      stub_request(:get, /leagueleaders.*SeasonType=Test%26Type/).to_return(body: leaders_response.to_json)

      Leaders.find(category: Leaders::PTS, season_type: "Test&Type")

      assert_requested :get, /SeasonType=Test%26Type/
    end

    def test_find_converts_value_to_float
      stub_leaders_with(pts_value: 32)

      leader = Leaders.find(category: Leaders::PTS).first

      assert_instance_of Float, leader.value
      assert_in_delta 32.0, leader.value
    end

    private

    def stub_leaders_with(pts_value:)
      response = leaders_response
      pts_index = response[:resultSet][:headers].index("PTS")
      response[:resultSet][:rowSet][0][pts_index] = pts_value
      stub_request(:get, /leagueleaders/).to_return(body: response.to_json)
    end

    def leaders_response
      {resultSet: {headers: %w[PLAYER_ID PLAYER TEAM_ID TEAM RANK PTS], rowSet: [[201_939, "Stephen Curry", Team::GSW, "GSW", 1, 32.4]]}}
    end
  end
end
