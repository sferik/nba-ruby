require_relative "../test_helper"
require_relative "shot_chart_hydration_helper"

module NBA
  class ShotChartPlayerHydrationTest < Minitest::Test
    include ShotChartHydrationHelper

    cover ShotChart

    def test_find_accepts_player_object
      stub_shot_chart_request
      player = Player.new(id: 201_939, full_name: "Stephen Curry")

      ShotChart.find(player: player, team: Team::GSW)

      assert_requested :get, /shotchartdetail.*PlayerID=201939/
    end
  end
end
