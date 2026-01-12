require_relative "../../test_helper"
require_relative "../box_score/box_score_v3_test_helpers"

module NBA
  class BoxScoreFourFactorsV3Test < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreFourFactorsV3

    def test_player_stats_returns_collection
      stub_four_factors_v3_request

      assert_instance_of Collection, BoxScoreFourFactorsV3.player_stats(game: "0022400001")
    end

    def test_player_stats_parses_identity_attributes
      stub_four_factors_v3_request

      stat = BoxScoreFourFactorsV3.player_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
    end

    def test_player_stats_parses_four_factors
      stub_four_factors_v3_request

      stat = BoxScoreFourFactorsV3.player_stats(game: "0022400001").first

      assert_equal "32:45", stat.min
      assert_in_delta 0.625, stat.efg_pct
      assert_in_delta 0.25, stat.fta_rate
      assert_in_delta 12.0, stat.tov_pct
      assert_in_delta 25.0, stat.oreb_pct
    end

    def test_player_stats_parses_opponent_factors
      stub_four_factors_v3_request

      stat = BoxScoreFourFactorsV3.player_stats(game: "0022400001").first

      assert_in_delta 0.48, stat.opp_efg_pct
      assert_in_delta 0.22, stat.opp_fta_rate
      assert_in_delta 15.0, stat.opp_tov_pct
      assert_in_delta 20.0, stat.opp_oreb_pct
    end

    def test_team_stats_returns_collection
      stub_four_factors_v3_request

      assert_instance_of Collection, BoxScoreFourFactorsV3.team_stats(game: "0022400001")
    end

    def test_team_stats_parses_identity_attributes
      stub_four_factors_v3_request

      stat = BoxScoreFourFactorsV3.team_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
    end

    def test_team_stats_parses_four_factors
      stub_four_factors_v3_request

      stat = BoxScoreFourFactorsV3.team_stats(game: "0022400001").first

      assert_equal "240:00", stat.min
      assert_in_delta 0.55, stat.efg_pct
      assert_in_delta 0.20, stat.fta_rate
      assert_in_delta 11.0, stat.tov_pct
      assert_in_delta 28.0, stat.oreb_pct
    end

    def test_team_stats_parses_opponent_factors
      stub_four_factors_v3_request

      stat = BoxScoreFourFactorsV3.team_stats(game: "0022400001").first

      assert_in_delta 0.50, stat.opp_efg_pct
      assert_in_delta 0.18, stat.opp_fta_rate
      assert_in_delta 14.0, stat.opp_tov_pct
      assert_in_delta 22.0, stat.opp_oreb_pct
    end

    private

    def stub_four_factors_v3_request
      stub_request(:get, /boxscorefourfactorsv3.*GameID=0022400001/)
        .to_return(body: four_factors_v3_response.to_json)
    end

    def four_factors_v3_response
      {boxScoreFourFactors: {homeTeam: home_team_data, awayTeam: away_team_data}}
    end

    def home_team_data
      {teamId: Team::GSW, teamName: "Warriors", teamTricode: "GSW",
       teamCity: "Golden State", statistics: four_factors_team_stats,
       players: [four_factors_player_data]}
    end

    def away_team_data
      {teamId: Team::LAL, teamName: "Lakers", teamTricode: "LAL",
       teamCity: "Los Angeles", statistics: four_factors_team_stats, players: []}
    end

    def four_factors_player_data
      {personId: 201_939, firstName: "Stephen", familyName: "Curry",
       teamId: Team::GSW, teamTricode: "GSW", teamCity: "Golden State",
       position: "G", comment: "", statistics: four_factors_player_stats}
    end

    def four_factors_player_stats
      {minutes: "32:45", effectiveFieldGoalPercentage: 0.625,
       freeThrowAttemptRate: 0.25, teamTurnoverPercentage: 12.0,
       offensiveReboundPercentage: 25.0, oppEffectiveFieldGoalPercentage: 0.48,
       oppFreeThrowAttemptRate: 0.22, oppTurnoverPercentage: 15.0,
       oppOffensiveReboundPercentage: 20.0}
    end

    def four_factors_team_stats
      {minutes: "240:00", effectiveFieldGoalPercentage: 0.55,
       freeThrowAttemptRate: 0.20, teamTurnoverPercentage: 11.0,
       offensiveReboundPercentage: 28.0, oppEffectiveFieldGoalPercentage: 0.50,
       oppFreeThrowAttemptRate: 0.18, oppTurnoverPercentage: 14.0,
       oppOffensiveReboundPercentage: 22.0}
    end
  end
end
