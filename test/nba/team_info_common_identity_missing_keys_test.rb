require_relative "../test_helper"

module NBA
  class TeamInfoCommonIdentityMissingKeysTest < Minitest::Test
    cover TeamInfoCommon

    def test_find_handles_missing_team_id_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("TEAM_ID").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).team_id
    end

    def test_find_handles_missing_team_city_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("TEAM_CITY").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).team_city
    end

    def test_find_handles_missing_team_name_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("TEAM_NAME").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).team_name
    end

    def test_find_handles_missing_team_abbreviation_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("TEAM_ABBREVIATION").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).team_abbreviation
    end

    def test_find_handles_missing_team_conference_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("TEAM_CONFERENCE").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).team_conference
    end

    def test_find_handles_missing_team_division_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("TEAM_DIVISION").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).team_division
    end

    def test_find_handles_missing_team_code_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("TEAM_CODE").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).team_code
    end

    def test_find_handles_missing_team_slug_key
      stub_request(:get, /teaminfocommon/).to_return(body: response_missing_key("TEAM_SLUG").to_json)

      assert_nil TeamInfoCommon.find(team: 1_610_612_744).team_slug
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

    def rank_headers
      %w[LEAGUE_ID SEASON_ID TEAM_ID PTS_RANK PTS_PG REB_RANK REB_PG AST_RANK AST_PG OPP_PTS_RANK OPP_PTS_PG]
    end

    def rank_row
      ["00", "2024-25", 1_610_612_744, 5, 118.9, 12, 44.2, 3, 28.7, 15, 115.2]
    end
  end
end
