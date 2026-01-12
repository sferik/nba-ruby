require_relative "../../test_helper"

module NBA
  class LeagueDashPlayerBioStatsAttributeMappingTest < Minitest::Test
    cover LeagueDashPlayerBioStats

    def test_maps_player_id
      stub_bio_stats_request

      assert_equal 201_939, stat.player_id
    end

    def test_maps_player_name
      stub_bio_stats_request

      assert_equal "Stephen Curry", stat.player_name
    end

    def test_maps_team_id
      stub_bio_stats_request

      assert_equal Team::GSW, stat.team_id
    end

    def test_maps_team_abbreviation
      stub_bio_stats_request

      assert_equal "GSW", stat.team_abbreviation
    end

    def test_maps_age
      stub_bio_stats_request

      assert_in_delta 36.0, stat.age
    end

    def test_maps_player_height
      stub_bio_stats_request

      assert_equal "6-2", stat.player_height
    end

    def test_maps_player_height_inches
      stub_bio_stats_request

      assert_equal 74, stat.player_height_inches
    end

    def test_maps_player_weight
      stub_bio_stats_request

      assert_equal 185, stat.player_weight
    end

    def test_maps_college
      stub_bio_stats_request

      assert_equal "Davidson", stat.college
    end

    def test_maps_country
      stub_bio_stats_request

      assert_equal "USA", stat.country
    end

    def test_maps_draft_year
      stub_bio_stats_request

      assert_equal "2009", stat.draft_year
    end

    def test_maps_draft_round
      stub_bio_stats_request

      assert_equal "1", stat.draft_round
    end

    def test_maps_draft_number
      stub_bio_stats_request

      assert_equal "7", stat.draft_number
    end

    private

    def stat
      LeagueDashPlayerBioStats.all(season: 2024).first
    end

    def stub_bio_stats_request
      stub_request(:get, /leaguedashplayerbiostats/).to_return(body: bio_stats_response.to_json)
    end

    def bio_stats_response
      {resultSets: [{name: "LeagueDashPlayerBioStats", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE PLAYER_HEIGHT PLAYER_HEIGHT_INCHES
        PLAYER_WEIGHT COLLEGE COUNTRY DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER GP PTS REB AST
        NET_RATING OREB_PCT DREB_PCT USG_PCT TS_PCT AST_PCT]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36.0, "6-2", 74, 185, "Davidson", "USA",
        "2009", "1", "7", 74, 26.4, 5.2, 6.1, 8.5, 0.025, 0.112, 0.298, 0.621, 0.312]
    end
  end
end
