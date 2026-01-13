require_relative "test_helper"

module NBA
  class EtTimePatternTest < Minitest::Test
    include CLI::Formatters::TimeFormatters

    cover CLI::Formatters::TimeFormatters

    def test_matches_pm_time
      assert_match ET_TIME_PATTERN, "7:30 pm ET"
    end

    def test_matches_am_time
      assert_match ET_TIME_PATTERN, "11:30 am ET"
    end

    def test_matches_uppercase
      assert_match ET_TIME_PATTERN, "7:30 PM ET"
    end

    def test_does_not_match_final
      refute_match ET_TIME_PATTERN, "Final"
    end

    def test_does_not_match_in_progress
      refute_match ET_TIME_PATTERN, "In Progress"
    end
  end
end
