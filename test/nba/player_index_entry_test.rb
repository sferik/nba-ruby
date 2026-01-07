require_relative "../test_helper"

module NBA
  class PlayerIndexEntryTest < Minitest::Test
    cover PlayerIndexEntry

    def test_full_name_combines_first_and_last
      entry = PlayerIndexEntry.new(first_name: "Stephen", last_name: "Curry")

      assert_equal "Stephen Curry", entry.full_name
    end

    def test_full_name_strips_whitespace
      entry = PlayerIndexEntry.new(first_name: "Stephen", last_name: nil)

      assert_equal "Stephen", entry.full_name
    end

    def test_active_returns_true_when_roster_status_is_one
      entry = PlayerIndexEntry.new(roster_status: 1)

      assert_predicate entry, :active?
    end

    def test_active_returns_false_when_roster_status_is_zero
      entry = PlayerIndexEntry.new(roster_status: 0)

      refute_predicate entry, :active?
    end

    def test_active_returns_false_when_roster_status_is_nil
      entry = PlayerIndexEntry.new(roster_status: nil)

      refute_predicate entry, :active?
    end

    def test_defunct_returns_true_when_is_defunct_is_one
      entry = PlayerIndexEntry.new(is_defunct: 1)

      assert_predicate entry, :defunct?
    end

    def test_defunct_returns_false_when_is_defunct_is_zero
      entry = PlayerIndexEntry.new(is_defunct: 0)

      refute_predicate entry, :defunct?
    end

    def test_defunct_returns_false_when_is_defunct_is_nil
      entry = PlayerIndexEntry.new(is_defunct: nil)

      refute_predicate entry, :defunct?
    end

    def test_equality_based_on_id
      entry1 = PlayerIndexEntry.new(id: 201_939, first_name: "Stephen")
      entry2 = PlayerIndexEntry.new(id: 201_939, first_name: "Steph")

      assert_equal entry1, entry2
    end

    def test_inequality_when_ids_differ
      entry1 = PlayerIndexEntry.new(id: 201_939)
      entry2 = PlayerIndexEntry.new(id: 2544)

      refute_equal entry1, entry2
    end
  end
end
