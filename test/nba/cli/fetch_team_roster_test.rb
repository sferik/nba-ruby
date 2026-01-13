require_relative "test_helper"

module NBA
  class FetchTeamRosterTest < Minitest::Test
    include CLI::Helpers

    cover CLI::Helpers

    def options = @options ||= {}

    def test_passes_team_to_roster
      team = Team.new(full_name: "Test Team")
      received = stub_and_capture(:team) { |m| Roster.stub(:find, m) { fetch_team_roster(team) } }

      assert_equal team, received
    end

    def test_passes_season_when_provided
      @options = {season: 2023}
      received = stub_and_capture(:season) { |m| Roster.stub(:find, m) { fetch_team_roster(test_team) } }

      assert_equal 2023, received
    end

    def test_does_not_pass_season_when_nil
      has_season = stub_and_check(:season) { |m| Roster.stub(:find, m) { fetch_team_roster(test_team) } }

      refute has_season
    end

    def test_passes_team_when_season_provided
      @options = {season: 2023}
      team = Team.new(full_name: "Test Team")
      received = stub_and_capture(:team) { |m| Roster.stub(:find, m) { fetch_team_roster(team) } }

      assert_equal team, received
    end

    private

    def test_team = Team.new(full_name: "Test Team")

    def stub_and_capture(key)
      (r = nil
       yield(lambda { |**kw|
         r = kw[key]
         Collection.new([])
       })
       r)
    end

    def stub_and_check(key)
      (f = false
       yield(lambda { |**kw|
         f = kw.key?(key)
         Collection.new([])
       })
       f)
    end
  end
end
