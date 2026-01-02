require_relative "../test_helper"

module NBA
  class PlayerCompareShootingAttributeMappingTest < Minitest::Test
    cover PlayerCompare

    def test_maps_field_goal_attributes
      stub_compare_request

      stat = PlayerCompare.compare(player: 201_939, vs_player: 2544, season: 2024).first

      assert_in_delta 9.2, stat.fgm
      assert_in_delta 19.8, stat.fga
      assert_in_delta 0.465, stat.fg_pct
    end

    def test_maps_three_point_attributes
      stub_compare_request

      stat = PlayerCompare.compare(player: 201_939, vs_player: 2544, season: 2024).first

      assert_in_delta 4.8, stat.fg3m
      assert_in_delta 11.2, stat.fg3a
      assert_in_delta 0.429, stat.fg3_pct
    end

    def test_maps_free_throw_attributes
      stub_compare_request

      stat = PlayerCompare.compare(player: 201_939, vs_player: 2544, season: 2024).first

      assert_in_delta 5.1, stat.ftm
      assert_in_delta 5.5, stat.fta
      assert_in_delta 0.927, stat.ft_pct
    end

    private

    def stub_compare_request
      stub_request(:get, /playercompare/).to_return(body: compare_response.to_json)
    end

    def compare_response
      {resultSets: [{name: "OverallCompare", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_headers
      %w[PLAYER_ID FIRST_NAME LAST_NAME SEASON_ID GP MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS EFF AST_TOV STL_TOV]
    end

    def player_row
      [201_939, "Stephen", "Curry", "2024-25", 72, 34.5, 9.2, 19.8, 0.465, 4.8, 11.2, 0.429,
        5.1, 5.5, 0.927, 0.5, 4.3, 4.8, 5.1, 0.9, 0.4, 3.2, 2.1, 28.3, 28.5, 1.59, 0.28]
    end
  end
end
