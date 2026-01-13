require_relative "test_helper"

module NBA
  class EasternTimeDateTest < Minitest::Test
    include CLI::Helpers

    cover CLI::Helpers

    def test_returns_date
      assert_kind_of Date, eastern_time_date
    end

    def test_accounts_for_offset
      result = eastern_time_date
      utc_date = Time.now.utc.to_date
      diff = (result - utc_date).abs

      assert_operator diff, :<=, 1, "Eastern time date should be within 1 day of UTC"
    end

    def test_uses_utc_time
      # Create a mock that tracks whether utc was called
      mock_time = Minitest::Mock.new
      mock_utc = Time.new(2024, 1, 2, 2, 0, 0, "+00:00")
      mock_time.expect(:utc, mock_utc)

      Time.stub(:now, mock_time) do
        result = eastern_time_date

        assert_equal Date.new(2024, 1, 1), result
      end
      mock_time.verify
    end

    def test_subtracts_offset
      # At 6:00 AM UTC on Jan 2nd, Eastern time is 1:00 AM on Jan 2nd (same day)
      fake_utc = Time.new(2024, 1, 2, 6, 0, 0, "+00:00")

      Time.stub(:now, fake_utc) do
        result = eastern_time_date

        assert_equal Date.new(2024, 1, 2), result
      end
    end
  end
end
