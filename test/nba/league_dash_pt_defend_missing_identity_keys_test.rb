require_relative "../test_helper"

module NBA
  class LeagueDashPtDefendMissingIdentityKeysTest < Minitest::Test
    cover LeagueDashPtDefend

    def test_handles_missing_player_id
      assert_missing_key_returns_nil("CLOSE_DEF_PERSON_ID", 0, :player_id)
    end

    def test_handles_missing_player_name
      assert_missing_key_returns_nil("PLAYER_NAME", 1, :player_name)
    end

    def test_handles_missing_team_id
      assert_missing_key_returns_nil("PLAYER_LAST_TEAM_ID", 2, :team_id)
    end

    def test_handles_missing_team_abbreviation
      assert_missing_key_returns_nil("PLAYER_LAST_TEAM_ABBREVIATION", 3, :team_abbreviation)
    end

    def test_handles_missing_player_position
      assert_missing_key_returns_nil("PLAYER_POSITION", 4, :player_position)
    end

    def test_handles_missing_age
      assert_missing_key_returns_nil("AGE", 5, :age)
    end

    def test_handles_missing_gp
      assert_missing_key_returns_nil("GP", 6, :gp)
    end

    def test_handles_missing_g
      assert_missing_key_returns_nil("G", 7, :g)
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
