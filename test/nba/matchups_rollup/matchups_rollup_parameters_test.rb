require_relative "../../test_helper"

module NBA
  class MatchupsRollupParametersTest < Minitest::Test
    cover MatchupsRollup

    def test_all_with_off_player
      stub_request(:get, /matchupsrollup.*OffPlayerID=1628369/)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all(off_player: 1_628_369)

      assert_requested :get, /matchupsrollup.*OffPlayerID=1628369/
    end

    def test_all_with_off_team
      stub_request(:get, /matchupsrollup.*OffTeamID=#{Team::BOS}/o)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all(off_team: Team::BOS)

      assert_requested :get, /matchupsrollup.*OffTeamID=#{Team::BOS}/o
    end

    def test_all_with_player_object_for_def_player
      player = Player.new(id: 1_628_369)
      stub_request(:get, /matchupsrollup.*DefPlayerID=1628369/)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all(def_player: player)

      assert_requested :get, /matchupsrollup.*DefPlayerID=1628369/
    end

    def test_all_with_player_object_for_off_player
      player = Player.new(id: 1_628_369)
      stub_request(:get, /matchupsrollup.*OffPlayerID=1628369/)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all(off_player: player)

      assert_requested :get, /matchupsrollup.*OffPlayerID=1628369/
    end

    def test_all_with_team_object_for_def_team
      team = Team.new(id: Team::BOS)
      stub_request(:get, /matchupsrollup.*DefTeamID=#{Team::BOS}/o)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all(def_team: team)

      assert_requested :get, /matchupsrollup.*DefTeamID=#{Team::BOS}/o
    end

    def test_all_with_team_object_for_off_team
      team = Team.new(id: Team::BOS)
      stub_request(:get, /matchupsrollup.*OffTeamID=#{Team::BOS}/o)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all(off_team: team)

      assert_requested :get, /matchupsrollup.*OffTeamID=#{Team::BOS}/o
    end

    def test_all_default_season_type_is_regular_season
      stub_request(:get, /matchupsrollup.*SeasonType=Regular%20Season/)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all

      assert_requested :get, /matchupsrollup.*SeasonType=Regular%20Season/
    end

    def test_all_default_per_mode_is_totals
      stub_request(:get, /matchupsrollup.*PerMode=Totals/)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all

      assert_requested :get, /matchupsrollup.*PerMode=Totals/
    end

    def test_all_default_league_is_nba
      stub_request(:get, /matchupsrollup.*LeagueID=00/)
        .to_return(body: matchups_rollup_response.to_json)

      MatchupsRollup.all

      assert_requested :get, /matchupsrollup.*LeagueID=00/
    end

    private

    def matchups_rollup_response
      {resultSets: [{name: "MatchupsRollup", headers: all_headers, rowSet: [full_row]}]}
    end

    def all_headers
      %w[SEASON_ID POSITION PERCENT_OF_TIME DEF_PLAYER_ID DEF_PLAYER_NAME
        GP MATCHUP_MIN PARTIAL_POSS PLAYER_PTS TEAM_PTS
        MATCHUP_FG_PCT MATCHUP_FG3_PCT]
    end

    def full_row
      ["22023", "F", 0.25, 1_628_369, "Jayson Tatum",
        82, 15.5, 10.2, 8.5, 12.3, 0.425, 0.352]
    end
  end
end
