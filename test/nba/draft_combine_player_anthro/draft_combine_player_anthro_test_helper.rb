module NBA
  module DraftCombinePlayerAnthroTestHelper
    HEADERS = %w[
      TEMP_PLAYER_ID PLAYER_ID FIRST_NAME LAST_NAME PLAYER_NAME POSITION
      HEIGHT_WO_SHOES HEIGHT_WO_SHOES_FT_IN HEIGHT_W_SHOES HEIGHT_W_SHOES_FT_IN
      WEIGHT WINGSPAN WINGSPAN_FT_IN STANDING_REACH STANDING_REACH_FT_IN
      BODY_FAT_PCT HAND_LENGTH HAND_WIDTH
    ].freeze

    ROW = [
      123_456, 1_630_162, "Victor", "Wembanyama", "Victor Wembanyama", "C",
      85.5, "7' 1.5\"", 86.5, "7' 2.5\"",
      209.0, 96.0, "8' 0\"", 114.5, "9' 6.5\"",
      4.8, 10.25, 12.0
    ].freeze
  end
end
