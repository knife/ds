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
      unless @store[e]
        @store[e] = @size
        @size += 1
      end
      return @store[e]
    end

    # Returns element index.
    def index(e)
      @store[e]
    end

    def to_a
      arr = Array.new(@size)
      @store.each { |e, i| arr[i] = e }
      arr
    end
  end
end
