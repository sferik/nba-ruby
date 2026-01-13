require_relative "test_helper"

module NBA
  class HelpersConstantsTest < Minitest::Test
    include CLI::Helpers

    cover CLI::Helpers

    def test_et_offset_seconds_constant
      assert_equal 18_000, ET_OFFSET_SECONDS
    end

    def test_conference_map_constant
      assert_equal "East", CONFERENCE_MAP["E"]
      assert_equal "West", CONFERENCE_MAP["W"]
      assert_equal "Invalid", CONFERENCE_MAP[nil]
    end
  end
end
