require_relative "test_helper"

module NBA
  class ResolveLeaderCategoryTest < Minitest::Test
    include CLI::Helpers

    cover CLI::Helpers

    CATEGORY_MAP = {
      "PTS" => Leaders::PTS, "POINTS" => Leaders::PTS,
      "REB" => Leaders::REB, "REBOUNDS" => Leaders::REB,
      "AST" => Leaders::AST, "ASSISTS" => Leaders::AST
    }.freeze

    def test_returns_pts_constant_for_pts
      result = resolve_leader_category("PTS", CATEGORY_MAP)

      assert_equal Leaders::PTS, result
    end

    def test_returns_reb_constant_for_reb
      result = resolve_leader_category("REB", CATEGORY_MAP)

      assert_equal Leaders::REB, result
    end

    def test_returns_ast_constant_for_ast
      result = resolve_leader_category("AST", CATEGORY_MAP)

      assert_equal Leaders::AST, result
    end

    def test_converts_category_to_uppercase
      # Use a category where lowercase would fail to find in map
      # and default to PTS (which is different from expected)
      result = resolve_leader_category("reb", CATEGORY_MAP)

      # If upcase is removed, "reb" won't match "REB" in map,
      # so it would default to "PTS" instead of "REB"
      assert_equal Leaders::REB, result
    end

    def test_defaults_to_pts_for_unknown_category
      result = resolve_leader_category("UNKNOWN", CATEGORY_MAP)

      assert_equal Leaders::PTS, result
    end

    def test_uses_category_map_for_lookup
      # If category_map is nil, the lookup returns nil and falls back to PTS
      result = resolve_leader_category("REB", {})

      assert_equal Leaders::PTS, result
    end

    def test_resolves_full_name_to_constant
      result = resolve_leader_category("REBOUNDS", CATEGORY_MAP)

      assert_equal Leaders::REB, result
    end

    def test_returns_leaders_constant_value
      result = resolve_leader_category("PTS", CATEGORY_MAP)

      # Leaders::PTS is the string "PTS"
      assert_equal "PTS", result
      assert_kind_of String, result
    end
  end
end
