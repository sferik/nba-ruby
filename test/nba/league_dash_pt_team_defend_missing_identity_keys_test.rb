require_relative "../test_helper"

module NBA
  class LeagueDashPtTeamDefendMissingIdentityKeysTest < Minitest::Test
    cover LeagueDashPtTeamDefend

    def test_handles_missing_team_id
      assert_missing_key_returns_nil("TEAM_ID", 0, :team_id)
    end

    def test_handles_missing_team_name
      assert_missing_key_returns_nil("TEAM_NAME", 1, :team_name)
    end

    def test_handles_missing_team_abbreviation
      assert_missing_key_returns_nil("TEAM_ABBREVIATION", 2, :team_abbreviation)
    end

    def test_handles_missing_gp
      assert_missing_key_returns_nil("GP", 3, :gp)
    end

    def test_handles_missing_g
      assert_missing_key_returns_nil("G", 4, :g)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers.reject { |h| h == key }
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "LeagueDashPtTeamDefend", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguedashptteamdefend/).to_return(body: response.to_json)

      stat = LeagueDashPtTeamDefend.all(season: 2024).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def stat_headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION GP G FREQ D_FGM D_FGA D_FG_PCT NORMAL_FG_PCT PCT_PLUSMINUS]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors", "GSW", 82, 82, 0.089,
        245.0, 612.0, 0.400, 0.450, -0.050]
    end
  end
end
