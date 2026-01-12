require_relative "../../test_helper"

module NBA
  class TeamGameLogStatTest < Minitest::Test
    cover TeamGameLogStat

    def test_includes_equalizer_with_game_id_and_team_id
      log1 = TeamGameLogStat.new(game_id: "0022400001", team_id: Team::GSW)
      log2 = TeamGameLogStat.new(game_id: "0022400001", team_id: Team::GSW)

      assert_equal log1, log2
    end

    def test_different_game_ids_are_not_equal
      log1 = TeamGameLogStat.new(game_id: "0022400001", team_id: Team::GSW)
      log2 = TeamGameLogStat.new(game_id: "0022400002", team_id: Team::GSW)

      refute_equal log1, log2
    end

    def test_different_team_ids_are_not_equal
      log1 = TeamGameLogStat.new(game_id: "0022400001", team_id: Team::GSW)
      log2 = TeamGameLogStat.new(game_id: "0022400001", team_id: Team::LAL)

      refute_equal log1, log2
    end

    def test_inherits_from_shale_mapper
      log = TeamGameLogStat.new

      assert_kind_of Shale::Mapper, log
    end
  end
end
