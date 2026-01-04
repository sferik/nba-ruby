require_relative "box_score_v3_four_factors_misc_test_helpers"
require_relative "box_score_v3_scoring_usage_test_helpers"

module NBA
  module BoxScoreV3SupplementaryTestHelpers
    include BoxScoreV3FourFactorsMiscTestHelpers
    include BoxScoreV3ScoringUsageTestHelpers
  end
end
