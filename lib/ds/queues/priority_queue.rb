module DS
  # Class implements Priority Queue
  class PriorityQueue
    # Create new priority queue. Internaly uses heap to store elements.
    def initialize
      if block_given?
        @store = BinaryHeap.new do |parent, child|
          yield parent.key, child.key
        end
      else
        @store = BinaryHeap.new { |parent, child| parent.key >= child.key }
      end
    end

    # Adds element to queue with given priority.
    def enqueue(x, priority)
      pair = Pair.new(priority, x)
      @store.insert(pair)
      self
    end

    alias_method :push, :enqueue

    # Removes element with highest priority from queue .
    def dequeue
      x = @store.shift
      if x
        x.value
      else
        x
      end
    end

    alias_method :shift, :dequeue

    # Returns element with highest priority.
    def peek
      @store.top.value
    end

    # Returns length of queue. If queue is empty returns 0.
    def length
      @store.length
    end

    alias_method :size, :length

    # Checks if queue is empty.
    def empty?
      @store.empty?
    end
  end
end
