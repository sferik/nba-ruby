require_relative "test_helper"
require_relative "standings_formatters_test_helper"

module NBA
  class FormatStandingRowTest < Minitest::Test
    include StandingsFormattersTestHelper

    cover CLI::Formatters::StandingsFormatters

    def test_includes_rank_with_dot
      standing = mock_standing("Warriors", 50, 20)
      widths = {rank: 1, team: 8}

      assert_includes format_standing_row(standing, 1, widths), "1."
    end

    def test_includes_team_name
      standing = mock_standing("Warriors", 50, 20)
      widths = {rank: 1, team: 8}

      assert_includes format_standing_row(standing, 1, widths), "Warriors"
    end

    def test_includes_wins
      standing = mock_standing("Warriors", 50, 20)
      widths = {rank: 1, team: 8}

      assert_includes format_standing_row(standing, 1, widths), "50"
    end

    def test_includes_losses
      standing = mock_standing("Warriors", 50, 20)
      widths = {rank: 1, team: 8}

      assert_includes format_standing_row(standing, 1, widths), "20"
    end

    def test_includes_record_separator
      standing = mock_standing("Warriors", 50, 20)
      widths = {rank: 1, team: 8}

      assert_includes format_standing_row(standing, 1, widths), "50-20"
    end

    def test_rank_right_justified_to_width
      standing = mock_standing("Warriors", 50, 20)
      widths = {rank: 2, team: 8}
      result = format_standing_row(standing, 1, widths)

      # Rank 1 with width 2 should be " 1"
      assert_match(/\A\s*1\./, result)
    end

    def test_rank_width_respected
      standing = mock_standing("Warriors", 50, 20)
      widths = {rank: 3, team: 8}
      result = format_standing_row(standing, 5, widths)

      # Rank 5 with width 3 should be "  5"
      assert_match(/\A\s{2}5\./, result)
    end

    def test_team_left_justified_to_width
      standing = mock_standing("Warriors", 50, 20)
      widths = {rank: 1, team: 12}
      result = format_standing_row(standing, 1, widths)

      # "Warriors" (8 chars) should be padded to 12 chars
      assert_includes result, "Warriors    "
    end

    def test_team_width_exact
      standing = mock_standing("A", 1, 0)
      widths = {rank: 1, team: 5}
      result = format_standing_row(standing, 1, widths)

      # "A" with width 5 should be "A    " (4 trailing spaces)
      assert_includes result, "A    "
    end

    def test_rank_converts_to_string
      standing = mock_standing("Warriors", 50, 20)
      widths = {rank: 2, team: 8}

      # This tests that rank.to_s is called (Integer converted to String)
      result = format_standing_row(standing, 10, widths)

      assert_includes result, "10."
    end

    def test_uses_rjust_for_rank
      standing = mock_standing("Warriors", 50, 20)
      widths = {rank: 2, team: 8}
      result = format_standing_row(standing, 1, widths)

      # With rjust(2), rank 1 should be " 1" not "1 "
      assert_match(/\s1\./, result)
      refute_match(/1\s\./, result)
    end

    def test_uses_ljust_for_team
      standing = mock_standing("A", 50, 20)
      widths = {rank: 1, team: 3}
      result = format_standing_row(standing, 1, widths)

      # With ljust(3), "A" should be "A  " not "  A"
      assert_includes result, "A  "
      refute_includes result, "  A"
    end

    def test_accesses_rank_width_from_hash
      standing = mock_standing("Warriors", 50, 20)
      widths = {rank: 3, team: 8}
      result = format_standing_row(standing, 1, widths)

      # Verify rank uses widths[:rank] = 3, so "  1"
      assert_match(/\A\s{2}1\./, result)
    end

    def test_accesses_team_width_from_hash
      standing = mock_standing("A", 50, 20)
      widths = {rank: 1, team: 5}
      result = format_standing_row(standing, 1, widths)

      # Verify team uses widths[:team] = 5, so "A    "
      assert_includes result, "A    "
    end
  end
end
