require_relative "box_score_v3_traditional_test_helpers"
require_relative "box_score_v3_advanced_test_helpers"
require_relative "box_score_v3_supplementary_test_helpers"

module NBA
  module BoxScoreV3TestHelpers
    include BoxScoreV3TraditionalTestHelpers
    include BoxScoreV3AdvancedTestHelpers
    include BoxScoreV3SupplementaryTestHelpers
  end
end
