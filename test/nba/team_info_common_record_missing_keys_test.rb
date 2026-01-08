require_relative "../test_helper"

module NBA
  class TeamInfoCommonRecordMissingKeysTest < Minitest::Test
    cover TeamInfoCommon

    def test_find_handles_missing_w_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("W").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).w
    end

    def test_find_handles_missing_l_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("L").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).l
    end

    def test_find_handles_missing_pct_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("PCT").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).pct
    end

    def test_find_handles_missing_conf_rank_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("CONF_RANK").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).conf_rank
    end

    def test_find_handles_missing_div_rank_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("DIV_RANK").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).div_rank
    end

    def test_find_handles_missing_min_year_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("MIN_YEAR").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).min_year
    end

    def test_find_handles_missing_max_year_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("MAX_YEAR").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).max_year
    end

    def test_find_handles_missing_season_year_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("SEASON_YEAR").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).season_year
    end

    def test_find_with_multiple_rows_returns_first
      response = {resultSets: [
        {name: "TeamInfoCommon", headers: info_headers, rowSet: [info_row, second_info_row]},
        {name: "TeamSeasonRanks", headers: rank_headers, rowSet: [rank_row]},
        {name: "AvailableSeasons", headers: ["SEASON_ID"], rowSet: [["2024-25"]]}
      ]}
      stub_request(:get, /teaminfocommon/).to_return(body: response.to_json)

      assert_equal 1_610_612_744, TeamInfoCommon.find(team: 1_610_612_744).team_id
    end

    private

    def response_missing_key(key)
      headers = info_headers.reject { |h| h == key }
      row = info_row.each_with_index.reject { |_, i| info_headers[i] == key }.map(&:first)
      {resultSets: [
        {name: "TeamInfoCommon", headers: headers, rowSet: [row]},
        {name: "TeamSeasonRanks", headers: rank_headers, rowSet: [rank_row]},
        {name: "AvailableSeasons", headers: ["SEASON_ID"], rowSet: [["2024-25"]]}
      ]}
    end

    def info_headers
      %w[TEAM_ID SEASON_YEAR TEAM_CITY TEAM_NAME TEAM_ABBREVIATION TEAM_CONFERENCE TEAM_DIVISION
        TEAM_CODE TEAM_SLUG W L PCT CONF_RANK DIV_RANK MIN_YEAR MAX_YEAR]
    end

    def info_row
      [1_610_612_744, "2024-25", "Golden State", "Warriors", "GSW", "West", "Pacific",
        "warriors", "warriors", 46, 36, 0.561, 4, 2, "1946", "2024"]
    end

    def second_info_row
      [1_610_612_745, "2024-25", "Los Angeles", "Lakers", "LAL", "West", "Pacific",
        "lakers", "lakers", 50, 32, 0.610, 3, 1, "1948", "2024"]
    end

    def rank_headers
      %w[LEAGUE_ID SEASON_ID TEAM_ID PTS_RANK PTS_PG REB_RANK REB_PG AST_RANK AST_PG OPP_PTS_RANK OPP_PTS_PG]
    end

    def rank_row
      ["00", "2024-25", 1_610_612_744, 5, 118.9, 12, 44.2, 3, 28.7, 15, 115.2]
    end
  end
end
