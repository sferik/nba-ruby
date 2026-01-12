require_relative "../../test_helper"

module NBA
  class TeamDetailsHistoryTest < Minitest::Test
    cover TeamDetails

    def test_history_returns_collection
      stub_team_details_request

      result = TeamDetails.history(team: Team::GSW)

      assert_instance_of Collection, result
    end

    def test_history_uses_correct_team_id_in_path
      stub_team_details_request

      TeamDetails.history(team: Team::GSW)

      assert_requested :get, /teamdetails.*TeamID=#{Team::GSW}/o
    end

    def test_history_parses_historical_records_successfully
      stub_team_details_request

      records = TeamDetails.history(team: Team::GSW)

      assert_equal 1, records.size
      assert_equal Team::GSW, records.first.team_id
    end

    def test_history_accepts_team_object
      stub_team_details_request
      team = Team.new(id: Team::GSW)

      records = TeamDetails.history(team: team)

      assert_equal 1, records.size
    end

    private

    def stub_team_details_request
      stub_request(:get, /teamdetails/).to_return(body: team_details_response.to_json)
    end

    def team_details_response
      {resultSets: [
        {name: "TeamBackground", headers: [], rowSet: []},
        {name: "TeamHistory", headers: history_headers, rowSet: [history_row]}
      ]}
    end

    def history_headers
      %w[TEAM_ID CITY NICKNAME SEASON_ID YEAR WINS LOSSES WIN_PCT CONF_RANK DIV_RANK
        PO_WINS PO_LOSSES CONF_COUNT DIV_COUNT NBA_FINALS_APPEARANCE]
    end

    def history_row
      [Team::GSW, "Golden State", "Warriors", "22024", 2024, 46, 36, 0.561, 10, 3,
        0, 0, 0, 0, "N/A"]
    end
  end
end
