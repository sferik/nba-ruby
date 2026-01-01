require_relative "../test_helper"

module NBA
  class UtilsTest < Minitest::Test
    cover Utils

    def test_current_season_october_to_december
      date = Date.new(2024, 11, 15)
      Date.stub :today, date do
        season = Utils.current_season

        assert_equal 2024, season
      end
    end

    def test_current_season_january_to_june
      date = Date.new(2024, 3, 15)
      Date.stub :today, date do
        season = Utils.current_season

        assert_equal 2023, season
      end
    end

    def test_current_season_june_returns_previous_year
      date = Date.new(2024, 6, 15)
      Date.stub :today, date do
        season = Utils.current_season

        assert_equal 2023, season
      end
    end

    def test_current_season_july_returns_current_year
      date = Date.new(2024, 7, 1)
      Date.stub :today, date do
        season = Utils.current_season

        assert_equal 2024, season
      end
    end

    def test_build_query_creates_query_string
      query = Utils.build_query(season: 2024, team_id: 1)

      assert_equal "season=2024&team_id=1", query
    end

    def test_build_query_omits_nil_values
      query = Utils.build_query(season: 2024, team_id: nil)

      assert_equal "season=2024", query
    end
  end
end
