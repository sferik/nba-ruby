require_relative "../test_helper"
require_relative "league_hustle_stats_player_test_helper"

module NBA
  class LeagueHustleStatsPlayerMissingBoxOutKeysTest < Minitest::Test
    include LeagueHustleStatsPlayerTestHelper

    cover LeagueHustleStatsPlayer

    def test_handles_missing_off_boxouts
      assert_missing_key_returns_nil("OFF_BOXOUTS", :off_boxouts)
    end

    def test_handles_missing_def_boxouts
      assert_missing_key_returns_nil("DEF_BOXOUTS", :def_boxouts)
    end

    def test_handles_missing_box_out_player_team_rebs
      assert_missing_key_returns_nil("BOX_OUT_PLAYER_TEAM_REBS", :box_out_player_team_rebs)
    end

    def test_handles_missing_box_out_player_rebs
      assert_missing_key_returns_nil("BOX_OUT_PLAYER_REBS", :box_out_player_rebs)
    end

    def test_handles_missing_pct_box_outs_off
      assert_missing_key_returns_nil("PCT_BOX_OUTS_OFF", :pct_box_outs_off)
    end

    def test_handles_missing_pct_box_outs_def
      assert_missing_key_returns_nil("PCT_BOX_OUTS_DEF", :pct_box_outs_def)
    end

    def test_handles_missing_pct_box_outs_team_reb
      assert_missing_key_returns_nil("PCT_BOX_OUTS_TEAM_REB", :pct_box_outs_team_reb)
    end

    def test_handles_missing_pct_box_outs_reb
      assert_missing_key_returns_nil("PCT_BOX_OUTS_REB", :pct_box_outs_reb)
    end

    private

    def assert_missing_key_returns_nil(key, attribute)
      response = build_response_without_key(key)
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)

      stat = LeagueHustleStatsPlayer.all(season: 2024).first

      assert_nil stat.send(attribute)
    end
  end
end
