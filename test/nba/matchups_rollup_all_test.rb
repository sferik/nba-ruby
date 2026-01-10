require_relative "../test_helper"

module NBA
  class MatchupsRollupAllTest < Minitest::Test
    cover MatchupsRollup

    def test_all_returns_collection
      stub_matchups_rollup_request

      assert_instance_of Collection, MatchupsRollup.all
    end

    def test_all_parses_season_info
      stub_matchups_rollup_request

      matchup = MatchupsRollup.all.first

      assert_equal "22023", matchup.season_id
      assert_equal "F", matchup.position
    end

    def test_all_parses_player_info
      stub_matchups_rollup_request

      matchup = MatchupsRollup.all.first

      assert_equal 1_628_369, matchup.def_player_id
      assert_equal "Jayson Tatum", matchup.def_player_name
    end

    def test_all_parses_stats
      stub_matchups_rollup_request

      matchup = MatchupsRollup.all.first

      assert_equal 82, matchup.gp
      assert_in_delta 0.425, matchup.matchup_fg_pct
    end

    def test_all_parses_percent_of_time
      stub_matchups_rollup_request

      matchup = MatchupsRollup.all.first

      assert_in_delta 0.25, matchup.percent_of_time
    end

    def test_all_parses_team_pts
      stub_matchups_rollup_request

      matchup = MatchupsRollup.all.first

      assert_in_delta 12.3, matchup.team_pts
    end

    def test_all_parses_matchup_fg3_pct
      stub_matchups_rollup_request

      matchup = MatchupsRollup.all.first

      assert_in_delta 0.352, matchup.matchup_fg3_pct
    end

    def test_all_with_custom_season
      stub_request(:get, /matchupsrollup.*Season=2022-23/)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all(season: 2022)

      assert_requested :get, /matchupsrollup.*Season=2022-23/
    end

    def test_all_with_playoffs_season_type
      stub_request(:get, /matchupsrollup.*SeasonType=Playoffs/)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all(season_type: "Playoffs")

      assert_requested :get, /matchupsrollup.*SeasonType=Playoffs/
    end

    def test_all_with_per_mode
      stub_request(:get, /matchupsrollup.*PerMode=PerGame/)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all(per_mode: "PerGame")

      assert_requested :get, /matchupsrollup.*PerMode=PerGame/
    end

    def test_all_with_def_player
      stub_request(:get, /matchupsrollup.*DefPlayerID=1628369/)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all(def_player: 1_628_369)

      assert_requested :get, /matchupsrollup.*DefPlayerID=1628369/
    end

    def test_all_with_def_team
      stub_request(:get, /matchupsrollup.*DefTeamID=#{Team::BOS}/o)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all(def_team: Team::BOS)

      assert_requested :get, /matchupsrollup.*DefTeamID=#{Team::BOS}/o
    end

    def test_all_with_league_object
      league = League.new(id: "00")
      stub_request(:get, /matchupsrollup.*LeagueID=00/)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all(league: league)

      assert_requested :get, /matchupsrollup.*LeagueID=00/
    end

    def test_all_with_league_string
      stub_request(:get, /matchupsrollup.*LeagueID=00/)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all(league: "00")

      assert_requested :get, /matchupsrollup.*LeagueID=00/
    end

    private

    def stub_matchups_rollup_request
      stub_request(:get, /matchupsrollup/).to_return(body: matchups_rollup_response.to_json)
    end

    def matchups_rollup_response
      {resultSets: [{name: "MatchupsRollup",
                     headers: %w[SEASON_ID POSITION PERCENT_OF_TIME DEF_PLAYER_ID DEF_PLAYER_NAME
                       GP MATCHUP_MIN PARTIAL_POSS PLAYER_PTS TEAM_PTS
                       MATCHUP_FG_PCT MATCHUP_FG3_PCT],
                     rowSet: [["22023", "F", 0.25, 1_628_369, "Jayson Tatum",
                       82, 15.5, 10.2, 8.5, 12.3, 0.425, 0.352]]}]}
    end
  end
end
