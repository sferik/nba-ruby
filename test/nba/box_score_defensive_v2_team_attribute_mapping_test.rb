require_relative "../test_helper"

module NBA
  class BoxScoreDefensiveV2TeamAttributeMappingTest < Minitest::Test
    cover BoxScoreDefensiveV2

    def test_maps_team_identity_attributes
      stub_defensive_request
      stat = BoxScoreDefensiveV2.team_stats(game: "0022400001").first

      assert_equal Team::GSW, stat.team_id
      assert_equal "Golden State", stat.team_city
      assert_equal "Warriors", stat.team_name
      assert_equal "GSW", stat.team_tricode
      assert_equal "warriors", stat.team_slug
    end

    def test_maps_team_game_attributes
      stub_defensive_request
      stat = BoxScoreDefensiveV2.team_stats(game: "0022400001").first

      assert_equal "240:00", stat.minutes
    end

    private

    def stub_defensive_request
      stub_request(:get, /boxscoredefensivev2/).to_return(body: team_stats_response.to_json)
    end

    def team_stats_response
      {resultSets: [{name: "TeamStats", headers: team_headers, rowSet: [team_row]}]}
    end

    def team_headers
      %w[gameId teamId teamCity teamName teamTricode teamSlug minutes]
    end

    def team_row
      ["0022400001", Team::GSW, "Golden State", "Warriors", "GSW", "warriors", "240:00"]
    end
  end
end
