require_relative "../../test_helper"
require_relative "draft_combine_player_anthro_test_helper"

module NBA
  class DraftCombinePlayerAnthroAllTest < Minitest::Test
    include DraftCombinePlayerAnthroTestHelper

    cover DraftCombinePlayerAnthro

    def test_all_returns_collection
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      result = DraftCombinePlayerAnthro.all(season: 2019)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      DraftCombinePlayerAnthro.all(season: 2019)

      assert_requested :get, /SeasonYear=2019/
    end

    def test_all_uses_correct_league_in_path
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      DraftCombinePlayerAnthro.all(season: 2019, league: "10")

      assert_requested :get, /LeagueID=10/
    end

    def test_all_uses_default_league_when_not_specified
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      DraftCombinePlayerAnthro.all(season: 2019)

      assert_requested :get, /LeagueID=00/
    end

    def test_all_parses_measurements_successfully
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      measurements = DraftCombinePlayerAnthro.all(season: 2019)

      assert_equal 1, measurements.size
      assert_equal 1_630_162, measurements.first.player_id
      assert_equal "Victor Wembanyama", measurements.first.player_name
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, response.to_json, [String]

      DraftCombinePlayerAnthro.all(season: 2019, client: mock_client)

      mock_client.verify
    end

    def test_all_accepts_league_object
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)
      league = League.new(id: "10")

      DraftCombinePlayerAnthro.all(season: 2019, league: league)

      assert_requested :get, /LeagueID=10/
    end

    private

    def response
      {resultSets: [{name: "Results", headers: HEADERS, rowSet: [ROW]}]}
    end
  end
end
