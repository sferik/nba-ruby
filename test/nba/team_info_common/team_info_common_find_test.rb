require_relative "../../test_helper"

module NBA
  class TeamInfoCommonFindTest < Minitest::Test
    cover TeamInfoCommon

    def test_find_returns_team_info
      stub_team_info_request

      result = TeamInfoCommon.find(team: 1_610_612_744)

      assert_instance_of TeamInfo, result
    end

    def test_find_parses_team_id
      assert_equal 1_610_612_744, team_info.team_id
    end

    def test_find_parses_team_city
      assert_equal "Golden State", team_info.team_city
    end

    def test_find_parses_team_name
      assert_equal "Warriors", team_info.team_name
    end

    def test_find_parses_team_abbreviation
      assert_equal "GSW", team_info.team_abbreviation
    end

    def test_find_parses_team_conference
      assert_equal "West", team_info.team_conference
    end

    def test_find_parses_team_division
      assert_equal "Pacific", team_info.team_division
    end

    def test_find_parses_team_code
      assert_equal "warriors", team_info.team_code
    end

    def test_find_parses_team_slug
      assert_equal "warriors", team_info.team_slug
    end

    def test_find_parses_wins
      assert_equal 46, team_info.w
    end

    def test_find_parses_losses
      assert_equal 36, team_info.l
    end

    def test_find_parses_pct
      assert_in_delta 0.561, team_info.pct
    end

    def test_find_parses_conf_rank
      assert_equal 4, team_info.conf_rank
    end

    def test_find_parses_div_rank
      assert_equal 2, team_info.div_rank
    end

    def test_find_parses_min_year
      assert_equal "1946", team_info.min_year
    end

    def test_find_parses_max_year
      assert_equal "2024", team_info.max_year
    end

    def test_find_parses_season_year
      assert_equal "2024-25", team_info.season_year
    end

    def test_find_accepts_team_object
      stub_request(:get, /teaminfocommon.*TeamID=1610612744/).to_return(body: full_response.to_json)
      team = Team.new(id: 1_610_612_744)

      result = TeamInfoCommon.find(team: team)

      assert_instance_of TeamInfo, result
    end

    private

    def team_info
      stub_team_info_request
      TeamInfoCommon.find(team: 1_610_612_744)
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
