require_relative "common_player_info_test_helpers"

module NBA
  class CommonPlayerInfoTypeConversionTest < Minitest::Test
    include CommonPlayerInfoTestHelpers

    cover CommonPlayerInfo

    def test_weight_returned_as_integer_when_string
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, info_row).to_json)
      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal 185, info.weight
      assert_kind_of Integer, info.weight
    end

    def test_draft_year_returned_as_integer_when_string
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, info_row).to_json)
      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal 2009, info.draft_year
      assert_kind_of Integer, info.draft_year
    end

    def test_draft_round_returned_as_integer_when_string
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, info_row).to_json)
      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal 1, info.draft_round
      assert_kind_of Integer, info.draft_round
    end

    def test_draft_number_returned_as_integer_when_string
      stub_request(:get, /commonplayerinfo/).to_return(body: build_response(info_headers, info_row).to_json)
      info = CommonPlayerInfo.find(player: 201_939)

      assert_equal 7, info.draft_number
      assert_kind_of Integer, info.draft_number
    end
  end
end
