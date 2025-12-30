require "equalizer"

module NBA
  # Represents a collection of objects
  class Collection
    include Equalizer.new(:elements)
    include Enumerable

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
    # @return [Enumerator, Array] an enumerator or the result of the block
    def each(&)
      elements.each(&)
    end

    # Returns the number of elements in the collection
    #
    # @api public
    # @example
    #   collection.size #=> 30
    # @return [Integer] the number of elements
    def size
      elements.size
    end

    alias_method :length, :size
    alias_method :count, :size
  end
end
