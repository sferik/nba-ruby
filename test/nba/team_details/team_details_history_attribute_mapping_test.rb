require_relative "../../test_helper"

module NBA
  class TeamDetailsHistoryAttributeMappingTest < Minitest::Test
    cover TeamDetails

    def test_maps_all_identity_history_attributes
      stub_team_details_request

      record = TeamDetails.history(team: Team::GSW).first

      assert_equal Team::GSW, record.team_id
      assert_equal "Golden State", record.city
      assert_equal "Warriors", record.nickname
      assert_equal "22024", record.season_id
      assert_equal 2024, record.year
    end

    def test_maps_all_record_attributes
      stub_team_details_request

      record = TeamDetails.history(team: Team::GSW).first

      assert_equal 46, record.wins
      assert_equal 36, record.losses
      assert_in_delta 0.561, record.win_pct
      assert_equal 10, record.conf_rank
      assert_equal 3, record.div_rank
    end

    def test_maps_all_playoff_attributes
      stub_team_details_request

      record = TeamDetails.history(team: Team::GSW).first

      assert_equal 0, record.po_wins
      assert_equal 0, record.po_losses
      assert_equal 0, record.conf_count
      assert_equal 0, record.div_count
      assert_equal "N/A", record.nba_finals_appearance
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
