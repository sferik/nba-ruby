require_relative "../../test_helper"

module NBA
  module CommonTeamYearsTestHelpers
    private

    def headers
      %w[LEAGUE_ID TEAM_ID MIN_YEAR MAX_YEAR ABBREVIATION]
    end

    def rows
      [["00", Team::GSW, 1946, 2024, "GSW"]]
    end
  end
end
