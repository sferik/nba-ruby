require_relative "../../test_helper"

module NBA
  class InfographicFanDuelPlayerStatIdentityAttrsTest < Minitest::Test
    cover InfographicFanDuelPlayerStat

    def test_game_id_attribute
      stat = InfographicFanDuelPlayerStat.new(game_id: "0022400001")

      assert_equal "0022400001", stat.game_id
    end

    def test_player_id_attribute
      stat = InfographicFanDuelPlayerStat.new(player_id: 201_939)

      assert_equal 201_939, stat.player_id
    end

    def test_player_name_attribute
      stat = InfographicFanDuelPlayerStat.new(player_name: "Stephen Curry")

      assert_equal "Stephen Curry", stat.player_name
    end

    def test_team_id_attribute
      stat = InfographicFanDuelPlayerStat.new(team_id: Team::GSW)

      assert_equal Team::GSW, stat.team_id
    end

    def test_team_name_attribute
      stat = InfographicFanDuelPlayerStat.new(team_name: "Warriors")

      assert_equal "Warriors", stat.team_name
    end

    def test_team_abbreviation_attribute
      stat = InfographicFanDuelPlayerStat.new(team_abbreviation: "GSW")

      assert_equal "GSW", stat.team_abbreviation
    end

    def test_jersey_num_attribute
      stat = InfographicFanDuelPlayerStat.new(jersey_num: "30")

      assert_equal "30", stat.jersey_num
    end

    def test_player_position_attribute
      stat = InfographicFanDuelPlayerStat.new(player_position: "G")

      assert_equal "G", stat.player_position
    end

    def test_location_attribute
      stat = InfographicFanDuelPlayerStat.new(location: "Home")

      assert_equal "Home", stat.location
    end
  end
end
