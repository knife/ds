module DS
  # OrderedSet Class
  class OrderedSet
    attr_reader :size

    # Creates new Ordered Set.
    def initialize
      @size = 0
      @store = {}
    end

    # Adds new element to set
    def push(e)
      index = @store[e]
      return index if index

      @size += 1
      @store[e] = @size - 1
    end

    # Returns element index.
    def index(e)
      @store[e]
    end

    def to_a
      @store.sort { |a, b| a[1] <=> b[1] }.map(&:first)
    end
  end
end
