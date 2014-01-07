module DS
  class PriorityQueue < Queue

    #Create new priority queue. Internaly uses heap to store elements.
    #
    # The definition of priority can be defined in a block given to this constructor.
    # Not providing a block is equivalent to providing the following block (higher
    # numbers mean more priority)
    #
    #    DS::PriorityQueue.new{|a,b| a >= b}
    #
    # Alternately, to provide lower priority
    #
    #    DS::PriorityQueue.new{|a,b| a <= b}
    #
    # Note that the ordering must be consistent, otherwise strange things may happen.
    # For instance the block should not define the following ordering:
    #
    #    rock > scissors
    #    scissors > paper
    #    paper > rock
    def initialize
      if block_given?
        @store = BinaryHeap.new do |parent,child|
          yield parent.key, child.key
        end
      else
        @store = BinaryHeap.new {|parent,child| parent.key >= child.key}
      end
    end


    #Adds element to queue with given priority.
    def enqueue x, priority
      pair = Pair.new(priority,x)
      @store.insert(pair)
      self
    end

    alias :push :enqueue

    #Removes element with highest priority from queue .
    def dequeue
      if x = @store.shift
        x.value
      else
        x
      end
    end

    alias :shift :dequeue

    #Returns element with highest priority.
    def peek
      @store.data.first.value
    end

  end
end
