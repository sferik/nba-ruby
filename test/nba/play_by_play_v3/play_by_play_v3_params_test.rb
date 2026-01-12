require_relative "../../test_helper"

module NBA
  class PlayByPlayV3ParamsTest < Minitest::Test
    cover PlayByPlayV3

    def test_find_with_start_period
      stub_request(:get, /playbyplayv3.*StartPeriod=2/)
        .to_return(body: play_by_play_v3_response.to_json)

      PlayByPlayV3.find(game: "0022400001", start_period: 2)

      assert_requested :get, /playbyplayv3.*StartPeriod=2/
    end

    def test_find_with_end_period
      stub_request(:get, /playbyplayv3.*EndPeriod=4/)
        .to_return(body: play_by_play_v3_response.to_json)

      PlayByPlayV3.find(game: "0022400001", end_period: 4)

      assert_requested :get, /playbyplayv3.*EndPeriod=4/
    end

    def test_find_default_start_period_is_zero
      stub_request(:get, /playbyplayv3.*StartPeriod=0/)
        .to_return(body: play_by_play_v3_response.to_json)

      PlayByPlayV3.find(game: "0022400001")

      assert_requested :get, /playbyplayv3.*StartPeriod=0/
    end

    def test_find_default_end_period_is_fourteen
      stub_request(:get, /playbyplayv3.*EndPeriod=14/)
        .to_return(body: play_by_play_v3_response.to_json)

      PlayByPlayV3.find(game: "0022400001")

      assert_requested :get, /playbyplayv3.*EndPeriod=14/
    end

    def test_find_with_game_object
      game = Game.new(id: "0022400001")
      stub_request(:get, /playbyplayv3.*GameID=0022400001/)
        .to_return(body: play_by_play_v3_response.to_json)

      PlayByPlayV3.find(game: game)

      assert_requested :get, /playbyplayv3.*GameID=0022400001/
    end

    private

    def play_by_play_v3_response
      headers = %w[GAME_ID EVENTNUM EVENTMSGTYPE EVENTMSGACTIONTYPE PERIOD]
      row = ["0022400001", 1, 12, 0, 1]
      {resultSets: [{name: "PlayByPlay", headers: headers, rowSet: [row]}]}
    end
  end
end
