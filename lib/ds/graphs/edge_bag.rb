module DS
  # Bag for Edge objects
  class EdgeBag
    include Enumerable
    def initialize
      @store = []
    end

    def add(x, weight)
      @store.push v: x, weight: weight
    end

    def remove(x)
      @store.delete_if { |edge| edge[:v] == x }
    end

    def get(x)
      @store.find { |edge| edge[:v] == x }
    end

    def each(&block)
      @store.each(&block)
    end

    def size
      @store.size
    end
  end
end
