require_relative "test_helper"
require_relative "game_formatters_test_helper"

module NBA
  class GameTeamNicknameTest < Minitest::Test
    include GameFormattersTestHelper

    cover CLI::Formatters::GameFormatters

    def test_returns_tbd_when_nil
      assert_equal "TBD", team_nickname(nil)
    end

    def test_returns_nickname_when_present
      team = Team.new(nickname: "Warriors", full_name: "Golden State Warriors")

      assert_equal "Warriors", team_nickname(team)
    end

    def test_extracts_from_full_name_when_no_nickname
      team = Team.new(full_name: "Golden State Warriors")

      assert_equal "Warriors", team_nickname(team)
    end
  end
end
