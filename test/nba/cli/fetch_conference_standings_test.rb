require_relative "test_helper"

module NBA
  class FetchConferenceStandingsTest < Minitest::Test
    include CLI::Helpers

    cover CLI::Helpers

    def options
      @options ||= {}
    end

    def test_passes_conference_to_standings
      @options = {conference: "West"}
      conference_received = nil
      mock_method = lambda { |conf, **|
        conference_received = conf
        Collection.new([])
      }
      Standings.stub(:conference, mock_method) do
        fetch_conference_standings
      end

      assert_equal "West", conference_received
    end

    def test_passes_season_when_provided
      @options = {conference: "East", season: 2023}
      season_received = nil
      mock_method = lambda { |_conf, season: nil|
        season_received = season
        Collection.new([])
      }
      Standings.stub(:conference, mock_method) do
        fetch_conference_standings
      end

      assert_equal 2023, season_received
    end

    def test_passes_conference_when_season_provided
      @options = {conference: "West", season: 2023}
      conference_received = nil
      mock_method = lambda { |conf, **|
        conference_received = conf
        Collection.new([])
      }
      Standings.stub(:conference, mock_method) do
        fetch_conference_standings
      end

      assert_equal "West", conference_received
    end

    def test_does_not_pass_season_when_nil
      @options = {conference: "East"}
      season_keyword_received = false
      mock_method = lambda { |_conf, **kwargs|
        season_keyword_received = kwargs.key?(:season)
        Collection.new([])
      }
      Standings.stub(:conference, mock_method) do
        fetch_conference_standings
      end

      refute season_keyword_received
    end

    def test_returns_conference_standings_without_season
      @options = {conference: "East"}
      expected_result = Collection.new([])
      Standings.stub(:conference, expected_result) do
        result = fetch_conference_standings

        assert_equal expected_result, result
      end
    end

    def test_normalizes_conference_input
      @options = {conference: "e"}
      conference_received = nil
      mock_method = lambda { |conf, **|
        conference_received = conf
        Collection.new([])
      }
      Standings.stub(:conference, mock_method) do
        fetch_conference_standings
      end

      assert_equal "East", conference_received
    end

    def test_calls_standings_conference_without_season
      @options = {conference: "East"}
      expected = Collection.new([])
      called = false
      mock = ->(*) { (called = true) && expected }

      Standings.stub(:conference, mock) { assert_same expected, fetch_conference_standings }
      assert called
    end
  end
end
