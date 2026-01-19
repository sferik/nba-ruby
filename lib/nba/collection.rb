require "equalizer"
require "forwardable"

module NBA
  # Represents a collection of objects
  class Collection
    extend Forwardable
    include Equalizer.new(:elements)
    include Enumerable

    # @!method size
    #   Returns the number of elements in the collection
    #   @api public
    #   @example
    #     collection.size #=> 3
    #   @return [Integer] the number of elements

    # @!method empty?
    #   Returns true if the collection has no elements
    #   @api public
    #   @example
    #     collection.empty? #=> false
    #   @return [Boolean] true if empty, false otherwise

    # @!method first
    #   Returns the first element in the collection
    #   @api public
    #   @example
    #     collection.first #=> player1
    #   @return [Object, nil] the first element or nil if empty

    # @!method last
    #   Returns the last element in the collection
    #   @api public
    #   @example
    #     collection.last #=> player3
    #   @return [Object, nil] the last element or nil if empty

    # @!method length
    #   Returns the number of elements in the collection
    #   @api public
    #   @example
    #     collection.length #=> 3
    #   @return [Integer] the number of elements

    # @!method count
    #   Returns the number of elements in the collection
    #   @api public
    #   @example
    #     collection.count #=> 3
    #   @return [Integer] the number of elements

    def_delegators :elements, :size, :empty?, :first, :last

    alias_method :length, :size
    alias_method :count, :size

    # Returns the elements in the collection
    #
    # @api private
    # @return [Array] the elements
    attr_reader :elements

    # Initializes a new Collection
    #
    # @api public
    # @example
    #   collection = NBA::Collection.new([player1, player2])
    # @param elements [Array] the elements in the collection
    # @return [NBA::Collection] a new collection instance
    def initialize(elements = [])
      @elements = elements
    end

    # Iterates over the elements in the collection
    #
    # @api public
    # @example
    #   collection.each { |element| puts element }
    # @yield [element] yields each element to the block
    # @return [Enumerator, self] an enumerator or self
    def each(&block)
      return enum_for unless block

      elements.each(&block)
      self
    end

    # Returns the maximum value of a stat across all elements
    #
    # @api public
    # @example
    #   game_logs.maximum(:pts) #=> 61
    # @param stat [Symbol] the stat attribute name
    # @return [Numeric, nil] the maximum value, or nil if empty
    def maximum(stat)
      stat_values(stat).max
    end

    # Returns the minimum value of a stat across all elements
    #
    # @api public
    # @example
    #   game_logs.minimum(:pts) #=> 8
    # @param stat [Symbol] the stat attribute name
    # @return [Numeric, nil] the minimum value, or nil if empty
    def minimum(stat)
      stat_values(stat).min
    end

    # Returns the sum of a stat across all elements
    #
    # @api public
    # @example
    #   game_logs.total(:pts) #=> 2024
    # @param stat [Symbol] the stat attribute name
    # @return [Numeric] the total value
    def total(stat)
      stat_values(stat).sum
    end

    # Returns the average value of a stat across all elements
    #
    # @api public
    # @example
    #   game_logs.average(:pts) #=> 26.4
    # @param stat [Symbol] the stat attribute name
    # @return [Float, nil] the average value, or nil if empty
    def average(stat)
      values = stat_values(stat)
      return if values.empty?

      values.sum.to_f / values.size
    end

    alias_method :mean, :average

    # Returns the variance of a stat across all elements
    #
    # @api public
    # @example
    #   game_logs.variance(:pts) #=> 64.5
    # @param stat [Symbol] the stat attribute name
    # @return [Float, nil] the variance, or nil if empty
    def variance(stat)
      values = stat_values(stat)
      return if values.empty?

      avg = values.sum.to_f / values.size
      sum_squared_diff = values.sum { |v| (v - avg)**2 }
      sum_squared_diff / values.size
    end

    # Returns the standard deviation of a stat across all elements
    #
    # @api public
    # @example
    #   game_logs.standard_deviation(:pts) #=> 8.03
    # @param stat [Symbol] the stat attribute name
    # @return [Float, nil] the standard deviation, or nil if empty
    def standard_deviation(stat)
      var = variance(stat)
      return unless var

      Math.sqrt(var)
    end

    # Returns the z-score for a value relative to the stat distribution
    #
    # @api public
    # @example
    #   game_logs.z_score(:pts, 50) #=> 2.94
    # @param stat [Symbol] the stat attribute name
    # @param value [Numeric] the value to calculate the z-score for
    # @return [Float, nil] the z-score, or nil if std dev is zero/nil
    def z_score(stat, value)
      std_dev = standard_deviation(stat).to_f
      return unless std_dev.positive?

      avg = average(stat).to_f
      (value.to_f - avg) / std_dev
    end

    private

    # Extracts stat values from all elements
    #
    # @api private
    # @param stat [Symbol] the stat attribute name
    # @return [Array<Numeric>] the stat values
    def stat_values(stat)
      filter_map { |e| e.public_send(stat) }
    end
  end
end
