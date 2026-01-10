require_relative "../test_helper"
require_relative "shot_chart_hydration_helper"

module NBA
  class ShotChartTeamHydrationTest < Minitest::Test
    include ShotChartHydrationHelper

    cover ShotChart

    def test_find_accepts_team_object
      stub_shot_chart_request
      team = Team.new(id: Team::GSW, full_name: "Golden State Warriors")

      ShotChart.find(player: 201_939, team: team)

      assert_requested :get, /shotchartdetail.*TeamID=#{Team::GSW}/o
    end
  end
end
