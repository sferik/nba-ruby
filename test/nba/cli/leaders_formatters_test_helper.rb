module NBA
  module LeadersFormattersTestHelper
    include CLI::Formatters::LeadersFormatters
    include CLI::Formatters

    private

    def mock_leader(rank, player_name, value)
      Struct.new(:rank, :player_name, :value).new(rank, player_name, value)
    end
  end
end
