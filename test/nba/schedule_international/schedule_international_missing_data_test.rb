require_relative "../../test_helper"

module NBA
  class ScheduleInternationalMissingDataTest < Minitest::Test
    cover ScheduleInternational

    def test_handles_missing_home_team
      response = {leagueSchedule: {gameDates: [{games: [{gameDateTimeUTC: "2024-10-22T19:00:00Z",
                                                         gameId: "0022400001", homeTeam: nil, awayTeam: {}}]}]}}
      stub_request(:get, /scheduleleaguev2int/).to_return(body: response.to_json)

      game = ScheduleInternational.all.first

      assert_nil game.home_team_id
    end

    def test_handles_missing_away_team
      response = {leagueSchedule: {gameDates: [{games: [{gameDateTimeUTC: "2024-10-22T19:00:00Z",
                                                         gameId: "0022400001", homeTeam: {}, awayTeam: nil}]}]}}
      stub_request(:get, /scheduleleaguev2int/).to_return(body: response.to_json)

      game = ScheduleInternational.all.first

      assert_nil game.away_team_id
    end

    def test_handles_missing_away_team_key
      response = {leagueSchedule: {gameDates: [{games: [{gameDateTimeUTC: "2024-10-22T19:00:00Z",
                                                         gameId: "0022400001", homeTeam: {}}]}]}}
      stub_request(:get, /scheduleleaguev2int/).to_return(body: response.to_json)

      game = ScheduleInternational.all.first

      assert_nil game.away_team_id
    end

    def test_handles_missing_home_team_key
      response = {leagueSchedule: {gameDates: [{games: [{gameDateTimeUTC: "2024-10-22T19:00:00Z",
                                                         gameId: "0022400001", awayTeam: {}}]}]}}
      stub_request(:get, /scheduleleaguev2int/).to_return(body: response.to_json)

      game = ScheduleInternational.all.first

      assert_nil game.home_team_id
    end

    def test_handles_missing_broadcasters
      response = {leagueSchedule: {gameDates: [{games: [{gameDateTimeUTC: "2024-10-22T19:00:00Z",
                                                         gameId: "0022400001", homeTeam: {}, awayTeam: {},
                                                         broadcasters: nil}]}]}}
      stub_request(:get, /scheduleleaguev2int/).to_return(body: response.to_json)

      game = ScheduleInternational.all.first

      assert_nil game.broadcasters
    end

    def test_handles_empty_national_broadcasters
      response = {leagueSchedule: {gameDates: [{games: [{gameDateTimeUTC: "2024-10-22T19:00:00Z",
                                                         gameId: "0022400001", homeTeam: {}, awayTeam: {},
                                                         broadcasters: {nationalTvBroadcasters: []}}]}]}}
      stub_request(:get, /scheduleleaguev2int/).to_return(body: response.to_json)

      game = ScheduleInternational.all.first

      assert_nil game.broadcasters
    end

    def test_handles_nil_national_broadcasters
      response = {leagueSchedule: {gameDates: [{games: [{gameDateTimeUTC: "2024-10-22T19:00:00Z",
                                                         gameId: "0022400001", homeTeam: {}, awayTeam: {},
                                                         broadcasters: {nationalTvBroadcasters: nil}}]}]}}
      stub_request(:get, /scheduleleaguev2int/).to_return(body: response.to_json)

      game = ScheduleInternational.all.first

      assert_nil game.broadcasters
    end

    def test_handles_missing_game_date
      response = {leagueSchedule: {gameDates: [{games: [{gameId: "0022400001", homeTeam: {}, awayTeam: {}}]}]}}
      stub_request(:get, /scheduleleaguev2int/).to_return(body: response.to_json)

      game = ScheduleInternational.all.first

      assert_nil game.game_date
    end

    def test_handles_missing_game_id_key
      response = {leagueSchedule: {gameDates: [{games: [{gameDateTimeUTC: "2024-10-22T19:00:00Z", homeTeam: {}, awayTeam: {}}]}]}}
      stub_request(:get, /scheduleleaguev2int/).to_return(body: response.to_json)

      game = ScheduleInternational.all.first

      assert_nil game.game_id
    end

    def test_handles_missing_national_broadcasters_key
      response = {leagueSchedule: {gameDates: [{games: [{gameDateTimeUTC: "2024-10-22T19:00:00Z",
                                                         gameId: "0022400001", homeTeam: {}, awayTeam: {},
                                                         broadcasters: {}}]}]}}
      stub_request(:get, /scheduleleaguev2int/).to_return(body: response.to_json)

      game = ScheduleInternational.all.first

      assert_nil game.broadcasters
    end

    def test_handles_missing_broadcaster_display_key
      response = {leagueSchedule: {gameDates: [{games: [{gameDateTimeUTC: "2024-10-22T19:00:00Z",
                                                         gameId: "0022400001", homeTeam: {}, awayTeam: {},
                                                         broadcasters: {nationalTvBroadcasters: [{}]}}]}]}}
      stub_request(:get, /scheduleleaguev2int/).to_return(body: response.to_json)

      game = ScheduleInternational.all.first

      assert_equal "", game.broadcasters
    end
  end
end
