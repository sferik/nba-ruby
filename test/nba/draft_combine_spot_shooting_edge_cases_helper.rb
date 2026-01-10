require_relative "../test_helper"

module NBA
  module DraftCombineSpotShootingEdgeCasesHelper
    def headers
      %w[PLAYER_ID PLAYER_NAME FIRST_NAME LAST_NAME POSITION]
    end

    def row
      [1_630_162, "Victor Wembanyama", "Victor", "Wembanyama", "C"]
    end
  end
end
