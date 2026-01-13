require_relative "test_helper"

module NBA
  class CLITeamNicknameFormatterTest < Minitest::Test
    include CLI::Formatters::TeamFormatters

    cover CLI::Formatters::TeamFormatters

    def test_team_nickname_returns_tbd_when_nil
      assert_equal "TBD", team_nickname(nil)
    end

    def test_team_nickname_returns_nickname_when_present
      team = Team.new(nickname: "Warriors", full_name: "Golden State Warriors")

      assert_equal "Warriors", team_nickname(team)
    end

    def test_team_nickname_prefers_nickname_over_full_name
      team = Team.new(nickname: "Dubs", full_name: "Golden State Warriors")
      # Should return "Dubs" not "Warriors"
      assert_equal "Dubs", team_nickname(team)
    end

    def test_team_nickname_extracts_from_full_name_when_no_nickname
      team = Team.new(full_name: "Golden State Warriors")

      assert_equal "Warriors", team_nickname(team)
    end

    def test_team_nickname_returns_tbd_when_both_nil
      team = Team.new(id: 1)

      assert_equal "TBD", team_nickname(team)
    end

    def test_team_nickname_handles_nil_full_name_with_nil_nickname
      team = Struct.new(:nickname, :full_name).new(nil, nil)

      assert_equal "TBD", team_nickname(team)
    end
  end
end
