require_relative "test_helper"

module NBA
  class ConvertEtToLocalTest < Minitest::Test
    include CLI::Formatters::TimeFormatters

    cover CLI::Formatters::TimeFormatters

    def test_returns_status_when_not_et_time
      assert_equal "Final", convert_et_to_local("Final")
    end

    def test_returns_status_when_empty
      assert_equal "", convert_et_to_local("")
    end

    def test_processes_pm_time
      result = convert_et_to_local("7:30 pm ET")

      refute_includes result, "ET"
      assert_match(/\d{1,2}:\d{2} [AP]M/, result)
    end

    def test_processes_am_time
      result = convert_et_to_local("10:00 am ET")

      refute_includes result, "ET"
      assert_match(/\d{1,2}:\d{2} [AP]M/, result)
    end
  end
end
