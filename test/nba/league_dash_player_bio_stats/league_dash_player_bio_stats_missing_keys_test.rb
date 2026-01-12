require_relative "../../test_helper"

module NBA
  class LeagueDashPlayerBioStatsMissingKeysTest < Minitest::Test
    cover LeagueDashPlayerBioStats

    def test_handles_missing_player_id
      assert_missing_key_returns_nil("PLAYER_ID", 0, :player_id)
    end

    def test_handles_missing_player_name
      assert_missing_key_returns_nil("PLAYER_NAME", 1, :player_name)
    end

    def test_handles_missing_team_id
      assert_missing_key_returns_nil("TEAM_ID", 2, :team_id)
    end

    def test_handles_missing_team_abbreviation
      assert_missing_key_returns_nil("TEAM_ABBREVIATION", 3, :team_abbreviation)
    end

    def test_handles_missing_age
      assert_missing_key_returns_nil("AGE", 4, :age)
    end

    def test_handles_missing_player_height
      assert_missing_key_returns_nil("PLAYER_HEIGHT", 5, :player_height)
    end

    def test_handles_missing_player_height_inches
      assert_missing_key_returns_nil("PLAYER_HEIGHT_INCHES", 6, :player_height_inches)
    end

    def test_handles_missing_player_weight
      assert_missing_key_returns_nil("PLAYER_WEIGHT", 7, :player_weight)
    end

    def test_handles_missing_college
      assert_missing_key_returns_nil("COLLEGE", 8, :college)
    end

    def test_handles_missing_country
      assert_missing_key_returns_nil("COUNTRY", 9, :country)
    end

    def test_handles_missing_draft_year
      assert_missing_key_returns_nil("DRAFT_YEAR", 10, :draft_year)
    end

    def test_handles_missing_draft_round
      assert_missing_key_returns_nil("DRAFT_ROUND", 11, :draft_round)
    end

    def test_handles_missing_draft_number
      assert_missing_key_returns_nil("DRAFT_NUMBER", 12, :draft_number)
    end

    def test_handles_missing_gp
      assert_missing_key_returns_nil("GP", 13, :gp)
    end

    def test_handles_missing_pts
      assert_missing_key_returns_nil("PTS", 14, :pts)
    end

    def test_handles_missing_reb
      assert_missing_key_returns_nil("REB", 15, :reb)
    end

    def test_handles_missing_ast
      assert_missing_key_returns_nil("AST", 16, :ast)
    end

    def test_handles_missing_net_rating
      assert_missing_key_returns_nil("NET_RATING", 17, :net_rating)
    end

    def test_handles_missing_oreb_pct
      assert_missing_key_returns_nil("OREB_PCT", 18, :oreb_pct)
    end

    def test_handles_missing_dreb_pct
      assert_missing_key_returns_nil("DREB_PCT", 19, :dreb_pct)
    end

    def test_handles_missing_usg_pct
      assert_missing_key_returns_nil("USG_PCT", 20, :usg_pct)
    end

    def test_handles_missing_ts_pct
      assert_missing_key_returns_nil("TS_PCT", 21, :ts_pct)
    end

    def test_handles_missing_ast_pct
      assert_missing_key_returns_nil("AST_PCT", 22, :ast_pct)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers.reject { |h| h == key }
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "LeagueDashPlayerBioStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguedashplayerbiostats/).to_return(body: response.to_json)

      stat = LeagueDashPlayerBioStats.all(season: 2024).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def stat_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE PLAYER_HEIGHT PLAYER_HEIGHT_INCHES
        PLAYER_WEIGHT COLLEGE COUNTRY DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER GP PTS REB AST
        NET_RATING OREB_PCT DREB_PCT USG_PCT TS_PCT AST_PCT]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36.0, "6-2", 74, 185, "Davidson", "USA",
        "2009", "1", "7", 74, 26.4, 5.2, 6.1, 8.5, 0.025, 0.112, 0.298, 0.621, 0.312]
    end
  end
end
