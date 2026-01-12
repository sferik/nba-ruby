require_relative "../../test_helper"

module NBA
  class PlayerCompareBasicTest < Minitest::Test
    cover PlayerCompare

    def test_compare_returns_collection
      stub_compare_request

      result = PlayerCompare.compare(player: 201_939, vs_player: 2544, season: 2024)

      assert_instance_of Collection, result
    end

    def test_compare_uses_correct_player_ids_in_path
      stub_compare_request

      PlayerCompare.compare(player: 201_939, vs_player: 2544, season: 2024)

      assert_requested :get, /playercompare.*PlayerIDList=201939.*VsPlayerIDList=2544/
    end

    def test_compare_uses_correct_season_in_path
      stub_compare_request

      PlayerCompare.compare(player: 201_939, vs_player: 2544, season: 2024)

      assert_requested :get, /playercompare.*Season=2024-25/
    end

    def test_compare_parses_result_set_successfully
      stub_compare_request

      stats = PlayerCompare.compare(player: 201_939, vs_player: 2544, season: 2024)

      assert_equal 2, stats.size
    end

    def test_compare_accepts_player_objects
      stub_compare_request
      player1 = Player.new(id: 201_939)
      player2 = Player.new(id: 2544)

      stats = PlayerCompare.compare(player: player1, vs_player: player2, season: 2024)

      assert_equal 2, stats.size
    end

    def test_compare_accepts_season_type_parameter
      stub_compare_request

      PlayerCompare.compare(player: 201_939, vs_player: 2544, season: 2024, season_type: PlayerCompare::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_compare_uses_default_season_from_utils
      stub_compare_request
      expected_season = Utils.current_season
      expected_str = "#{expected_season}-#{(expected_season + 1).to_s[-2..]}"

      PlayerCompare.compare(player: 201_939, vs_player: 2544)

      assert_requested :get, /Season=#{expected_str}/
    end

    def test_compare_uses_default_season_type_regular_season
      stub_compare_request

      PlayerCompare.compare(player: 201_939, vs_player: 2544)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_compare_uses_per_game_per_mode_in_url
      stub_compare_request

      PlayerCompare.compare(player: 201_939, vs_player: 2544, season: 2024)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_compare_uses_league_id_in_url
      stub_compare_request

      PlayerCompare.compare(player: 201_939, vs_player: 2544, season: 2024)

      assert_requested :get, /LeagueID=00/
    end

    def test_compare_extracts_player_id_from_player_object_in_url
      stub_compare_request
      player1 = Player.new(id: 201_939)
      player2 = Player.new(id: 2544)

      PlayerCompare.compare(player: player1, vs_player: player2, season: 2024)

      assert_requested :get, /PlayerIDList=201939.*VsPlayerIDList=2544/
    end

    def test_compare_passes_integer_player_id_directly_in_url
      stub_compare_request

      PlayerCompare.compare(player: 12_345, vs_player: 67_890, season: 2024)

      assert_requested :get, /PlayerIDList=12345.*VsPlayerIDList=67890/
    end

    def test_compare_with_mixed_player_id_types_in_url
      stub_compare_request
      player1 = Player.new(id: 201_939)

      PlayerCompare.compare(player: player1, vs_player: 2544, season: 2024)

      assert_requested :get, /PlayerIDList=201939.*VsPlayerIDList=2544/
    end

    private

    def stub_compare_request
      stub_request(:get, /playercompare/).to_return(body: compare_response.to_json)
    end

    def compare_response
      {resultSets: [{name: "OverallCompare", headers: player_headers, rowSet: [player_row1, player_row2]}]}
    end

    def player_headers
      %w[PLAYER_ID FIRST_NAME LAST_NAME SEASON_ID GP MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS EFF AST_TOV STL_TOV]
    end

    def player_row1
      [201_939, "Stephen", "Curry", "2024-25", 72, 34.5, 9.2, 19.8, 0.465, 4.8, 11.2, 0.429,
        5.1, 5.5, 0.927, 0.5, 4.3, 4.8, 5.1, 0.9, 0.4, 3.2, 2.1, 28.3, 28.5, 1.59, 0.28]
    end

    def player_row2
      [2544, "LeBron", "James", "2024-25", 71, 35.3, 9.1, 17.9, 0.508, 2.2, 5.9, 0.373,
        5.2, 7.4, 0.703, 1.2, 6.7, 7.9, 8.3, 1.3, 0.5, 3.5, 1.1, 25.6, 27.2, 2.37, 0.37]
    end
  end
end
