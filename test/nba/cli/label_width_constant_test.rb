require_relative "test_helper"

module NBA
  class LabelWidthConstantTest < Minitest::Test
    cover CLI::Formatters

    def test_label_width_is_sixteen
      assert_equal 16, CLI::Formatters::LABEL_WIDTH
    end
  end
end
