module NBA
  module StandingsFormattersTestHelper
    include CLI::Formatters::StandingsFormatters
    include CLI::Formatters

    private

    def mock_standing(team_name, wins, losses)
      Struct.new(:team_name, :wins, :losses).new(team_name, wins, losses)
    end
  end
end
