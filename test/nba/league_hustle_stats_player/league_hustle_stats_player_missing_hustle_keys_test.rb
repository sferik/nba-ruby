require_relative "../../test_helper"
require_relative "league_hustle_stats_player_test_helper"

module NBA
  class LeagueHustleStatsPlayerMissingHustleKeysTest < Minitest::Test
    include LeagueHustleStatsPlayerTestHelper

    cover LeagueHustleStatsPlayer

    def test_handles_missing_contested_shots_2pt
      assert_missing_key_returns_nil("CONTESTED_SHOTS_2PT", :contested_shots_2pt)
    end

    def test_handles_missing_contested_shots_3pt
      assert_missing_key_returns_nil("CONTESTED_SHOTS_3PT", :contested_shots_3pt)
    end

    def test_handles_missing_charges_drawn
      assert_missing_key_returns_nil("CHARGES_DRAWN", :charges_drawn)
    end

    def test_handles_missing_screen_assists
      assert_missing_key_returns_nil("SCREEN_ASSISTS", :screen_assists)
    end

    def test_handles_missing_screen_ast_pts
      assert_missing_key_returns_nil("SCREEN_AST_PTS", :screen_ast_pts)
    end

    def test_handles_missing_off_loose_balls_recovered
      assert_missing_key_returns_nil("OFF_LOOSE_BALLS_RECOVERED", :off_loose_balls_recovered)
    end

    def test_handles_missing_def_loose_balls_recovered
      assert_missing_key_returns_nil("DEF_LOOSE_BALLS_RECOVERED", :def_loose_balls_recovered)
    end

    def test_handles_missing_pct_loose_balls_recovered_off
      assert_missing_key_returns_nil("PCT_LOOSE_BALLS_RECOVERED_OFF", :pct_loose_balls_recovered_off)
    end

    def test_handles_missing_pct_loose_balls_recovered_def
      assert_missing_key_returns_nil("PCT_LOOSE_BALLS_RECOVERED_DEF", :pct_loose_balls_recovered_def)
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
