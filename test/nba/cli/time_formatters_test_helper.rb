module NBA
  # Mock match data for testing fallback behavior when capture groups are nil
  class MockMatchData
    def initialize(hour: nil, minute: nil, period: nil)
      @data = [nil, hour, minute, period]
    end

    def [](index)
      @data[index]
    end
  end
end
