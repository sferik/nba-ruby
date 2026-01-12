require_relative "../../test_helper"

module NBA
  class CommonTeamYearsConstantsTest < Minitest::Test
    cover CommonTeamYears

    def test_team_years_constant
      assert_equal "TeamYears", CommonTeamYears::TEAM_YEARS
    end
  end
end
