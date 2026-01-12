require_relative "../../test_helper"

module NBA
  class DraftCombineNonStationaryShootingAllTest < Minitest::Test
    cover DraftCombineNonStationaryShooting

    HEADERS = %w[
      TEMP_PLAYER_ID PLAYER_ID PLAYER_NAME FIRST_NAME LAST_NAME POSITION
      OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_MADE OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_ATTEMPT
      OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_PCT
    ].freeze

    ROW = [1, 1_630_162, "Victor Wembanyama", "Victor", "Wembanyama", "C", 3, 5, 0.6].freeze

    def test_all_returns_collection
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      result = DraftCombineNonStationaryShooting.all(season: 2019)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      DraftCombineNonStationaryShooting.all(season: 2019)

      assert_requested :get, /SeasonYear=2019/
    end

    def test_all_uses_correct_league_in_path
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      DraftCombineNonStationaryShooting.all(season: 2019, league: "10")

      assert_requested :get, /LeagueID=10/
    end

    def test_all_uses_default_league_when_not_specified
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      DraftCombineNonStationaryShooting.all(season: 2019)

      assert_requested :get, /LeagueID=00/
    end

    def test_all_parses_results_successfully
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      results = DraftCombineNonStationaryShooting.all(season: 2019)

      assert_equal 1, results.size
      assert_equal 1_630_162, results.first.player_id
      assert_equal "Victor Wembanyama", results.first.player_name
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, response.to_json, [String]

      DraftCombineNonStationaryShooting.all(season: 2019, client: mock_client)

      mock_client.verify
    end

    def test_all_accepts_league_object
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)
      league = League.new(id: "10")

      DraftCombineNonStationaryShooting.all(season: 2019, league: league)

      assert_requested :get, /LeagueID=10/
    end

    private

    def response
      {resultSets: [{name: "Results", headers: HEADERS, rowSet: [ROW]}]}
    end
  end
end
