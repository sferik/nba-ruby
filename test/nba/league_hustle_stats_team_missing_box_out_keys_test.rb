require_relative "../test_helper"
require_relative "league_hustle_stats_team_test_helper"

module NBA
  class LeagueHustleStatsTeamMissingBoxOutKeysTest < Minitest::Test
    include LeagueHustleStatsTeamTestHelper

    cover LeagueHustleStatsTeam

    def test_handles_missing_off_boxouts
      assert_missing_key_returns_nil("OFF_BOXOUTS", :off_boxouts)
    end

    def test_handles_missing_def_boxouts
      assert_missing_key_returns_nil("DEF_BOXOUTS", :def_boxouts)
    end

    def test_handles_missing_pct_box_outs_off
      assert_missing_key_returns_nil("PCT_BOX_OUTS_OFF", :pct_box_outs_off)
    end

    def test_handles_missing_pct_box_outs_def
      assert_missing_key_returns_nil("PCT_BOX_OUTS_DEF", :pct_box_outs_def)
    end

    private

    def assert_missing_key_returns_nil(key, attribute)
      response = build_response_without_key(key)
      stub_request(:get, /leaguehustlestatsteam/).to_return(body: response.to_json)

      stat = LeagueHustleStatsTeam.all(season: 2024).first

      assert_nil stat.send(attribute)
    end
  end
end
