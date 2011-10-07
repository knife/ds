module DS
  class PriorityQueue < Queue

    #Create new priority queue.Internaly uses list to store elements.
    def initialize
      @store = BinaryHeap.new {|parent,child| parent.key >= child.key}
    end

    #Adds element to queue with given priority.
    def enqueue x, priority
      pair = Pair.new(priority,x)
      @store.insert(pair)
      self
    end
    
    alias :push :enqueue

    #Removes element from queue with highest priority. 
    def dequeue 
      @store.shift.value
    end

    alias :shift :dequeue

    #Returns element with highest priority.
    def peek
      @store.data.first.value
    end

  end
end
