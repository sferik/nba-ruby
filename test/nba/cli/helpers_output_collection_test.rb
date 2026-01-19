require_relative "test_helper"

module NBA
  class HelpersOutputCollectionTest < Minitest::Test
    include CLITestHelper
    include CLI::Helpers

    cover CLI::Helpers

    def test_output_collection_outputs_json_when_format_is_json
      collection = Collection.new([Standing.new(team_id: 1, wins: 10, losses: 5)])
      @options = {format: "json"}

      output_collection(collection) { raise "Block should not be called" }

      assert_includes stdout_output, "team_id"
    end

    def test_output_collection_outputs_csv_when_format_is_csv
      collection = Collection.new([Standing.new(team_id: 1, wins: 10, losses: 5)])
      @options = {format: "csv"}

      output_collection(collection) { raise "Block should not be called" }

      assert_includes stdout_output, "team_id"
      assert_includes stdout_output, "wins"
    end

    def test_output_collection_calls_block_when_format_is_table
      collection = Collection.new([Standing.new(team_id: 1, wins: 10, losses: 5)])
      @options = {format: "table"}
      block_called = false

      output_collection(collection) { block_called = true }

      assert block_called
    end

    def test_output_collection_calls_block_when_format_is_nil
      collection = Collection.new([Standing.new(team_id: 1, wins: 10, losses: 5)])
      @options = {}
      block_called = false

      output_collection(collection) { block_called = true }

      assert block_called
    end

    private

    def options
      @options || {}
    end

    def say(message)
      puts message
    end
  end
end
