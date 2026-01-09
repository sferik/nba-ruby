require_relative "../test_helper"

module NBA
  class DraftCombinePlayerAnthroAllTest < Minitest::Test
    cover DraftCombinePlayerAnthro

    HEADERS = %w[
      TEMP_PLAYER_ID PLAYER_ID FIRST_NAME LAST_NAME PLAYER_NAME POSITION
      HEIGHT_WO_SHOES HEIGHT_WO_SHOES_FT_IN HEIGHT_W_SHOES HEIGHT_W_SHOES_FT_IN
      WEIGHT WINGSPAN WINGSPAN_FT_IN STANDING_REACH STANDING_REACH_FT_IN
      BODY_FAT_PCT HAND_LENGTH HAND_WIDTH
    ].freeze

    ROW = [
      123_456, 1_630_162, "Victor", "Wembanyama", "Victor Wembanyama", "C",
      85.5, "7' 1.5\"", 86.5, "7' 2.5\"",
      209.0, 96.0, "8' 0\"", 114.5, "9' 6.5\"",
      4.8, 10.25, 12.0
    ].freeze

    def test_all_returns_collection
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      result = DraftCombinePlayerAnthro.all(season: 2019)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      DraftCombinePlayerAnthro.all(season: 2019)

      assert_requested :get, /SeasonYear=2019/
    end

    def test_all_uses_correct_league_in_path
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      DraftCombinePlayerAnthro.all(season: 2019, league: "10")

      assert_requested :get, /LeagueID=10/
    end

    def test_all_uses_default_league_when_not_specified
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      DraftCombinePlayerAnthro.all(season: 2019)

      assert_requested :get, /LeagueID=00/
    end

    def test_all_parses_measurements_successfully
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      measurements = DraftCombinePlayerAnthro.all(season: 2019)

      assert_equal 1, measurements.size
      assert_equal 1_630_162, measurements.first.player_id
      assert_equal "Victor Wembanyama", measurements.first.player_name
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, response.to_json, [String]

      DraftCombinePlayerAnthro.all(season: 2019, client: mock_client)

      mock_client.verify
    end

    def test_all_accepts_league_object
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)
      league = League.new(id: "10")

      DraftCombinePlayerAnthro.all(season: 2019, league: league)

      assert_requested :get, /LeagueID=10/
    end

    private

    def response
      {resultSets: [{name: "Results", headers: HEADERS, rowSet: [ROW]}]}
    end
  end

  class DraftCombinePlayerAnthroPlayerAttrTest < Minitest::Test
    cover DraftCombinePlayerAnthro

    def test_parses_temp_player_id
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal 123_456, DraftCombinePlayerAnthro.all(season: 2019).first.temp_player_id
    end

    def test_parses_player_id
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal 1_630_162, DraftCombinePlayerAnthro.all(season: 2019).first.player_id
    end

    def test_parses_first_name
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "Victor", DraftCombinePlayerAnthro.all(season: 2019).first.first_name
    end

    def test_parses_last_name
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "Wembanyama", DraftCombinePlayerAnthro.all(season: 2019).first.last_name
    end

    def test_parses_player_name
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "Victor Wembanyama", DraftCombinePlayerAnthro.all(season: 2019).first.player_name
    end

    def test_parses_position
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "C", DraftCombinePlayerAnthro.all(season: 2019).first.position
    end

    private

    def response
      headers = %w[TEMP_PLAYER_ID PLAYER_ID FIRST_NAME LAST_NAME PLAYER_NAME POSITION]
      row = [123_456, 1_630_162, "Victor", "Wembanyama", "Victor Wembanyama", "C"]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftCombinePlayerAnthroHeightAttrTest < Minitest::Test
    cover DraftCombinePlayerAnthro

    def test_parses_height_wo_shoes
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(85.5, DraftCombinePlayerAnthro.all(season: 2019).first.height_wo_shoes)
    end

    def test_parses_height_wo_shoes_ft_in
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "7' 1.5\"", DraftCombinePlayerAnthro.all(season: 2019).first.height_wo_shoes_ft_in
    end

    def test_parses_height_w_shoes
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(86.5, DraftCombinePlayerAnthro.all(season: 2019).first.height_w_shoes)
    end

    def test_parses_height_w_shoes_ft_in
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "7' 2.5\"", DraftCombinePlayerAnthro.all(season: 2019).first.height_w_shoes_ft_in
    end

    private

    def response
      headers = %w[HEIGHT_WO_SHOES HEIGHT_WO_SHOES_FT_IN HEIGHT_W_SHOES HEIGHT_W_SHOES_FT_IN]
      row = [85.5, "7' 1.5\"", 86.5, "7' 2.5\""]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftCombinePlayerAnthroPhysicalAttrTest < Minitest::Test
    cover DraftCombinePlayerAnthro

    def test_parses_weight
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(209.0, DraftCombinePlayerAnthro.all(season: 2019).first.weight)
    end

    def test_parses_wingspan
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(96.0, DraftCombinePlayerAnthro.all(season: 2019).first.wingspan)
    end

    def test_parses_wingspan_ft_in
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "8' 0\"", DraftCombinePlayerAnthro.all(season: 2019).first.wingspan_ft_in
    end

    def test_parses_standing_reach
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(114.5, DraftCombinePlayerAnthro.all(season: 2019).first.standing_reach)
    end

    def test_parses_standing_reach_ft_in
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "9' 6.5\"", DraftCombinePlayerAnthro.all(season: 2019).first.standing_reach_ft_in
    end

    private

    def response
      headers = %w[WEIGHT WINGSPAN WINGSPAN_FT_IN STANDING_REACH STANDING_REACH_FT_IN]
      row = [209.0, 96.0, "8' 0\"", 114.5, "9' 6.5\""]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftCombinePlayerAnthroBodyAttrTest < Minitest::Test
    cover DraftCombinePlayerAnthro

    def test_parses_body_fat_pct
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(4.8, DraftCombinePlayerAnthro.all(season: 2019).first.body_fat_pct)
    end

    def test_parses_hand_length
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(10.25, DraftCombinePlayerAnthro.all(season: 2019).first.hand_length)
    end

    def test_parses_hand_width
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(12.0, DraftCombinePlayerAnthro.all(season: 2019).first.hand_width)
    end

    private

    def response
      headers = %w[BODY_FAT_PCT HAND_LENGTH HAND_WIDTH]
      row = [4.8, 10.25, 12.0]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftCombinePlayerAnthroMergedAttrTest < Minitest::Test
    cover DraftCombinePlayerAnthro

    def test_merges_all_attribute_groups
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      result = DraftCombinePlayerAnthro.all(season: 2019).first

      assert_equal "Victor Wembanyama", result.player_name
      assert_in_delta(85.5, result.height_wo_shoes)
      assert_in_delta(209.0, result.weight)
    end

    private

    def response
      headers = %w[PLAYER_NAME HEIGHT_WO_SHOES WEIGHT]
      row = ["Victor Wembanyama", 85.5, 209.0]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end
end
