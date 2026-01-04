require_relative "../test_helper"

module NBA
  class TeamHustleStatTest < Minitest::Test
    cover TeamHustleStat

    def test_equality_based_on_team_id
      stat1 = TeamHustleStat.new(team_id: Team::GSW)
      stat2 = TeamHustleStat.new(team_id: Team::GSW)
      stat3 = TeamHustleStat.new(team_id: Team::LAL)

      assert_equal stat1, stat2
      refute_equal stat1, stat3
    end

    def test_team_returns_team_object
      stat = TeamHustleStat.new(team_id: Team::GSW)

      assert_equal Team::GSW, stat.team.id
    end

    def test_identity_attributes_assignable
      stat = create_stat

      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
    end

    def test_game_stats_assignable
      stat = create_stat

      assert_equal 82, stat.gp
      assert_equal 50, stat.w
      assert_equal 32, stat.l
      assert_in_delta 48.0, stat.min
    end

    def test_contested_shots_assignable
      stat = create_stat

      assert_in_delta 55.0, stat.contested_shots
      assert_in_delta 35.0, stat.contested_shots_2pt
      assert_in_delta 20.0, stat.contested_shots_3pt
    end

    def test_deflections_and_charges_assignable
      stat = create_stat

      assert_in_delta 15.0, stat.deflections
      assert_in_delta 1.5, stat.charges_drawn
    end

    def test_screen_assists_assignable
      stat = create_stat

      assert_in_delta 18.0, stat.screen_assists
      assert_in_delta 45.0, stat.screen_ast_pts
    end

    def test_loose_balls_assignable
      stat = create_stat

      assert_in_delta 6.5, stat.loose_balls_recovered
      assert_in_delta 3.0, stat.off_loose_balls_recovered
      assert_in_delta 3.5, stat.def_loose_balls_recovered
    end

    def test_box_outs_assignable
      stat = create_stat

      assert_in_delta 12.0, stat.box_outs
      assert_in_delta 3.5, stat.off_box_outs
      assert_in_delta 8.5, stat.def_box_outs
    end

    private

    # rubocop:disable Metrics/MethodLength
    def create_stat
      TeamHustleStat.new(
        team_id: Team::GSW,
        team_name: "Warriors",
        gp: 82,
        w: 50,
        l: 32,
        min: 48.0,
        contested_shots: 55.0,
        contested_shots_2pt: 35.0,
        contested_shots_3pt: 20.0,
        deflections: 15.0,
        charges_drawn: 1.5,
        screen_assists: 18.0,
        screen_ast_pts: 45.0,
        loose_balls_recovered: 6.5,
        off_loose_balls_recovered: 3.0,
        def_loose_balls_recovered: 3.5,
        box_outs: 12.0,
        off_box_outs: 3.5,
        def_box_outs: 8.5
      )
    end
    # rubocop:enable Metrics/MethodLength
  end
end
