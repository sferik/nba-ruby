require_relative "../test_helper"

module NBA
  class PlayerGameLogFindSeasonTest < Minitest::Test
    cover PlayerGameLog

    def test_find_with_custom_season
      stub_request(:get, /playergamelog.*Season=2023-24/).to_return(body: game_log_response.to_json)

      PlayerGameLog.find(player: 201_939, season: 2023)

      assert_requested :get, /playergamelog.*Season=2023-24/
    end

    def test_find_default_season_type_is_regular_season
      stub_request(:get, /playergamelog.*SeasonType=Regular%20Season/).to_return(body: game_log_response.to_json)

      PlayerGameLog.find(player: 201_939)

      assert_requested :get, /playergamelog.*SeasonType=Regular%20Season/
    end

    def test_find_with_playoffs_season_type
      stub_request(:get, /playergamelog.*SeasonType=Playoffs/).to_return(body: game_log_response.to_json)

      PlayerGameLog.find(player: 201_939, season_type: PlayerGameLog::PLAYOFFS)

      assert_requested :get, /playergamelog.*SeasonType=Playoffs/
    end

    def test_find_uses_two_digit_ending_year_in_season_format
      stub_request(:get, /playergamelog.*Season=2019-20/).to_return(body: game_log_response.to_json)

      PlayerGameLog.find(player: 201_939, season: 2019)

      assert_requested :get, /playergamelog.*Season=2019-20/
    end

    private

    def game_log_response = {resultSets: [{headers: %w[SEASON_ID], rowSet: [["22024"]]}]}
  end
end
