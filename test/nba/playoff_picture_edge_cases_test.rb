require_relative "../test_helper"

module NBA
  class PlayoffPictureEdgeCasesTest < Minitest::Test
    cover PlayoffPicture

    def test_all_handles_nil_response
      client = Minitest::Mock.new
      client.expect :get, nil, [String]

      result = PlayoffPicture.all(client: client)

      assert_instance_of Collection, result
      assert_empty result
      client.verify
    end

    def test_all_handles_empty_response
      stub_request(:get, /playoffpicture/).to_return(body: "")

      result = PlayoffPicture.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_result_sets
      stub_request(:get, /playoffpicture/).to_return(body: {}.to_json)

      result = PlayoffPicture.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_result_sets
      stub_request(:get, /playoffpicture/).to_return(body: {resultSets: []}.to_json)

      result = PlayoffPicture.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_only_east_conference
      response = {resultSets: [{name: "EastConfPlayoffPicture",
                                headers: %w[CONFERENCE HIGH_SEED_TEAM],
                                rowSet: [["East", "Boston Celtics"]]}]}
      stub_request(:get, /playoffpicture/).to_return(body: response.to_json)

      result = PlayoffPicture.all

      assert_equal 1, result.size
      assert_equal "East", result.first.conference
    end

    def test_all_handles_only_west_conference
      response = {resultSets: [{name: "WestConfPlayoffPicture",
                                headers: %w[CONFERENCE HIGH_SEED_TEAM],
                                rowSet: [["West", "Denver Nuggets"]]}]}
      stub_request(:get, /playoffpicture/).to_return(body: response.to_json)

      result = PlayoffPicture.all

      assert_equal 1, result.size
      assert_equal "West", result.first.conference
    end

    def test_all_handles_missing_headers
      response = {resultSets: [{name: "EastConfPlayoffPicture", rowSet: [%w[East Boston]]}]}
      stub_request(:get, /playoffpicture/).to_return(body: response.to_json)

      result = PlayoffPicture.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_row_set
      response = {resultSets: [{name: "EastConfPlayoffPicture", headers: %w[CONFERENCE HIGH_SEED_TEAM]}]}
      stub_request(:get, /playoffpicture/).to_return(body: response.to_json)

      result = PlayoffPicture.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_row_set
      response = {resultSets: [{name: "EastConfPlayoffPicture",
                                headers: %w[CONFERENCE HIGH_SEED_TEAM],
                                rowSet: []}]}
      stub_request(:get, /playoffpicture/).to_return(body: response.to_json)

      result = PlayoffPicture.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_parse_conference_finds_result_set_by_name
      response = {resultSets: [
        {name: "OtherResultSet", headers: %w[FOO], rowSet: [["bar"]]},
        {name: "EastConfPlayoffPicture", headers: all_headers, rowSet: [full_row]}
      ]}
      stub_request(:get, /playoffpicture/).to_return(body: response.to_json)

      result = PlayoffPicture.all

      assert_equal 1, result.size
      assert_equal "East", result.first.conference
    end

    private

    def all_headers
      %w[HIGH_SEED_RANK HIGH_SEED_TEAM HIGH_SEED_TEAM_ID LOW_SEED_RANK
        LOW_SEED_TEAM LOW_SEED_TEAM_ID HIGH_SEED_SERIES_W LOW_SEED_SERIES_W SERIES_STATUS]
    end

    def full_row
      [1, "Boston Celtics", Team::BOS, 8, "Miami Heat", Team::MIA, 4, 1, "Celtics lead 4-1"]
    end
  end
end
