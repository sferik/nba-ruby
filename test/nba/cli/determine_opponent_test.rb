require_relative "test_helper"
require_relative "game_formatters_test_helper"

module NBA
  class DetermineOpponentTest < Minitest::Test
    include GameFormattersTestHelper

    cover CLI::Formatters::GameFormatters

    def test_home_game
      game = Struct.new(:home_team_tricode, :away_team_tricode).new("GSW", "LAL")
      team = Team.new(abbreviation: "GSW")

      assert_equal "vs LAL", determine_opponent(game, team)
    end

    def test_away_game
      game = Struct.new(:home_team_tricode, :away_team_tricode).new("LAL", "GSW")
      team = Team.new(abbreviation: "GSW")

      assert_equal "@ LAL", determine_opponent(game, team)
    end
  end
end
