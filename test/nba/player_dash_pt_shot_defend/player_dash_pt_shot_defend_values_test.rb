require_relative "../../test_helper"

module NBA
  class PlayerDashPtShotDefendValuesTest < Minitest::Test
    cover PlayerDashPtShotDefend

    def test_find_parses_d_fgm
      stub_request(:get, /playerdashptshotdefend/).to_return(body: defending_shots_response.to_json)

      assert_in_delta 3.5, PlayerDashPtShotDefend.find(player: 201_939).first.d_fgm
    end

    def test_find_parses_d_fga
      stub_request(:get, /playerdashptshotdefend/).to_return(body: defending_shots_response.to_json)

      assert_in_delta 8.2, PlayerDashPtShotDefend.find(player: 201_939).first.d_fga
    end

    def test_find_parses_d_fg_pct
      stub_request(:get, /playerdashptshotdefend/).to_return(body: defending_shots_response.to_json)

      assert_in_delta 0.427, PlayerDashPtShotDefend.find(player: 201_939).first.d_fg_pct
    end

    def test_find_parses_normal_fg_pct
      stub_request(:get, /playerdashptshotdefend/).to_return(body: defending_shots_response.to_json)

      assert_in_delta 0.485, PlayerDashPtShotDefend.find(player: 201_939).first.normal_fg_pct
    end

    def test_find_parses_pct_plusminus
      stub_request(:get, /playerdashptshotdefend/).to_return(body: defending_shots_response.to_json)

      assert_in_delta(-5.8, PlayerDashPtShotDefend.find(player: 201_939).first.pct_plusminus)
    end

    private

    def defending_shots_response
      {resultSets: [{name: "DefendingShots", headers: headers,
                     rowSet: [[201_939, 74, 74, "Overall", 0.15, 3.5, 8.2, 0.427, 0.485, -5.8]]}]}
    end

    def headers
      %w[CLOSE_DEF_PERSON_ID GP G DEFENSE_CATEGORY FREQ D_FGM D_FGA D_FG_PCT NORMAL_FG_PCT PCT_PLUSMINUS]
    end
  end
end
