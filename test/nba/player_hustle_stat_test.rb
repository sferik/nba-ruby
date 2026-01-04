require_relative "../test_helper"

module NBA
  class PlayerHustleStatTest < Minitest::Test
    cover PlayerHustleStat

    def test_equality_based_on_player_id
      stat1 = PlayerHustleStat.new(player_id: 201_939)
      stat2 = PlayerHustleStat.new(player_id: 201_939)
      stat3 = PlayerHustleStat.new(player_id: 2544)

      assert_equal stat1, stat2
      refute_equal stat1, stat3
    end

    def test_player_returns_player_object
      stub_request(:get, /commonplayerinfo.*PlayerID=201939/)
        .to_return(body: player_info_response.to_json)

      stat = PlayerHustleStat.new(player_id: 201_939)

      assert_equal 201_939, stat.player.id
    end

    def test_team_returns_team_object
      stat = PlayerHustleStat.new(team_id: Team::GSW)

      team = stat.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_identity_attributes_assignable
      stat = create_stat

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
      assert_equal 36, stat.age
    end

    def test_game_stats_assignable
      stat = create_stat

      assert_equal 82, stat.gp
      assert_equal 50, stat.w
      assert_equal 32, stat.l
      assert_in_delta 34.5, stat.min
    end

    def test_contested_shots_assignable
      stat = create_stat

      assert_in_delta 5.5, stat.contested_shots
      assert_in_delta 3.5, stat.contested_shots_2pt
      assert_in_delta 2.0, stat.contested_shots_3pt
    end

    def test_deflections_and_charges_assignable
      stat = create_stat

      assert_in_delta 2.5, stat.deflections
      assert_in_delta 0.2, stat.charges_drawn
    end

    def test_screen_assists_assignable
      stat = create_stat

      assert_in_delta 3.0, stat.screen_assists
      assert_in_delta 7.5, stat.screen_ast_pts
    end

    def test_loose_balls_assignable
      stat = create_stat

      assert_in_delta 1.0, stat.loose_balls_recovered
      assert_in_delta 0.5, stat.off_loose_balls_recovered
      assert_in_delta 0.5, stat.def_loose_balls_recovered
    end

    def test_box_outs_assignable
      stat = create_stat

      assert_in_delta 2.0, stat.box_outs
      assert_in_delta 0.5, stat.off_box_outs
      assert_in_delta 1.5, stat.def_box_outs
    end

    private

    # rubocop:disable Metrics/MethodLength
    def create_stat
      PlayerHustleStat.new(
        player_id: 201_939,
        player_name: "Stephen Curry",
        team_id: Team::GSW,
        team_abbreviation: "GSW",
        age: 36,
        gp: 82,
        w: 50,
        l: 32,
        min: 34.5,
        contested_shots: 5.5,
        contested_shots_2pt: 3.5,
        contested_shots_3pt: 2.0,
        deflections: 2.5,
        charges_drawn: 0.2,
        screen_assists: 3.0,
        screen_ast_pts: 7.5,
        loose_balls_recovered: 1.0,
        off_loose_balls_recovered: 0.5,
        def_loose_balls_recovered: 0.5,
        box_outs: 2.0,
        off_box_outs: 0.5,
        def_box_outs: 1.5
      )
    end
    # rubocop:enable Metrics/MethodLength

    def player_info_response
      {
        resultSets: [{
          name: "CommonPlayerInfo",
          headers: %w[PERSON_ID DISPLAY_FIRST_LAST TEAM_ID],
          rowSet: [[201_939, "Stephen Curry", 1_610_612_744]]
        }]
      }
    end
  end
end
