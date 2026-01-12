require_relative "../../test_helper"

module NBA
  module SynergyPlayTypesTestHelper
    private

    def stub_player_play_type_request
      stub_request(:get, /synergyplaytypes.*PlayType=Isolation.*PlayerOrTeam=Player/)
        .to_return(body: player_play_type_response("Isolation", "offensive").to_json)
    end

    def stub_team_play_type_request
      stub_request(:get, /synergyplaytypes.*PlayType=Transition.*PlayerOrTeam=Team/)
        .to_return(body: team_play_type_response("Transition", "offensive").to_json)
    end

    def player_play_type_response(_play_type, _type_grouping)
      {
        resultSets: [{
          name: "SynergyPlayType",
          headers: play_type_headers,
          rowSet: [player_play_type_row]
        }]
      }
    end

    def team_play_type_response(_play_type, _type_grouping)
      {
        resultSets: [{
          name: "SynergyPlayType",
          headers: play_type_headers,
          rowSet: [team_play_type_row]
        }]
      }
    end

    def play_type_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION GP
        POSS POSS_PCT PTS PTS_PCT FGM FGA FG_PCT EFG_PCT
        FT_POSS_PCT TOV_POSS_PCT SF_POSS_PCT PPP PERCENTILE]
    end

    def player_play_type_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 82,
        250, 0.085, 300, 0.095, 100, 200, 0.500, 0.575,
        0.120, 0.080, 0.140, 1.20, 95.0]
    end

    def team_play_type_row
      [nil, nil, Team::GSW, "GSW", 82,
        500, 0.150, 600, 0.180, 200, 400, 0.500, 0.575,
        0.120, 0.080, 0.140, 1.20, 90.0]
    end
  end
end
