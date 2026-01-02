require_relative "../test_helper"

module NBA
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
end
