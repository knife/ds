module DS
  # Indexed BinaryHeap
  class IndexedBinaryHeap < BinaryHeap
    # Create new IndexedHeap from args.
    # Given block is used to set heap relation.
    # Default heap relation is Max Heap.
    def initialize(*args, &block)
      @relation = if block_given?
                    block
                  else
                    -> (parent, child) { parent.key >= child.key }
                  end
      @store = IndexedHeapStore.new(*args)
      heapify!
    end

    def change_priority(x, priority)
      node = get(x)
      old_priority = node.key
      return if old_priority == priority

      node.key = priority
      index = store.index(node.value)

      if higher?(priority, old_priority)
        swim(index)
      else
        sink(index)
      end
    end

    def get(x)
      store.get(x)
    end

    def include?(x)
      get(x) ? true : false
    end

    private

    def higher?(new_priority, old_priority)
      @relation.call(Pair.new(new_priority, nil), Pair.new(old_priority, nil))
    end
  end
end
