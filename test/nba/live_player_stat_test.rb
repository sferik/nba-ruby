require_relative "../test_helper"

module NBA
  class LivePlayerStatTest < Minitest::Test
    cover LivePlayerStat

    def test_equality_based_on_player_id_and_game_id
      stat1 = LivePlayerStat.new(player_id: 201_939, game_id: "0022400001")
      stat2 = LivePlayerStat.new(player_id: 201_939, game_id: "0022400001")
      stat3 = LivePlayerStat.new(player_id: 201_939, game_id: "0022400002")
      stat4 = LivePlayerStat.new(player_id: 201_566, game_id: "0022400001")

      assert_equal stat1, stat2
      refute_equal stat1, stat3
      refute_equal stat1, stat4
    end

    def test_starter_returns_true_when_starter_is_one
      stat = LivePlayerStat.new(starter: "1")

      assert_predicate stat, :starter?
    end

    def test_starter_returns_false_when_starter_is_zero
      stat = LivePlayerStat.new(starter: "0")

      refute_predicate stat, :starter?
    end

    def test_player_returns_player_object
      stub_request(:get, /commonplayerinfo.*PlayerID=201939/)
        .to_return(body: player_info_response.to_json)

      stat = LivePlayerStat.new(player_id: 201_939)

      assert_equal 201_939, stat.player.id
    end

    def test_team_returns_team_object
      stat = LivePlayerStat.new(team_id: Team::GSW)

      team = stat.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_identity_attributes
      stat = sample_stat

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.name
      assert_equal "Stephen", stat.first_name
      assert_equal "Curry", stat.family_name
      assert_equal "30", stat.jersey_num
    end

    def test_position_attribute
      stat = sample_stat

      assert_equal "G", stat.position
    end

    def test_team_attributes
      stat = sample_stat

      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_tricode
    end

    def test_shooting_stats
      stat = sample_stat

      assert_equal 11, stat.field_goals_made
      assert_equal 22, stat.field_goals_attempted
      assert_equal 6, stat.three_pointers_made
      assert_equal 12, stat.three_pointers_attempted
      assert_equal 4, stat.free_throws_made
    end

    def test_counting_stats
      stat = sample_stat

      assert_equal 5, stat.rebounds_total
      assert_equal 8, stat.assists
      assert_equal 2, stat.steals
      assert_equal 0, stat.blocks
      assert_equal 3, stat.turnovers
    end

    def test_points_stats
      stat = sample_stat

      assert_equal 32, stat.points
      assert_in_delta 12.0, stat.plus_minus
    end

    private

    def sample_stat
      LivePlayerStat.new(**sample_stat_attributes)
    end

    def sample_stat_attributes # rubocop:disable Metrics/MethodLength
      {
        game_id: "0022400001", player_id: 201_939, name: "Stephen Curry",
        first_name: "Stephen", family_name: "Curry", jersey_num: "30", position: "G",
        team_id: Team::GSW, team_tricode: "GSW", starter: "1", minutes: "PT36M15.00S",
        points: 32, rebounds_total: 5, rebounds_offensive: 1, rebounds_defensive: 4,
        assists: 8, steals: 2, blocks: 0, turnovers: 3, fouls_personal: 2,
        plus_minus: 12.0, field_goals_made: 11, field_goals_attempted: 22,
        field_goals_percentage: 0.5, three_pointers_made: 6, three_pointers_attempted: 12,
        three_pointers_percentage: 0.5, free_throws_made: 4, free_throws_attempted: 4,
        free_throws_percentage: 1.0
      }
    end

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
