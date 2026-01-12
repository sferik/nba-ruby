require_relative "../../test_helper"

module NBA
  class LiveBoxScoreTest < Minitest::Test
    cover LiveBoxScore

    def test_find_parses_player_identity
      stub_live_box_score_request

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.name
      assert_equal "Stephen", stat.first_name
      assert_equal "Curry", stat.family_name
    end

    def test_find_parses_player_position
      stub_live_box_score_request

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_equal "30", stat.jersey_num
      assert_equal "G", stat.position
    end

    def test_find_parses_team_data
      stub_live_box_score_request

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_equal 1_610_612_744, stat.team_id
      assert_equal "GSW", stat.team_tricode
    end

    def test_find_parses_basic_counting_stats
      stub_live_box_score_request

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_equal 32, stat.points
      assert_equal 5, stat.rebounds_total
      assert_equal 8, stat.assists
    end

    def test_find_parses_other_counting_stats
      stub_live_box_score_request

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_equal 2, stat.steals
      assert_equal 0, stat.blocks
      assert_equal 3, stat.turnovers
      assert_equal 2, stat.fouls_personal
      assert_in_delta 12.0, stat.plus_minus
    end

    def test_find_parses_rebound_stats
      stub_live_box_score_request

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_equal 1, stat.rebounds_offensive
      assert_equal 4, stat.rebounds_defensive
    end

    def test_find_parses_shooting_stats
      stub_live_box_score_request

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_equal 11, stat.field_goals_made
      assert_equal 22, stat.field_goals_attempted
      assert_in_delta 0.5, stat.field_goals_percentage
      assert_equal 6, stat.three_pointers_made
      assert_equal 12, stat.three_pointers_attempted
    end

    def test_find_parses_three_point_percentage
      stub_live_box_score_request

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_in_delta 0.5, stat.three_pointers_percentage
    end

    def test_find_parses_free_throw_stats
      stub_live_box_score_request

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_equal 4, stat.free_throws_made
      assert_equal 4, stat.free_throws_attempted
      assert_in_delta 1.0, stat.free_throws_percentage
    end

    private

    def stub_live_box_score_request
      response = {game: {homeTeam: home_team_data, awayTeam: away_team_data}}
      stub_request(:get, %r{boxscore/boxscore_0022400001.json}).to_return(body: response.to_json)
    end

    def home_team_data
      {teamId: 1_610_612_744, teamTricode: "GSW", players: [{
        personId: 201_939, name: "Stephen Curry", firstName: "Stephen", familyName: "Curry",
        jerseyNum: "30", position: "G", starter: "1", statistics: curry_stats
      }]}
    end

    def curry_stats
      {minutes: "PT36M15.00S", points: 32, reboundsTotal: 5, reboundsOffensive: 1,
       reboundsDefensive: 4, assists: 8, steals: 2, blocks: 0, turnovers: 3,
       foulsPersonal: 2, plusMinusPoints: 12.0, fieldGoalsMade: 11, fieldGoalsAttempted: 22,
       fieldGoalsPercentage: 0.5, threePointersMade: 6, threePointersAttempted: 12,
       threePointersPercentage: 0.5, freeThrowsMade: 4, freeThrowsAttempted: 4, freeThrowsPercentage: 1.0}
    end

    def away_team_data
      {teamId: 1_610_612_747, teamTricode: "LAL", players: [{
        personId: 2544, name: "LeBron James", firstName: "LeBron", familyName: "James",
        jerseyNum: "23", position: "F", starter: "1",
        statistics: {minutes: "PT38M00.00S", points: 28, reboundsTotal: 10, assists: 12}
      }]}
    end
  end
end
