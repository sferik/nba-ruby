require_relative "../../test_helper"

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
end
