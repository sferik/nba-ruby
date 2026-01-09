require_relative "../test_helper"

module NBA
  class FranchiseLeadersMissingKeysTest < Minitest::Test
    cover FranchiseLeaders

    def test_find_raises_key_error_when_team_id_missing
      response = {resultSets: [{name: "FranchiseLeaders", headers: %w[PTS_PERSON_ID], rowSet: [[201_939]]}]}
      stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)

      assert_raises(KeyError) { FranchiseLeaders.find(team: Team::GSW) }
    end

    def test_find_raises_key_error_when_points_fields_missing
      %w[PTS_PERSON_ID PTS_PLAYER PTS].each_with_index do |field, idx|
        response = {resultSets: [{name: "FranchiseLeaders", headers: headers_without(field), rowSet: [row_without_index(idx + 1)]}]}
        stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)

        assert_raises(KeyError) { FranchiseLeaders.find(team: Team::GSW) }
      end
    end

    def test_find_raises_key_error_when_assists_fields_missing
      %w[AST_PERSON_ID AST_PLAYER AST].each_with_index do |field, idx|
        response = {resultSets: [{name: "FranchiseLeaders", headers: headers_without(field), rowSet: [row_without_index(idx + 4)]}]}
        stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)

        assert_raises(KeyError) { FranchiseLeaders.find(team: Team::GSW) }
      end
    end

    def test_find_raises_key_error_when_rebounds_fields_missing
      %w[REB_PERSON_ID REB_PLAYER REB].each_with_index do |field, idx|
        response = {resultSets: [{name: "FranchiseLeaders", headers: headers_without(field), rowSet: [row_without_index(idx + 7)]}]}
        stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)

        assert_raises(KeyError) { FranchiseLeaders.find(team: Team::GSW) }
      end
    end

    def test_find_raises_key_error_when_blocks_fields_missing
      %w[BLK_PERSON_ID BLK_PLAYER BLK].each_with_index do |field, idx|
        response = {resultSets: [{name: "FranchiseLeaders", headers: headers_without(field), rowSet: [row_without_index(idx + 10)]}]}
        stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)

        assert_raises(KeyError) { FranchiseLeaders.find(team: Team::GSW) }
      end
    end

    def test_find_raises_key_error_when_steals_fields_missing
      %w[STL_PERSON_ID STL_PLAYER STL].each_with_index do |field, idx|
        response = {resultSets: [{name: "FranchiseLeaders", headers: headers_without(field), rowSet: [row_without_index(idx + 13)]}]}
        stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)

        assert_raises(KeyError) { FranchiseLeaders.find(team: Team::GSW) }
      end
    end

    private

    def all_headers
      %w[TEAM_ID PTS_PERSON_ID PTS_PLAYER PTS AST_PERSON_ID AST_PLAYER AST
        REB_PERSON_ID REB_PLAYER REB BLK_PERSON_ID BLK_PLAYER BLK
        STL_PERSON_ID STL_PLAYER STL]
    end

    def headers_without(header)
      all_headers.reject { |h| h.eql?(header) }
    end

    def full_row
      [Team::GSW, 201_939, "Stephen Curry", 23_668, 201_939, "Stephen Curry", 5845,
        600_015, "Nate Thurmond", 12_771, 2442, "Manute Bol", 2086,
        959, "Chris Mullin", 1360]
    end

    def row_without_index(index)
      row = full_row.dup
      row.delete_at(index)
      row
    end
  end
end
