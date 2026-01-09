require_relative "../test_helper"

module NBA
  class DraftCombineStatsAllTest < Minitest::Test
    cover DraftCombineStats

    def test_all_returns_collection
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      result = DraftCombineStats.all(season: 2019)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      DraftCombineStats.all(season: 2019)

      assert_requested :get, /SeasonYear=2019/
    end

    def test_all_uses_correct_league_in_path
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      DraftCombineStats.all(season: 2019, league: "10")

      assert_requested :get, /LeagueID=10/
    end

    def test_all_uses_default_league_when_not_specified
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      DraftCombineStats.all(season: 2019)

      assert_requested :get, /LeagueID=00/
    end

    def test_all_parses_results_successfully
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      results = DraftCombineStats.all(season: 2019)

      assert_equal 1, results.size
      assert_equal 1_630_162, results.first.player_id
      assert_equal "Victor Wembanyama", results.first.player_name
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, response.to_json, [String]

      DraftCombineStats.all(season: 2019, client: mock_client)

      mock_client.verify
    end

    def test_all_accepts_league_object
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)
      league = League.new(id: "10")

      DraftCombineStats.all(season: 2019, league: league)

      assert_requested :get, /LeagueID=10/
    end

    private

    def response
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[
        SEASON PLAYER_ID FIRST_NAME LAST_NAME PLAYER_NAME POSITION
        HEIGHT_WO_SHOES HEIGHT_WO_SHOES_FT_IN HEIGHT_W_SHOES HEIGHT_W_SHOES_FT_IN
        WEIGHT WINGSPAN WINGSPAN_FT_IN STANDING_REACH STANDING_REACH_FT_IN
        BODY_FAT_PCT HAND_LENGTH HAND_WIDTH
        STANDING_VERTICAL_LEAP MAX_VERTICAL_LEAP LANE_AGILITY_TIME
        MODIFIED_LANE_AGILITY_TIME THREE_QUARTER_SPRINT BENCH_PRESS
      ]
    end

    def row
      [
        "2023-24", 1_630_162, "Victor", "Wembanyama", "Victor Wembanyama", "C",
        83.5, "6-11.5", 84.5, "7-0.5",
        209.0, 94.0, "7-10", 112.0, "9-4",
        6.8, 9.75, 10.5,
        32.0, 40.5, 10.75,
        10.5, 3.25, 15
      ]
    end
  end

  class DraftCombineStatsPlayerAttrTest < Minitest::Test
    cover DraftCombineStats

    def test_parses_season
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "2023-24", DraftCombineStats.all(season: 2019).first.season
    end

    def test_parses_player_id
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal 1_630_162, DraftCombineStats.all(season: 2019).first.player_id
    end

    def test_parses_first_name
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "Victor", DraftCombineStats.all(season: 2019).first.first_name
    end

    def test_parses_last_name
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "Wembanyama", DraftCombineStats.all(season: 2019).first.last_name
    end

    def test_parses_player_name
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "Victor Wembanyama", DraftCombineStats.all(season: 2019).first.player_name
    end

    def test_parses_position
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "C", DraftCombineStats.all(season: 2019).first.position
    end

    private

    def response
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[SEASON PLAYER_ID FIRST_NAME LAST_NAME PLAYER_NAME POSITION]
    end

    def row
      ["2023-24", 1_630_162, "Victor", "Wembanyama", "Victor Wembanyama", "C"]
    end
  end

  class DraftCombineStatsPhysicalAttrTest < Minitest::Test
    cover DraftCombineStats

    def test_parses_height_wo_shoes
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 83.5, DraftCombineStats.all(season: 2019).first.height_wo_shoes
    end

    def test_parses_height_wo_shoes_ft_in
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "6-11.5", DraftCombineStats.all(season: 2019).first.height_wo_shoes_ft_in
    end

    def test_parses_height_w_shoes
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 84.5, DraftCombineStats.all(season: 2019).first.height_w_shoes
    end

    def test_parses_height_w_shoes_ft_in
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "7-0.5", DraftCombineStats.all(season: 2019).first.height_w_shoes_ft_in
    end

    def test_parses_weight
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 209.0, DraftCombineStats.all(season: 2019).first.weight
    end

    def test_parses_wingspan
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 94.0, DraftCombineStats.all(season: 2019).first.wingspan
    end

    def test_parses_wingspan_ft_in
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "7-10", DraftCombineStats.all(season: 2019).first.wingspan_ft_in
    end

    def test_parses_standing_reach
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 112.0, DraftCombineStats.all(season: 2019).first.standing_reach
    end

    def test_parses_standing_reach_ft_in
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "9-4", DraftCombineStats.all(season: 2019).first.standing_reach_ft_in
    end

    def test_parses_body_fat_pct
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 6.8, DraftCombineStats.all(season: 2019).first.body_fat_pct
    end

    def test_parses_hand_length
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 9.75, DraftCombineStats.all(season: 2019).first.hand_length
    end

    def test_parses_hand_width
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 10.5, DraftCombineStats.all(season: 2019).first.hand_width
    end

    private

    def response
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[
        HEIGHT_WO_SHOES HEIGHT_WO_SHOES_FT_IN HEIGHT_W_SHOES HEIGHT_W_SHOES_FT_IN
        WEIGHT WINGSPAN WINGSPAN_FT_IN STANDING_REACH STANDING_REACH_FT_IN
        BODY_FAT_PCT HAND_LENGTH HAND_WIDTH
      ]
    end

    def row
      [83.5, "6-11.5", 84.5, "7-0.5", 209.0, 94.0, "7-10", 112.0, "9-4", 6.8, 9.75, 10.5]
    end
  end

  class DraftCombineStatsAthleticAttrTest < Minitest::Test
    cover DraftCombineStats

    def test_parses_standing_vertical_leap
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 32.0, DraftCombineStats.all(season: 2019).first.standing_vertical_leap
    end

    def test_parses_max_vertical_leap
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 40.5, DraftCombineStats.all(season: 2019).first.max_vertical_leap
    end

    def test_parses_lane_agility_time
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 10.75, DraftCombineStats.all(season: 2019).first.lane_agility_time
    end

    def test_parses_modified_lane_agility_time
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 10.5, DraftCombineStats.all(season: 2019).first.modified_lane_agility_time
    end

    def test_parses_three_quarter_sprint
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 3.25, DraftCombineStats.all(season: 2019).first.three_quarter_sprint
    end

    def test_parses_bench_press
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal 15, DraftCombineStats.all(season: 2019).first.bench_press
    end

    private

    def response
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[
        STANDING_VERTICAL_LEAP MAX_VERTICAL_LEAP LANE_AGILITY_TIME
        MODIFIED_LANE_AGILITY_TIME THREE_QUARTER_SPRINT BENCH_PRESS
      ]
    end

    def row
      [32.0, 40.5, 10.75, 10.5, 3.25, 15]
    end
  end
end
