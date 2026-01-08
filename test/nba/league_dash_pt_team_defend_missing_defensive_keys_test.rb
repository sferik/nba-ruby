require_relative "../test_helper"

module NBA
  class LeagueDashPtTeamDefendMissingDefensiveKeysTest < Minitest::Test
    cover LeagueDashPtTeamDefend

    def test_handles_missing_freq
      assert_missing_key_returns_nil("FREQ", 5, :freq)
    end

    def test_handles_missing_d_fgm
      assert_missing_key_returns_nil("D_FGM", 6, :d_fgm)
    end

    def test_handles_missing_d_fga
      assert_missing_key_returns_nil("D_FGA", 7, :d_fga)
    end

    def test_handles_missing_d_fg_pct
      assert_missing_key_returns_nil("D_FG_PCT", 8, :d_fg_pct)
    end

    def test_handles_missing_normal_fg_pct
      assert_missing_key_returns_nil("NORMAL_FG_PCT", 9, :normal_fg_pct)
    end

    def test_handles_missing_pct_plusminus
      assert_missing_key_returns_nil("PCT_PLUSMINUS", 10, :pct_plusminus)
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
