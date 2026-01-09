require_relative "../test_helper"

module NBA
  class CumeStatsPlayerGamesMissingKeysTest < Minitest::Test
    cover CumeStatsPlayerGames

    def test_handles_missing_game_id_key
      stub_request(:get, /cumestatsplayergames/).to_return(body: response_without("GAME_ID").to_json)

      entry = CumeStatsPlayerGames.all(player: 201_939, season: 2024).first

      assert_nil entry.game_id
    end

    def test_handles_missing_matchup_key
      stub_request(:get, /cumestatsplayergames/).to_return(body: response_without("MATCHUP").to_json)

      entry = CumeStatsPlayerGames.all(player: 201_939, season: 2024).first

      assert_nil entry.matchup
    end

    private

    def all_headers
      %w[MATCHUP GAME_ID]
    end

    def all_values
      ["GSW vs. LAL", "0022400001"]
    end

    def response_without(key)
      index = all_headers.index(key)
      headers = all_headers.reject { |h| h.eql?(key) }
      values = all_values.reject.with_index { |_, i| i.eql?(index) }
      {resultSets: [{name: "CumeStatsPlayerGames", headers: headers, rowSet: [values]}]}
    end
  end
end
