module DS
  # IndexedSet Class
  class IndexedSet
    attr_reader :size

    # Creates new Ordered Set.
    def initialize
      @size = 0
      @store = {}
      @cache = []
    end

    # Adds new element to set
    def push(e)
      unless @store[e]
        index = size
        @store[e] = index
        @size += 1
        @cache[index] = e
      end
      @store[e]
    end

    # Returns element index.
    def index(e)
      @store[e]
    end

    def to_a
      @cache
    end
  end
end
