require_relative "../test_helper"

module NBA
  class TeamInfoCommonRanksTest < Minitest::Test
    cover TeamInfoCommon

    def test_ranks_returns_team_season_rank
      stub_team_info_request

      result = TeamInfoCommon.ranks(team: 1_610_612_744)

      assert_instance_of TeamSeasonRank, result
    end

    def test_ranks_parses_league_id
      assert_equal "00", team_season_rank.league_id
    end

    def test_ranks_parses_season_id
      assert_equal "2024-25", team_season_rank.season_id
    end

    def test_ranks_parses_team_id
      assert_equal 1_610_612_744, team_season_rank.team_id
    end

    def test_ranks_parses_pts_rank
      assert_equal 5, team_season_rank.pts_rank
    end

    def test_ranks_parses_pts_pg
      assert_in_delta 118.9, team_season_rank.pts_pg
    end

    def test_ranks_parses_reb_rank
      assert_equal 12, team_season_rank.reb_rank
    end

    def test_ranks_parses_reb_pg
      assert_in_delta 44.2, team_season_rank.reb_pg
    end

    def test_ranks_parses_ast_rank
      assert_equal 3, team_season_rank.ast_rank
    end

    def test_ranks_parses_ast_pg
      assert_in_delta 28.7, team_season_rank.ast_pg
    end

    def test_ranks_parses_opp_pts_rank
      assert_equal 15, team_season_rank.opp_pts_rank
    end

    def test_ranks_parses_opp_pts_pg
      assert_in_delta 115.2, team_season_rank.opp_pts_pg
    end

    private

    def team_season_rank
      stub_team_info_request
      TeamInfoCommon.ranks(team: 1_610_612_744)
    end

    def stub_team_info_request
      stub_request(:get, /teaminfocommon.*TeamID=1610612744/).to_return(body: full_response.to_json)
    end

    def full_response
      {resultSets: [
        {name: "TeamInfoCommon", headers: info_headers, rowSet: [info_row]},
        {name: "TeamSeasonRanks", headers: rank_headers, rowSet: [rank_row]},
        {name: "AvailableSeasons", headers: ["SEASON_ID"], rowSet: [["2024-25"], ["2023-24"]]}
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
