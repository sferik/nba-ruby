require_relative "../test_helper"

module NBA
  class PlayerCareerByCollegeRollupMissingKeysTest < Minitest::Test
    cover PlayerCareerByCollegeRollup

    def test_handles_missing_player_id
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: response_without("PLAYER_ID").to_json)

      stat = PlayerCareerByCollegeRollup.east.first

      assert_nil stat.player_id
    end

    def test_handles_missing_player_name
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: response_without("PLAYER_NAME").to_json)

      stat = PlayerCareerByCollegeRollup.east.first

      assert_nil stat.player_name
    end

    def test_handles_missing_college
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: response_without("COLLEGE").to_json)

      stat = PlayerCareerByCollegeRollup.east.first

      assert_nil stat.college
    end

    def test_handles_missing_gp
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: response_without("GP").to_json)

      stat = PlayerCareerByCollegeRollup.east.first

      assert_nil stat.gp
    end

    def test_handles_missing_min
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: response_without("MIN").to_json)

      stat = PlayerCareerByCollegeRollup.east.first

      assert_nil stat.min
    end

    def test_handles_missing_fgm
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: response_without("FGM").to_json)

      stat = PlayerCareerByCollegeRollup.east.first

      assert_nil stat.fgm
    end

    def test_handles_missing_fga
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: response_without("FGA").to_json)

      stat = PlayerCareerByCollegeRollup.east.first

      assert_nil stat.fga
    end

    def test_handles_missing_fg_pct
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: response_without("FG_PCT").to_json)

      stat = PlayerCareerByCollegeRollup.east.first

      assert_nil stat.fg_pct
    end

    def test_handles_missing_fg3m
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: response_without("FG3M").to_json)

      stat = PlayerCareerByCollegeRollup.east.first

      assert_nil stat.fg3m
    end

    def test_handles_missing_fg3a
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: response_without("FG3A").to_json)

      stat = PlayerCareerByCollegeRollup.east.first

      assert_nil stat.fg3a
    end

    def test_handles_missing_fg3_pct
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: response_without("FG3_PCT").to_json)

      stat = PlayerCareerByCollegeRollup.east.first

      assert_nil stat.fg3_pct
    end

    def test_handles_missing_ftm
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: response_without("FTM").to_json)

      stat = PlayerCareerByCollegeRollup.east.first

      assert_nil stat.ftm
    end

    def test_handles_missing_fta
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: response_without("FTA").to_json)

      stat = PlayerCareerByCollegeRollup.east.first

      assert_nil stat.fta
    end

    def test_handles_missing_ft_pct
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: response_without("FT_PCT").to_json)

      stat = PlayerCareerByCollegeRollup.east.first

      assert_nil stat.ft_pct
    end

    private

    def all_headers
      %w[PLAYER_ID PLAYER_NAME COLLEGE GP MIN FGM FGA FG_PCT
        FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS]
    end

    def all_values
      [201_939, "Stephen Curry", "Davidson", 966, 31_000.0,
        8000.0, 16_000.0, 0.5, 3500.0, 8500.0, 0.412,
        4500.0, 4900.0, 0.918, 700.0, 4200.0, 4900.0,
        5800.0, 1400.0, 300.0, 2600.0, 2000.0, 24_000.0]
    end

    def response_without(key)
      index = all_headers.index(key)
      headers = all_headers.reject { |h| h.eql?(key) }
      values = all_values.reject.with_index { |_, i| i.eql?(index) }
      {resultSets: [{name: "East", headers: headers, rowSet: [values]}]}
    end
  end
end
