require_relative "../test_helper"

module NBA
  class GameLogWinLossTest < Minitest::Test
    cover GameLog

    def test_win_returns_true_when_wl_is_w
      log = GameLog.new(wl: "W")

      assert_predicate log, :win?
    end

    def test_win_returns_false_when_wl_is_l
      log = GameLog.new(wl: "L")

      refute_predicate log, :win?
    end

    def test_loss_returns_true_when_wl_is_l
      log = GameLog.new(wl: "L")

      assert_predicate log, :loss?
    end

    def test_loss_returns_false_when_wl_is_w
      log = GameLog.new(wl: "W")

      refute_predicate log, :loss?
    end
  end
end
