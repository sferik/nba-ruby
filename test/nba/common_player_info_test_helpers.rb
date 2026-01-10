require_relative "../test_helper"

module NBA
  module CommonPlayerInfoTestHelpers
    private

    def info_headers
      %w[PERSON_ID FIRST_NAME LAST_NAME DISPLAY_FIRST_LAST BIRTHDATE SCHOOL COUNTRY HEIGHT
        WEIGHT SEASON_EXP JERSEY POSITION TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY
        DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER FROM_YEAR TO_YEAR GREATEST_75_FLAG]
    end

    def info_row
      [201_939, "Stephen", "Curry", "Stephen Curry", "1988-03-14", "Davidson", "USA", "6-2",
        "185", 15, "30", "Guard", Team::GSW, "Warriors", "GSW", "Golden State",
        "2009", "1", "7", 2009, 2024, "Y"]
    end

    def build_response(headers, row)
      {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
    end
  end
end
