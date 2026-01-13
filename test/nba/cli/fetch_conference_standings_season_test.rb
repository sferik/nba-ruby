require_relative "test_helper"

module NBA
  class FetchConferenceStandingsSeasonTest < Minitest::Test
    include CLI::Helpers

    cover CLI::Helpers

    def options
      @options ||= {}
    end

    def test_season_key_with_nil_value_does_not_pass_season
      # This kills mutation: options[:season] -> options.key?(:season)
      @options = {conference: "East", season: nil}
      season_keyword_received = false
      mock_method = lambda { |_conf, **kwargs|
        season_keyword_received = kwargs.key?(:season)
        Collection.new([])
      }
      Standings.stub(:conference, mock_method) do
        fetch_conference_standings
      end

      # When season is nil (falsy), should not pass season keyword
      refute season_keyword_received
    end

    def test_season_key_with_false_value_does_not_pass_season
      # Another test to kill the same mutation
      @options = {conference: "East", season: false}
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
  end
end
