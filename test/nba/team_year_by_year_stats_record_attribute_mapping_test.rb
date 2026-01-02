require_relative "../test_helper"

module NBA
  class TeamYearByYearStatsRecordAttributeMappingTest < Minitest::Test
    cover TeamYearByYearStats

    def test_maps_win_loss_attributes
      stub_year_stats_request

      stat = TeamYearByYearStats.find(team: Team::GSW).first

      assert_equal 46, stat.wins
      assert_equal 36, stat.losses
      assert_in_delta 0.561, stat.win_pct
    end

    def test_maps_ranking_and_playoff_attributes
      stub_year_stats_request

      stat = TeamYearByYearStats.find(team: Team::GSW).first

      assert_equal 10, stat.conf_rank
      assert_equal 3, stat.div_rank
      assert_equal 0, stat.po_wins
      assert_equal 0, stat.po_losses
      assert_equal "N/A", stat.nba_finals_appearance
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
