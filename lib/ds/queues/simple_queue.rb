module DS
  # Class implements queue data structure.
  class SimpleQueue
    # Create new queue.
    # First parameter determines how the queue will be represented internally.
    def initialize(*args)
      if args.first.is_a? List
        @store = args.first
      else
        @store = args || []
      end
    end

    # Create new queue. Internaly uses list to store elements.
    def self.create(*args)
      new(List.new(*args))
    end

    # Adds element to queue and returns queue itself.
    def enqueue(x)
      store << x
      self
    end

    alias push enqueue

    # Removes element from queue and returns it.
    def dequeue
      store.shift
    end

    alias shift dequeue

    # Returns element from forehead of queue.
    def peek
      store.first
    end

    # Returns length of queue. If queue is empty returns 0.
    def length
      store.length
    end

    alias size length

    # Checks if queue is empty.
    def empty?
      store.empty?
    end

    private

    attr_accessor :store
  end
end
