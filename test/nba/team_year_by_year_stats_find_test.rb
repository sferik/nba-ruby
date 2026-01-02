require_relative "../test_helper"

module NBA
  class TeamYearByYearStatsFindTest < Minitest::Test
    cover TeamYearByYearStats

    def test_find_returns_collection
      stub_year_stats_request

      result = TeamYearByYearStats.find(team: Team::GSW)

      assert_instance_of Collection, result
    end

    def test_find_uses_correct_team_id_in_path
      stub_year_stats_request

      TeamYearByYearStats.find(team: Team::GSW)

      assert_requested :get, /teamyearbyyearstats.*TeamID=#{Team::GSW}/o
    end

    def test_find_accepts_team_object
      stub_year_stats_request
      team = Team.new(id: Team::GSW)

      result = TeamYearByYearStats.find(team: team)

      assert_instance_of Collection, result
    end

    def test_find_parses_year_stats_successfully
      stub_year_stats_request

      stats = TeamYearByYearStats.find(team: Team::GSW)

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_find_accepts_season_type_parameter
      stub_year_stats_request

      TeamYearByYearStats.find(team: Team::GSW, season_type: TeamYearByYearStats::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_find_accepts_per_mode_parameter
      stub_year_stats_request

      TeamYearByYearStats.find(team: Team::GSW, per_mode: TeamYearByYearStats::TOTALS)

      assert_requested :get, /PerMode=Totals/
    end

    def test_find_uses_default_season_type
      stub_year_stats_request

      TeamYearByYearStats.find(team: Team::GSW)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_find_uses_default_per_mode
      stub_year_stats_request

      TeamYearByYearStats.find(team: Team::GSW)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_find_extracts_team_id_from_team_object
      stub_year_stats_request
      team = Team.new(id: Team::GSW)

      TeamYearByYearStats.find(team: team)

      assert_requested :get, /TeamID=#{Team::GSW}/o
    end

    def test_find_uses_integer_team_id_directly
      stub_year_stats_request

      TeamYearByYearStats.find(team: Team::GSW)

      assert_requested :get, /TeamID=#{Team::GSW}/o
    end

    private

    def stub_year_stats_request
      stub_request(:get, /teamyearbyyearstats/).to_return(body: year_stats_response.to_json)
    end

    def year_stats_response
      {resultSets: [{name: "TeamStats", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[TEAM_ID TEAM_CITY TEAM_NAME YEAR GP WINS LOSSES WIN_PCT CONF_RANK DIV_RANK
        PO_WINS PO_LOSSES NBA_FINALS_APPEARANCE FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST PF STL TOV BLK PTS PTS_RANK]
    end

    def stat_row
      [Team::GSW, "Golden State", "Warriors", "2024-25", 82, 46, 36, 0.561, 10, 3,
        0, 0, "N/A", 43.2, 91.5, 0.472, 14.8, 40.2, 0.368, 17.5, 22.1, 0.792,
        10.5, 33.8, 44.3, 28.1, 19.5, 7.8, 14.2, 5.2, 118.7, 5]
    end
  end
end
