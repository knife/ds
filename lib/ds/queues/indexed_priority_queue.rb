module DS
  # Indexed Priority Queue
  class IndexedPriorityQueue < PriorityQueue
    attr_reader :store
    private :store

    # Creates new IndexedPriorityQueue from args.
    # This is special form of PriorityQueue where you can
    # access any element and update its priority
    def initialize(*args)
      @store = if block_given?
                 IndexedBinaryHeap.new(*args) do |parent, child|
                   yield parent.key, child.key
                 end
               else
                 IndexedBinaryHeap.new(*args) { |parent, child| parent.key >= child.key }
               end
    end

    def update(x, priority)
      store.change_priority(x, priority)
    end

    def get(x)
      store.get(x)
    end

    def include?(x)
      store.include?(x)
    end
  end
end
