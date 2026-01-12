module NBA
  module DraftCombineDrillResultsTestHelper
    HEADERS = %w[
      TEMP_PLAYER_ID PLAYER_ID FIRST_NAME LAST_NAME PLAYER_NAME POSITION
      STANDING_VERTICAL_LEAP MAX_VERTICAL_LEAP LANE_AGILITY_TIME
      MODIFIED_LANE_AGILITY_TIME THREE_QUARTER_SPRINT BENCH_PRESS
    ].freeze

    ROW = [
      1_630_162, 1_630_162, "Victor", "Wembanyama", "Victor Wembanyama", "C",
      30.5, 37.0, 10.5, 10.2, 3.2, 12
    ].freeze
  end
end
