require_relative "../../test_helper"

module NBA
  class BoxScoreDefensiveV2PlayerAttributeMappingTest < Minitest::Test
    cover BoxScoreDefensiveV2

    def test_maps_team_attributes
      stub_defensive_request
      stat = BoxScoreDefensiveV2.player_stats(game: "0022400001").first

      assert_equal Team::GSW, stat.team_id
      assert_equal "Golden State", stat.team_city
      assert_equal "Warriors", stat.team_name
      assert_equal "GSW", stat.team_tricode
      assert_equal "warriors", stat.team_slug
    end

    def test_maps_player_identity_attributes
      stub_defensive_request
      stat = BoxScoreDefensiveV2.player_stats(game: "0022400001").first

      assert_equal 201_939, stat.person_id
      assert_equal "Stephen", stat.first_name
      assert_equal "Curry", stat.family_name
      assert_equal "S. Curry", stat.name_i
      assert_equal "stephen-curry", stat.player_slug
    end

    def test_maps_player_game_attributes
      stub_defensive_request
      stat = BoxScoreDefensiveV2.player_stats(game: "0022400001").first

      assert_equal "G", stat.position
      assert_equal "DNP - Injury", stat.comment
      assert_equal "30", stat.jersey_num
    end

    def test_maps_matchup_minutes_and_possessions
      stub_defensive_request
      stat = BoxScoreDefensiveV2.player_stats(game: "0022400001").first

      assert_in_delta 24.5, stat.matchup_minutes, 0.01
      assert_in_delta 15.2, stat.partial_possessions, 0.01
      assert_equal 8, stat.switches_on
    end

    def test_maps_defensive_counting_stats
      stub_defensive_request
      stat = BoxScoreDefensiveV2.player_stats(game: "0022400001").first

      assert_equal 12, stat.player_points
      assert_equal 5, stat.defensive_rebounds
      assert_equal 3, stat.matchup_assists
      assert_equal 2, stat.matchup_turnovers
      assert_equal 2, stat.steals
    end

    def test_maps_blocks
      stub_defensive_request
      stat = BoxScoreDefensiveV2.player_stats(game: "0022400001").first

      assert_equal 1, stat.blocks
    end

    def test_maps_field_goal_shooting_stats
      stub_defensive_request
      stat = BoxScoreDefensiveV2.player_stats(game: "0022400001").first

      assert_equal 5, stat.matchup_field_goals_made
      assert_equal 12, stat.matchup_field_goals_attempted
      assert_in_delta 0.417, stat.matchup_field_goal_percentage, 0.001
    end

    def test_maps_three_pointer_shooting_stats
      stub_defensive_request
      stat = BoxScoreDefensiveV2.player_stats(game: "0022400001").first

      assert_equal 2, stat.matchup_three_pointers_made
      assert_equal 5, stat.matchup_three_pointers_attempted
      assert_in_delta 0.4, stat.matchup_three_pointer_percentage, 0.01
    end

    private

    def stub_defensive_request
      stub_request(:get, /boxscoredefensivev2/).to_return(body: player_stats_response.to_json)
    end

    def player_stats_response
      {resultSets: [{name: "PlayerStats", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_headers
      %w[gameId teamId teamCity teamName teamTricode teamSlug personId firstName familyName
        nameI playerSlug position comment jerseyNum matchupMinutes partialPossessions
        switchesOn playerPoints defensiveRebounds matchupAssists matchupTurnovers steals
        blocks matchupFieldGoalsMade matchupFieldGoalsAttempted matchupFieldGoalPercentage
        matchupThreePointersMade matchupThreePointersAttempted matchupThreePointerPercentage]
    end

    def player_row
      ["0022400001", Team::GSW, "Golden State", "Warriors", "GSW", "warriors", 201_939,
        "Stephen", "Curry", "S. Curry", "stephen-curry", "G", "DNP - Injury", "30", 24.5, 15.2, 8,
        12, 5, 3, 2, 2, 1, 5, 12, 0.417, 2, 5, 0.4]
    end
  end
end
