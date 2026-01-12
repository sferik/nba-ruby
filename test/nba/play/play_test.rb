require_relative "../../test_helper"

module NBA
  class PlayTest < Minitest::Test
    cover Play

    def test_objects_with_same_game_id_and_event_num_are_equal
      play0 = Play.new(game_id: "001", event_num: 1)
      play1 = Play.new(game_id: "001", event_num: 1)

      assert_equal play0, play1
    end

    def test_objects_with_different_event_num_are_not_equal
      play0 = Play.new(game_id: "001", event_num: 1)
      play1 = Play.new(game_id: "001", event_num: 2)

      refute_equal play0, play1
    end

    def test_description_returns_home_description_first
      play = Play.new(home_description: "Home", visitor_description: "Visitor", neutral_description: "Neutral")

      assert_equal "Home", play.description
    end

    def test_description_returns_visitor_description_when_no_home
      play = Play.new(home_description: nil, visitor_description: "Visitor", neutral_description: "Neutral")

      assert_equal "Visitor", play.description
    end

    def test_description_returns_neutral_description_when_no_home_or_visitor
      play = Play.new(home_description: nil, visitor_description: nil, neutral_description: "Neutral")

      assert_equal "Neutral", play.description
    end

    def test_description_returns_nil_when_all_nil
      play = Play.new(home_description: nil, visitor_description: nil, neutral_description: nil)

      assert_nil play.description
    end
  end
end
