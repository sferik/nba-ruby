require_relative "../test_helper"

module NBA
  class TeamDetailsMissingKeyErrorTest < Minitest::Test
    cover TeamDetails

    def test_find_raises_key_error_when_team_id_missing
      response = {resultSets: [{name: "TeamBackground", headers: %w[ABBREVIATION], rowSet: [["GSW"]]}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_raises(KeyError) { TeamDetails.find(team: Team::GSW) }
    end

    def test_find_raises_key_error_when_abbreviation_missing
      response = {resultSets: [{name: "TeamBackground", headers: %w[TEAM_ID], rowSet: [[Team::GSW]]}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_raises(KeyError) { TeamDetails.find(team: Team::GSW) }
    end

    def test_history_raises_key_error_when_po_wins_missing
      response = {resultSets: [{name: "TeamHistory", headers: history_headers_without_po_wins, rowSet: [history_row_without_po_wins]}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_raises(KeyError) { TeamDetails.history(team: Team::GSW) }
    end

    def test_history_raises_key_error_when_po_losses_missing
      response = {resultSets: [{name: "TeamHistory", headers: history_headers_without_po_losses, rowSet: [history_row_without_po_losses]}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_raises(KeyError) { TeamDetails.history(team: Team::GSW) }
    end

    def test_history_raises_key_error_when_conf_count_missing
      response = {resultSets: [{name: "TeamHistory", headers: history_headers_without_conf_count,
                                rowSet: [history_row_without_conf_count]}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_raises(KeyError) { TeamDetails.history(team: Team::GSW) }
    end

    def test_history_raises_key_error_when_div_count_missing
      response = {resultSets: [{name: "TeamHistory", headers: history_headers_without_div_count, rowSet: [history_row_without_div_count]}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_raises(KeyError) { TeamDetails.history(team: Team::GSW) }
    end

    def test_history_raises_key_error_when_nba_finals_appearance_missing
      response = {resultSets: [{name: "TeamHistory", headers: history_headers_without_nba_finals,
                                rowSet: [history_row_without_nba_finals]}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_raises(KeyError) { TeamDetails.history(team: Team::GSW) }
    end

    private

    def history_headers_without_po_wins
      %w[TEAM_ID CITY NICKNAME SEASON_ID YEAR WINS LOSSES WIN_PCT CONF_RANK DIV_RANK
        PO_LOSSES CONF_COUNT DIV_COUNT NBA_FINALS_APPEARANCE]
    end

    def history_row_without_po_wins
      [Team::GSW, "Golden State", "Warriors", "22024", 2024, 46, 36, 0.561, 10, 3,
        0, 0, 0, "N/A"]
    end

    def history_headers_without_po_losses
      %w[TEAM_ID CITY NICKNAME SEASON_ID YEAR WINS LOSSES WIN_PCT CONF_RANK DIV_RANK
        PO_WINS CONF_COUNT DIV_COUNT NBA_FINALS_APPEARANCE]
    end

    def history_row_without_po_losses
      [Team::GSW, "Golden State", "Warriors", "22024", 2024, 46, 36, 0.561, 10, 3,
        0, 0, 0, "N/A"]
    end

    def history_headers_without_conf_count
      %w[TEAM_ID CITY NICKNAME SEASON_ID YEAR WINS LOSSES WIN_PCT CONF_RANK DIV_RANK
        PO_WINS PO_LOSSES DIV_COUNT NBA_FINALS_APPEARANCE]
    end

    def history_row_without_conf_count
      [Team::GSW, "Golden State", "Warriors", "22024", 2024, 46, 36, 0.561, 10, 3,
        0, 0, 0, "N/A"]
    end

    def history_headers_without_div_count
      %w[TEAM_ID CITY NICKNAME SEASON_ID YEAR WINS LOSSES WIN_PCT CONF_RANK DIV_RANK
        PO_WINS PO_LOSSES CONF_COUNT NBA_FINALS_APPEARANCE]
    end

    def history_row_without_div_count
      [Team::GSW, "Golden State", "Warriors", "22024", 2024, 46, 36, 0.561, 10, 3,
        0, 0, 0, "N/A"]
    end

    def history_headers_without_nba_finals
      %w[TEAM_ID CITY NICKNAME SEASON_ID YEAR WINS LOSSES WIN_PCT CONF_RANK DIV_RANK
        PO_WINS PO_LOSSES CONF_COUNT DIV_COUNT]
    end

    def history_row_without_nba_finals
      [Team::GSW, "Golden State", "Warriors", "22024", 2024, 46, 36, 0.561, 10, 3,
        0, 0, 0, 0]
    end
  end
end
