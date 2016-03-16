module DS
  # Class implements Priority Queue
  class PriorityQueue
    # Create new priority queue. Internaly uses heap to store elements.
    def initialize(*args)
      if block_given?
        @store = BinaryHeap.new(*args) do |parent, child|
          yield parent.key, child.key
        end
      else
        @store = BinaryHeap.new(*args) { |parent, child| parent.key >= child.key }
      end
    end

    # Adds element to queue with given priority.
    def enqueue(x, priority)
      pair = Pair.new(priority, x)
      @store.insert(pair)
      self
    end

    alias push enqueue

    # Removes element with highest priority from queue .
    def dequeue
      x = @store.shift
      x ? x.value : nil
    end

    alias shift dequeue

    # Returns element with highest priority.
    def peek
      @store.top.value
    end

    # Returns length of queue. If queue is empty returns 0.
    def length
      @store.length
    end

    alias size length

    # Checks if queue is empty.
    def empty?
      @store.empty?
    end
  end
end
