require_relative "../test_helper"

module NBA
  class StandingsAllTest < Minitest::Test
    cover Standings

    def test_all_returns_collection
      stub_standings_request

      assert_instance_of Collection, Standings.all
    end

    def test_all_parses_team_info
      stub_standings_request

      standing = Standings.all.first

      assert_equal Team::GSW, standing.team_id
      assert_equal "Golden State Warriors", standing.team_name
      assert_equal "West", standing.conference
      assert_equal "Pacific", standing.division
    end

    def test_all_parses_record
      stub_standings_request

      standing = Standings.all.first

      assert_equal 45, standing.wins
      assert_equal 30, standing.losses
      assert_in_delta 0.600, standing.win_pct
    end

    def test_all_parses_standings_details
      stub_standings_request

      standing = Standings.all.first

      assert_equal "25-12", standing.home_record
      assert_equal "20-18", standing.road_record
      assert_equal "W3", standing.streak
    end

    def test_all_with_custom_season
      stub_request(:get, /leaguestandings.*Season=2023-24/).to_return(body: standings_response.to_json)

      Standings.all(season: 2023)

      assert_requested :get, /leaguestandings.*Season=2023-24/
    end

    def test_all_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, Standings.all(client: mock_client).size
      mock_client.verify
    end

    def test_all_returns_empty_collection_when_no_result_sets
      stub_request(:get, /leaguestandings/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, Standings.all.size
    end

    def test_all_returns_empty_collection_when_no_headers
      stub_request(:get, /leaguestandings/).to_return(body: {resultSets: [{headers: nil, rowSet: [["data"]]}]}.to_json)

      assert_equal 0, Standings.all.size
    end

    def test_all_returns_empty_collection_when_no_rows
      stub_request(:get, /leaguestandings/).to_return(body: {resultSets: [{headers: %w[TeamID], rowSet: nil}]}.to_json)

      assert_equal 0, Standings.all.size
    end

    private

    def stub_standings_request
      stub_request(:get, /leaguestandings/).to_return(body: standings_response.to_json)
    end

    def standings_response
      {resultSets: [{headers: standings_headers, rowSet: [standings_row]}]}
    end

    def standings_headers = %w[TeamID TeamName Conference Division WINS LOSSES WinPCT PlayoffRank HOME ROAD strCurrentStreak]

    def standings_row = [Team::GSW, "Golden State Warriors", "West", "Pacific", 45, 30, 0.600, 5, "25-12", "20-18", "W3"]
  end

  class StandingsConferenceTest < Minitest::Test
    cover Standings

    def test_conference_filters_by_conference
      stub_standings_request

      western = Standings.conference("West")

      assert_instance_of Collection, western
      refute_empty western
      assert(western.all? { |s| s.conference.eql?("West") })
    end

    def test_conference_returns_empty_for_unknown
      stub_standings_request

      assert_equal 0, Standings.conference("Unknown").size
    end

    def test_conference_passes_season_to_all
      stub_request(:get, /leaguestandings.*Season=2022-23/).to_return(body: standings_response.to_json)

      Standings.conference("West", season: 2022)

      assert_requested :get, /leaguestandings.*Season=2022-23/
    end

    def test_conference_passes_client_to_all
      custom_client = Minitest::Mock.new
      custom_client.expect :get, standings_response.to_json, [String]

      Standings.conference("West", client: custom_client)

      custom_client.verify
    end

    private

    def stub_standings_request
      stub_request(:get, /leaguestandings/).to_return(body: standings_response.to_json)
    end

    def standings_response
      {resultSets: [{headers: standings_headers, rowSet: [standings_row]}]}
    end

    def standings_headers = %w[TeamID TeamName Conference Division WINS LOSSES WinPCT PlayoffRank HOME ROAD strCurrentStreak]

    def standings_row = [Team::GSW, "Golden State Warriors", "West", "Pacific", 45, 30, 0.600, 5, "25-12", "20-18", "W3"]
  end

  class StandingsStreakTest < Minitest::Test
    cover Standings

    def test_format_streak_handles_nil
      stub_standings_with(streak: nil)

      assert_nil Standings.all.first.streak
    end

    def test_format_streak_converts_integer_to_string
      stub_standings_with(streak: 5)

      streak = Standings.all.first.streak

      assert_instance_of String, streak
      assert_equal "5", streak
    end

    def test_format_streak_returns_string_representation
      stub_standings_with(streak: "W5")

      streak = Standings.all.first.streak

      assert_equal "W5", streak
      assert_instance_of String, streak
    end

    private

    def stub_standings_with(streak:)
      headers = standings_headers
      row = [Team::GSW, "Golden State Warriors", "West", "Pacific", 45, 30, 0.600, 5, "25-12", "20-18", streak]
      stub_request(:get, /leaguestandings/).to_return(body: {resultSets: [{headers: headers, rowSet: [row]}]}.to_json)
    end

    def standings_headers = %w[TeamID TeamName Conference Division WINS LOSSES WinPCT PlayoffRank HOME ROAD strCurrentStreak]
  end

  class StandingsConferenceRankTest < Minitest::Test
    cover Standings

    def test_parse_conference_rank_uses_conference_record
      stub_standings_with(conference_record: "10-5")

      assert_equal 10, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_uses_playoff_rank_when_no_conference_record
      stub_standings_with(conference_record: nil)

      assert_equal 5, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_uses_playoff_rank_when_empty_split
      stub_standings_with(conference_record: "")

      assert_equal 5, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_handles_integer_conference_record
      stub_standings_with(conference_record: 10)

      assert_equal 10, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_returns_integer
      stub_standings_with(conference_record: "8-5")

      assert_instance_of Integer, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_parses_wins_not_losses
      stub_standings_with(conference_record: "7-10")

      assert_equal 7, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_splits_on_hyphen
      stub_standings_with(conference_record: "12-8")

      assert_equal 12, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_handles_malformed_record
      stub_standings_with(conference_record: "-")

      assert_equal 5, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_handles_leading_hyphen
      stub_standings_with(conference_record: "-5")

      assert_equal 5, Standings.all.first.conference_rank
    end

    def test_conference_rank_is_integer_type
      stub_standings_with(conference_record: "10-5")

      assert_instance_of Integer, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_returns_integer_directly
      result = Standings.send(:parse_conference_rank, "10-5", 1)

      assert_instance_of Integer, result
    end

    def test_parse_conference_rank_converts_string_wins_to_integer
      result = Standings.send(:parse_conference_rank, "7-3", 1)

      assert_equal 7, result
      refute_equal "7", result
    end

    def test_parse_conference_rank_handles_wins_with_trailing_chars
      result = Standings.send(:parse_conference_rank, "10W-5", 1)

      assert_equal 10, result
    end

    private

    def stub_standings_with(conference_record:)
      headers = standings_headers
      row = [Team::GSW, "Golden State Warriors", "West", "Pacific", 45, 30, 0.600, 5, "25-12", "20-18", "W3"]
      unless conference_record == :default
        headers += ["ConferenceRecord"]
        row += [conference_record]
      end
      stub_request(:get, /leaguestandings/).to_return(body: {resultSets: [{headers: headers, rowSet: [row]}]}.to_json)
    end

    def standings_headers = %w[TeamID TeamName Conference Division WINS LOSSES WinPCT PlayoffRank HOME ROAD strCurrentStreak]
  end

  class StandingsResultSetTest < Minitest::Test
    cover Standings

    def test_standings_uses_first_result_set
      response = {resultSets: [first_result_set, {headers: %w[OTHER], rowSet: [["other"]]}]}
      stub_request(:get, /leaguestandings/).to_return(body: response.to_json)

      standing = Standings.all.first

      assert_equal "Golden State Warriors", standing.team_name
    end

    private

    def first_result_set
      {headers: standings_headers, rowSet: [[Team::GSW, "Golden State Warriors", "West", "Pacific", 45, 30, 0.600, 5, "25-12", "20-18", "W3"]]}
    end

    def standings_headers = %w[TeamID TeamName Conference Division WINS LOSSES WinPCT PlayoffRank HOME ROAD strCurrentStreak]
  end
end
