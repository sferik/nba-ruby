require_relative "../test_helper"

module NBA
  # rubocop:disable Metrics/ClassLength
  class LeagueHustleStatsEdgeCasesTest < Minitest::Test
    cover LeagueHustleStats

    def test_player_stats_uses_default_season
      stub_request(:get, /leaguehustlestatsplayer.*Season=#{Utils.format_season(Utils.current_season)}/)
        .to_return(body: player_hustle_response.to_json)

      LeagueHustleStats.player_stats

      assert_requested :get, /leaguehustlestatsplayer.*Season=#{Utils.format_season(Utils.current_season)}/
    end

    def test_player_stats_uses_default_season_type
      stub_request(:get, /leaguehustlestatsplayer.*SeasonType=Regular(%20|\+)Season/)
        .to_return(body: player_hustle_response.to_json)

      LeagueHustleStats.player_stats

      assert_requested :get, /leaguehustlestatsplayer.*SeasonType=Regular(%20|\+)Season/
    end

    def test_player_stats_uses_default_per_mode
      stub_request(:get, /leaguehustlestatsplayer.*PerMode=PerGame/)
        .to_return(body: player_hustle_response.to_json)

      LeagueHustleStats.player_stats

      assert_requested :get, /leaguehustlestatsplayer.*PerMode=PerGame/
    end

    def test_team_stats_uses_default_season
      stub_request(:get, /leaguehustlestatsteam.*Season=#{Utils.format_season(Utils.current_season)}/)
        .to_return(body: team_hustle_response.to_json)

      LeagueHustleStats.team_stats

      assert_requested :get, /leaguehustlestatsteam.*Season=#{Utils.format_season(Utils.current_season)}/
    end

    def test_team_stats_uses_default_season_type
      stub_request(:get, /leaguehustlestatsteam.*SeasonType=Regular(%20|\+)Season/)
        .to_return(body: team_hustle_response.to_json)

      LeagueHustleStats.team_stats

      assert_requested :get, /leaguehustlestatsteam.*SeasonType=Regular(%20|\+)Season/
    end

    def test_team_stats_uses_default_per_mode
      stub_request(:get, /leaguehustlestatsteam.*PerMode=PerGame/)
        .to_return(body: team_hustle_response.to_json)

      LeagueHustleStats.team_stats

      assert_requested :get, /leaguehustlestatsteam.*PerMode=PerGame/
    end

    def test_player_stats_returns_empty_when_no_result_set
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, LeagueHustleStats.player_stats.size
    end

    def test_player_stats_returns_empty_when_result_sets_key_missing
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: {}.to_json)

      assert_equal 0, LeagueHustleStats.player_stats.size
    end

    def test_team_stats_returns_empty_when_no_result_set
      stub_request(:get, /leaguehustlestatsteam/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, LeagueHustleStats.team_stats.size
    end

    def test_team_stats_returns_empty_when_result_sets_key_missing
      stub_request(:get, /leaguehustlestatsteam/).to_return(body: {}.to_json)

      assert_equal 0, LeagueHustleStats.team_stats.size
    end

    # rubocop:disable Metrics/MethodLength
    def test_player_stats_finds_correct_result_set
      wrong_set = {name: "HustleStatsTeam", headers: %w[TEAM_ID], rowSet: [[1_610_612_744]]}
      correct_set = {
        name: "HustleStatsPlayer",
        headers: %w[PLAYER_ID PLAYER_NAME],
        rowSet: [[201_939, "Stephen Curry"]]
      }
      response = {resultSets: [wrong_set, correct_set]}
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)

      stat = LeagueHustleStats.player_stats.first

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
    end
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength
    def test_team_stats_finds_correct_result_set
      wrong_set = {name: "HustleStatsPlayer", headers: %w[PLAYER_ID], rowSet: [[201_939]]}
      correct_set = {
        name: "HustleStatsTeam",
        headers: %w[TEAM_ID TEAM_NAME],
        rowSet: [[1_610_612_744, "Warriors"]]
      }
      response = {resultSets: [wrong_set, correct_set]}
      stub_request(:get, /leaguehustlestatsteam/).to_return(body: response.to_json)

      stat = LeagueHustleStats.team_stats.first

      assert_equal 1_610_612_744, stat.team_id
      assert_equal "Warriors", stat.team_name
    end
    # rubocop:enable Metrics/MethodLength

    def test_player_stats_returns_empty_when_result_set_name_missing
      result_set = {headers: %w[PLAYER_ID], rowSet: [[201_939]]}
      response = {resultSets: [result_set]}
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)

      assert_equal 0, LeagueHustleStats.player_stats.size
    end

    def test_team_stats_returns_empty_when_result_set_name_missing
      result_set = {headers: %w[TEAM_ID], rowSet: [[1_610_612_744]]}
      response = {resultSets: [result_set]}
      stub_request(:get, /leaguehustlestatsteam/).to_return(body: response.to_json)

      assert_equal 0, LeagueHustleStats.team_stats.size
    end

    def test_player_stats_returns_empty_when_wrong_result_set
      result_set = {name: "WrongName", headers: %w[PLAYER_ID], rowSet: [[201_939]]}
      response = {resultSets: [result_set]}
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)

      assert_equal 0, LeagueHustleStats.player_stats.size
    end

    def test_team_stats_returns_empty_when_wrong_result_set
      result_set = {name: "WrongName", headers: %w[TEAM_ID], rowSet: [[1_610_612_744]]}
      response = {resultSets: [result_set]}
      stub_request(:get, /leaguehustlestatsteam/).to_return(body: response.to_json)

      assert_equal 0, LeagueHustleStats.team_stats.size
    end

    def test_player_stats_returns_empty_when_headers_key_missing
      result_set = {name: "HustleStatsPlayer", rowSet: [[201_939]]}
      response = {resultSets: [result_set]}
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)

      assert_equal 0, LeagueHustleStats.player_stats.size
    end

    def test_player_stats_returns_empty_when_rowset_key_missing
      result_set = {name: "HustleStatsPlayer", headers: %w[PLAYER_ID]}
      response = {resultSets: [result_set]}
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)

      assert_equal 0, LeagueHustleStats.player_stats.size
    end

    def test_team_stats_returns_empty_when_headers_key_missing
      result_set = {name: "HustleStatsTeam", rowSet: [[1_610_612_744]]}
      response = {resultSets: [result_set]}
      stub_request(:get, /leaguehustlestatsteam/).to_return(body: response.to_json)

      assert_equal 0, LeagueHustleStats.team_stats.size
    end

    def test_team_stats_returns_empty_when_rowset_key_missing
      result_set = {name: "HustleStatsTeam", headers: %w[TEAM_ID]}
      response = {resultSets: [result_set]}
      stub_request(:get, /leaguehustlestatsteam/).to_return(body: response.to_json)

      assert_equal 0, LeagueHustleStats.team_stats.size
    end

    private

    def player_hustle_response
      {resultSets: [{
        name: "HustleStatsPlayer",
        headers: %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE G W L MIN CONTESTED_SHOTS
          CONTESTED_SHOTS_2PT CONTESTED_SHOTS_3PT DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS
          SCREEN_AST_PTS LOOSE_BALLS_RECOVERED OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED
          BOX_OUTS OFF_BOX_OUTS DEF_BOX_OUTS],
        rowSet: [[201_939, "Stephen Curry", Team::GSW, "GSW", 36, 82, 50, 32, 34.5,
          5.5, 3.5, 2.0, 2.5, 0.2, 3.0, 7.5, 1.0, 0.5, 0.5, 2.0, 0.5, 1.5]]
      }]}
    end

    def team_hustle_response
      {resultSets: [{
        name: "HustleStatsTeam",
        headers: %w[TEAM_ID TEAM_NAME G W L MIN CONTESTED_SHOTS CONTESTED_SHOTS_2PT
          CONTESTED_SHOTS_3PT DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS SCREEN_AST_PTS
          LOOSE_BALLS_RECOVERED OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED BOX_OUTS
          OFF_BOX_OUTS DEF_BOX_OUTS],
        rowSet: [[Team::GSW, "Warriors", 82, 50, 32, 48.0,
          55.0, 35.0, 20.0, 15.0, 1.5, 18.0, 45.0, 6.5, 3.0, 3.5, 12.0, 3.5, 8.5]]
      }]}
    end
  end
  # rubocop:enable Metrics/ClassLength
end
