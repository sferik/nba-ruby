require_relative "../test_helper"

module NBA
  class TeamInfoCommonRanksMissingKeysTest < Minitest::Test
    cover TeamInfoCommon

    def test_ranks_handles_missing_league_id_key
      stub_request(:get, /teaminfocommon/).to_return(body: ranks_response_missing_key("LEAGUE_ID").to_json)

      assert_nil TeamInfoCommon.ranks(team: 1_610_612_744).league_id
    end

    def test_ranks_handles_missing_season_id_key
      stub_request(:get, /teaminfocommon/).to_return(body: ranks_response_missing_key("SEASON_ID").to_json)

      assert_nil TeamInfoCommon.ranks(team: 1_610_612_744).season_id
    end

    def test_ranks_handles_missing_team_id_key
      stub_request(:get, /teaminfocommon/).to_return(body: ranks_response_missing_key("TEAM_ID").to_json)

      assert_nil TeamInfoCommon.ranks(team: 1_610_612_744).team_id
    end

    def test_ranks_handles_missing_pts_rank_key
      stub_request(:get, /teaminfocommon/).to_return(body: ranks_response_missing_key("PTS_RANK").to_json)

      assert_nil TeamInfoCommon.ranks(team: 1_610_612_744).pts_rank
    end

    def test_ranks_handles_missing_pts_pg_key
      stub_request(:get, /teaminfocommon/).to_return(body: ranks_response_missing_key("PTS_PG").to_json)

      assert_nil TeamInfoCommon.ranks(team: 1_610_612_744).pts_pg
    end

    def test_ranks_handles_missing_reb_rank_key
      stub_request(:get, /teaminfocommon/).to_return(body: ranks_response_missing_key("REB_RANK").to_json)

      assert_nil TeamInfoCommon.ranks(team: 1_610_612_744).reb_rank
    end

    def test_ranks_handles_missing_reb_pg_key
      stub_request(:get, /teaminfocommon/).to_return(body: ranks_response_missing_key("REB_PG").to_json)

      assert_nil TeamInfoCommon.ranks(team: 1_610_612_744).reb_pg
    end

    def test_ranks_handles_missing_ast_rank_key
      stub_request(:get, /teaminfocommon/).to_return(body: ranks_response_missing_key("AST_RANK").to_json)

      assert_nil TeamInfoCommon.ranks(team: 1_610_612_744).ast_rank
    end

    def test_ranks_handles_missing_ast_pg_key
      stub_request(:get, /teaminfocommon/).to_return(body: ranks_response_missing_key("AST_PG").to_json)

      assert_nil TeamInfoCommon.ranks(team: 1_610_612_744).ast_pg
    end

    def test_ranks_handles_missing_opp_pts_rank_key
      stub_request(:get, /teaminfocommon/).to_return(body: ranks_response_missing_key("OPP_PTS_RANK").to_json)

      assert_nil TeamInfoCommon.ranks(team: 1_610_612_744).opp_pts_rank
    end

    def test_ranks_handles_missing_opp_pts_pg_key
      stub_request(:get, /teaminfocommon/).to_return(body: ranks_response_missing_key("OPP_PTS_PG").to_json)

      assert_nil TeamInfoCommon.ranks(team: 1_610_612_744).opp_pts_pg
    end

    private

    def ranks_response_missing_key(key)
      headers = rank_headers.reject { |h| h == key }
      row = rank_row.each_with_index.reject { |_, i| rank_headers[i] == key }.map(&:first)
      {resultSets: [
        {name: "TeamInfoCommon", headers: info_headers, rowSet: [info_row]},
        {name: "TeamSeasonRanks", headers: headers, rowSet: [row]},
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
