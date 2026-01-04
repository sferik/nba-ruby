require_relative "../test_helper"

module NBA
  class WinProbabilityPointTest < Minitest::Test
    cover WinProbabilityPoint

    def test_equality_based_on_game_id_and_event_num
      point1 = WinProbabilityPoint.new(game_id: "0022400001", event_num: 42)
      point2 = WinProbabilityPoint.new(game_id: "0022400001", event_num: 42)
      point3 = WinProbabilityPoint.new(game_id: "0022400001", event_num: 43)
      point4 = WinProbabilityPoint.new(game_id: "0022400002", event_num: 42)

      assert_equal point1, point2
      refute_equal point1, point3
      refute_equal point1, point4
    end

    def test_description_returns_home_description_when_present
      point = WinProbabilityPoint.new(
        home_description: "Curry 3PT Shot", neutral_description: nil, visitor_description: nil
      )

      assert_equal "Curry 3PT Shot", point.description
    end

    def test_description_returns_neutral_description_when_home_nil
      point = WinProbabilityPoint.new(
        home_description: nil, neutral_description: "Jump Ball", visitor_description: nil
      )

      assert_equal "Jump Ball", point.description
    end

    def test_description_returns_visitor_description_when_home_and_neutral_nil
      point = WinProbabilityPoint.new(
        home_description: nil, neutral_description: nil, visitor_description: "LeBron Dunk"
      )

      assert_equal "LeBron Dunk", point.description
    end

    def test_description_returns_nil_when_all_nil
      point = WinProbabilityPoint.new(
        home_description: nil, neutral_description: nil, visitor_description: nil
      )

      assert_nil point.description
    end

    def test_margin_returns_home_pts_minus_visitor_pts
      point = WinProbabilityPoint.new(home_pts: 100, visitor_pts: 95)

      assert_equal 5, point.margin
    end

    def test_margin_returns_negative_when_visitor_leading
      point = WinProbabilityPoint.new(home_pts: 95, visitor_pts: 100)

      assert_equal(-5, point.margin)
    end

    def test_margin_returns_nil_when_home_pts_nil
      point = WinProbabilityPoint.new(home_pts: nil, visitor_pts: 100)

      assert_nil point.margin
    end

    def test_margin_returns_nil_when_visitor_pts_nil
      point = WinProbabilityPoint.new(home_pts: 100, visitor_pts: nil)

      assert_nil point.margin
    end

    def test_basic_identifiers_assignable
      point = sample_point

      assert_equal "0022400001", point.game_id
      assert_equal 42, point.event_num
      assert_in_delta 0.75, point.home_pct
      assert_in_delta 0.25, point.visitor_pct
    end

    def test_score_attributes_assignable
      point = sample_point

      assert_equal 100, point.home_pts
      assert_equal 95, point.visitor_pts
      assert_equal 3, point.home_score_by
      assert_equal 0, point.visitor_score_by
    end

    def test_time_and_location_attributes_assignable
      point = sample_point

      assert_equal 4, point.period
      assert_equal 120, point.seconds_remaining
      assert_equal "GSW", point.location
    end

    def test_description_attributes_assignable
      point = sample_point

      assert_equal "Curry 3PT Shot", point.home_description
      assert_nil point.neutral_description
      assert_nil point.visitor_description
    end

    private

    def sample_point
      WinProbabilityPoint.new(game_id: "0022400001", event_num: 42, home_pct: 0.75,
        visitor_pct: 0.25, home_pts: 100, visitor_pts: 95, home_score_by: 3,
        visitor_score_by: 0, period: 4, seconds_remaining: 120,
        home_description: "Curry 3PT Shot", neutral_description: nil,
        visitor_description: nil, location: "GSW")
    end
  end
end
