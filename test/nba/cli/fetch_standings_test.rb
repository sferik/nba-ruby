require_relative "test_helper"

module NBA
  class FetchStandingsTest < Minitest::Test
    include CLI::Helpers

    cover CLI::Helpers

    def options
      @options ||= {}
    end

    def test_returns_standings_without_conference_or_season
      @options = {}
      mock_standings = Collection.new([])
      Standings.stub(:all, mock_standings) do
        result = fetch_standings

        assert_equal mock_standings, result
      end
    end

    def test_passes_season_when_provided
      @options = {season: 2023}
      season_received = nil
      mock_method = lambda { |season:|
        season_received = season
        Collection.new([])
      }
      Standings.stub(:all, mock_method) do
        fetch_standings
      end

      assert_equal 2023, season_received
    end

    def test_calls_fetch_conference_standings_when_conference_provided
      @options = {conference: "East"}
      conference_standings_called = false
      mock_standings = Collection.new([])

      # Mock fetch_conference_standings since it will be called
      Standings.stub(:conference, lambda { |*|
        conference_standings_called = true
        mock_standings
      }) do
        fetch_standings
      end

      assert conference_standings_called
    end

    def test_does_not_pass_season_keyword_when_nil
      @options = {}
      season_keyword_received = false
      mock_method = lambda { |**kwargs|
        season_keyword_received = kwargs.key?(:season)
        Collection.new([])
      }
      Standings.stub(:all, mock_method) do
        fetch_standings
      end

      refute season_keyword_received
    end

    def test_season_key_with_nil_value_does_not_pass_season
      # This kills mutation: options[:season] -> options.key?(:season)
      # When key exists but value is nil, options[:season] is falsy
      # but options.key?(:season) is true
      @options = {season: nil}
      season_keyword_received = false
      mock_method = lambda { |**kwargs|
        season_keyword_received = kwargs.key?(:season)
        Collection.new([])
      }
      Standings.stub(:all, mock_method) do
        fetch_standings
      end

      # With original code: options[:season] is nil (falsy), so else branch
      # With mutated code: options.key?(:season) is true, so season branch (wrong!)
      refute season_keyword_received
    end

    def test_season_key_with_false_value_does_not_pass_season
      # Another test to kill the same mutation
      @options = {season: false}
      season_keyword_received = false
      mock_method = lambda { |**kwargs|
        season_keyword_received = kwargs.key?(:season)
        Collection.new([])
      }
      Standings.stub(:all, mock_method) do
        fetch_standings
      end

      refute season_keyword_received
    end

    def test_conference_key_with_nil_value_does_not_call_conference_standings
      # This kills mutation: options[:conference] -> options.key?(:conference)
      @options = {conference: nil}
      all_called = false
      mock_all = lambda { |**|
        all_called = true
        Collection.new([])
      }
      Standings.stub(:all, mock_all) do
        fetch_standings
      end

      # With nil conference, should call Standings.all (not conference)
      assert all_called
    end

    def test_conference_key_with_false_value_does_not_call_conference_standings
      # Another test to kill the same mutation
      @options = {conference: false}
      all_called = false
      mock_all = lambda { |**|
        all_called = true
        Collection.new([])
      }
      Standings.stub(:all, mock_all) do
        fetch_standings
      end

      assert all_called
    end
  end
end
