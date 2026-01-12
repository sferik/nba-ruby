require_relative "common_player_info_test_helpers"

module NBA
  class CommonPlayerInfoFieldEdgeCasesTest < Minitest::Test
    include CommonPlayerInfoTestHelpers

    cover CommonPlayerInfo

    def test_handles_undrafted_draft_year
      row = info_row.dup.tap { |r| r[16] = "Undrafted" }
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, row).to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).draft_year
    end

    def test_handles_undrafted_draft_round
      row = info_row.dup.tap { |r| r[17] = "Undrafted" }
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, row).to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).draft_round
    end

    def test_handles_undrafted_draft_number
      row = info_row.dup.tap { |r| r[18] = "Undrafted" }
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, row).to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).draft_number
    end

    def test_handles_nil_weight
      row = info_row.dup.tap { |r| r[8] = nil }
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, row).to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).weight
    end

    def test_handles_nil_draft_year
      row = info_row.dup.tap { |r| r[16] = r[17] = r[18] = nil }
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, row).to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939).draft_year
    end

    def test_handles_valid_draft_year_as_number
      row = info_row.dup.tap { |r| r[16] = 2009 }
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, row).to_json)

      assert_equal 2009, CommonPlayerInfo.find(player: 201_939).draft_year
    end

    def test_handles_zero_weight
      row = info_row.dup.tap { |r| r[8] = 0 }
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, row).to_json)

      assert_equal 0, CommonPlayerInfo.find(player: 201_939).weight
    end

    private

    def build_response(headers, row)
      {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
    end
  end
end
