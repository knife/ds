module DS
  # Class implements Stack data structure.
  # Internaly uses array or linked list to store elements.
  class Stack
    def initialize(*args)
      @store = if args.first.is_a? List
                 args.first
               else
                 args || []
               end
    end

    # Creates stack internally implemented as List
    def self.create(*args)
      new(List.new(*args))
    end

    # Returns the stack size.
    def size
      store.size
    end

    # Removes element from stack and returns it.
    def pop
      store.pop unless empty?
    end

    # Adds element on the top of the stack.
    def push(x)
      store.push x
    end

    # Returns element from the top of the stack.
    def peek
      store.last
    end

    # If stack is empty returns true otherwise returns false.
    def empty?
      store.empty?
    end

    protected

    attr_reader :store
  end
end
