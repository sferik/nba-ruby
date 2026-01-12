require_relative "../../test_helper"

module NBA
  class LeagueDashPtDefendMissingDefensiveKeysTest < Minitest::Test
    cover LeagueDashPtDefend

    def test_handles_missing_freq
      assert_missing_key_returns_nil("FREQ", 8, :freq)
    end

    def test_handles_missing_d_fgm
      assert_missing_key_returns_nil("D_FGM", 9, :d_fgm)
    end

    def test_handles_missing_d_fga
      assert_missing_key_returns_nil("D_FGA", 10, :d_fga)
    end

    def test_handles_missing_d_fg_pct
      assert_missing_key_returns_nil("D_FG_PCT", 11, :d_fg_pct)
    end

    def test_handles_missing_normal_fg_pct
      assert_missing_key_returns_nil("NORMAL_FG_PCT", 12, :normal_fg_pct)
    end

    def test_handles_missing_pct_plusminus
      assert_missing_key_returns_nil("PCT_PLUSMINUS", 13, :pct_plusminus)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers.reject { |h| h == key }
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "LeagueDashPTDefend", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguedashptdefend/).to_return(body: response.to_json)

      stat = LeagueDashPtDefend.all(season: 2024).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def stat_headers
      %w[CLOSE_DEF_PERSON_ID PLAYER_NAME PLAYER_LAST_TEAM_ID PLAYER_LAST_TEAM_ABBREVIATION
        PLAYER_POSITION AGE GP G FREQ D_FGM D_FGA D_FG_PCT NORMAL_FG_PCT PCT_PLUSMINUS]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", "G", 36.0, 82, 82, 0.089,
        245.0, 612.0, 0.400, 0.450, -0.050]
    end
  end
end
