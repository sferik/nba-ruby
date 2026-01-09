require_relative "../test_helper"

module NBA
  class CumeStatsTeamGamesMissingKeysTest < Minitest::Test
    cover CumeStatsTeamGames

    HEADERS = %w[MATCHUP GAME_ID].freeze
    ROW = ["LAL @ DEN", 22_300_001].freeze

    def test_handles_missing_matchup_key
      stub_with_headers_except("MATCHUP")

      assert_nil CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023).first.matchup
    end

    def test_handles_missing_game_id_key
      stub_with_headers_except("GAME_ID")

      assert_nil CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023).first.game_id
    end

    private

    def stub_with_headers_except(key)
      headers = HEADERS.reject { |h| h == key }
      row = headers.map { |h| ROW[HEADERS.index(h)] }
      response = {resultSets: [{name: "CumeStatsTeamGames", headers: headers, rowSet: [row]}]}
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)
    end
  end
end
