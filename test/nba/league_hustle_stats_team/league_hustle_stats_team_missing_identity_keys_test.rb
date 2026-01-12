require_relative "../../test_helper"
require_relative "league_hustle_stats_team_test_helper"

module NBA
  class LeagueHustleStatsTeamMissingIdentityKeysTest < Minitest::Test
    include LeagueHustleStatsTeamTestHelper

    cover LeagueHustleStatsTeam

    def test_handles_missing_team_id
      assert_missing_key_returns_nil("TEAM_ID", :team_id)
    end

    def test_handles_missing_team_name
      assert_missing_key_returns_nil("TEAM_NAME", :team_name)
    end

    def test_handles_missing_minutes
      assert_missing_key_returns_nil("MIN", :min)
    end

    def test_handles_missing_contested_shots
      assert_missing_key_returns_nil("CONTESTED_SHOTS", :contested_shots)
    end

    def test_handles_missing_deflections
      assert_missing_key_returns_nil("DEFLECTIONS", :deflections)
    end

    def test_handles_missing_loose_balls_recovered
      assert_missing_key_returns_nil("LOOSE_BALLS_RECOVERED", :loose_balls_recovered)
    end

    def test_handles_missing_box_outs
      assert_missing_key_returns_nil("BOX_OUTS", :box_outs)
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
