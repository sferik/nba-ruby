require_relative "../../test_helper"

module NBA
  class TeamGameLogStatWinLossTest < Minitest::Test
    cover TeamGameLogStat

    def test_win_returns_true_when_wl_is_w
      log = TeamGameLogStat.new(wl: "W")

      assert_predicate log, :win?
    end

    def test_win_returns_false_when_wl_is_l
      log = TeamGameLogStat.new(wl: "L")

      refute_predicate log, :win?
    end

    def test_win_returns_false_when_wl_is_nil
      log = TeamGameLogStat.new(wl: nil)

      refute_predicate log, :win?
    end

    def test_loss_returns_true_when_wl_is_l
      log = TeamGameLogStat.new(wl: "L")

      assert_predicate log, :loss?
    end

    def test_loss_returns_false_when_wl_is_w
      log = TeamGameLogStat.new(wl: "W")

      refute_predicate log, :loss?
    end

    def test_loss_returns_false_when_wl_is_nil
      log = TeamGameLogStat.new(wl: nil)

      refute_predicate log, :loss?
    end

    def test_win_uses_value_equality
      log = TeamGameLogStat.new(wl: "W")

      assert_predicate log, :win?
    end

    def test_loss_uses_value_equality
      log = TeamGameLogStat.new(wl: "L")

      assert_predicate log, :loss?
    end
  end
end
