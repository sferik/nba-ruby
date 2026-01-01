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
  end
end
