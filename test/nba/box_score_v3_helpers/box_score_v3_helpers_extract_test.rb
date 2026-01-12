require_relative "../../test_helper"

module NBA
  class BoxScoreV3HelpersExtractTest < Minitest::Test
    cover BoxScoreV3Helpers

    def test_extract_players_with_valid_data
      data = {"boxScoreTraditional" => {
        "homeTeam" => {"players" => [{"personId" => 1}]},
        "awayTeam" => {"players" => [{"personId" => 2}]}
      }}

      assert_equal 2, BoxScoreV3Helpers.extract_players(data, "boxScoreTraditional").size
    end

    def test_extract_players_with_missing_box_score_key
      assert_nil BoxScoreV3Helpers.extract_players({}, "boxScoreTraditional")
    end

    def test_extract_players_with_missing_home_team_players
      data = {"boxScoreTraditional" => {
        "awayTeam" => {"players" => [{"personId" => 2}]}
      }}

      assert_equal 1, BoxScoreV3Helpers.extract_players(data, "boxScoreTraditional").size
    end

    def test_extract_players_with_missing_away_team_players
      data = {"boxScoreTraditional" => {
        "homeTeam" => {"players" => [{"personId" => 1}]}
      }}

      assert_equal 1, BoxScoreV3Helpers.extract_players(data, "boxScoreTraditional").size
    end

    def test_extract_players_with_nil_home_team_players
      data = {"boxScoreTraditional" => {
        "homeTeam" => {"players" => nil}, "awayTeam" => {"players" => []}
      }}

      assert_equal 0, BoxScoreV3Helpers.extract_players(data, "boxScoreTraditional").size
    end

    def test_extract_teams_with_valid_data
      data = {"boxScoreTraditional" => {
        "homeTeam" => {"teamId" => 1}, "awayTeam" => {"teamId" => 2}
      }}

      assert_equal 2, BoxScoreV3Helpers.extract_teams(data, "boxScoreTraditional").size
    end

    def test_extract_teams_with_missing_box_score_key
      assert_nil BoxScoreV3Helpers.extract_teams({}, "boxScoreTraditional")
    end

    def test_extract_teams_with_missing_home_team_key
      data = {"boxScoreTraditional" => {"awayTeam" => {"teamId" => 2}}}

      assert_equal 1, BoxScoreV3Helpers.extract_teams(data, "boxScoreTraditional").size
    end

    def test_extract_teams_with_missing_away_team_key
      data = {"boxScoreTraditional" => {"homeTeam" => {"teamId" => 1}}}

      assert_equal 1, BoxScoreV3Helpers.extract_teams(data, "boxScoreTraditional").size
    end

    def test_extract_teams_with_nil_home_team
      data = {"boxScoreTraditional" => {
        "homeTeam" => nil, "awayTeam" => {"teamId" => 2}
      }}

      assert_equal 1, BoxScoreV3Helpers.extract_teams(data, "boxScoreTraditional").size
    end
  end
end
