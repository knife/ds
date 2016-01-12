module DS
  # Create new Heap from args.
  class BinaryHeap < CompleteBinaryTree
    attr_accessor :data

    # Create new Heap from args.
    # Given block sets the heap relation. Default heap relation is Max Heap.
    def initialize(*args, &block)
      if block_given?
        @relation = block
      else
        @relation = proc { |parent, child| parent >= child }
      end
      @data = args.to_a
      heapify!
    end

    # Create new Maximum Heap from args.
    def self.max(*args)
      new(*args) { |parent, child| parent >= child }
    end

    # Create new Minimum Heap from args.
    def self.min(*args)
      new(*args) { |parent, child| parent < child }
    end

    # Evaluates Heap relation.
    def relation(parent, child)
      @relation.call(@data[parent], @data[child])
    end

    # Arranges data in heap.
    # O(n)
    def heapify!
      (@data.size / 2).downto(0) do |i|
        heapify(i)
      end
    end

    # Maintains heap condition for i node.
    # O(log)
    def heapify(i)
      left = left_index(i)
      left = nil if left >= @data.size

      right = right_index(i)
      right = nil if right >= @data.size

      largest = [i, left, right].compact.sort { |x, y| relation(x, y) ? -1 : 1 }.first

      if largest != i
        temp = @data[i]
        @data[i] = @data[largest]
        @data[largest] = temp
        heapify(largest)
      end
    end

    # Removes element from heap maintaining heap relation.
    def shift
      if @data.size > 0
        result = @data.shift
        return result if @data.size.zero?
        @data.unshift @data.pop
        heapify(0)
      end
      result
    end

    # Inserts new value to heap maintaining the heap relation.
    # Returns heap itself.
    # O(log)
    def insert(value)
      @data.push value
      child = @data.size - 1
      parent = parent_index(child)

      while parent >= 0 && !relation(parent, child)
        temp = @data[child]
        @data[child] = @data[parent]
        @data[parent] = temp
        child = parent
        parent = parent_index(child)
      end
      self
    end

    def length
      @data.size
    end

    alias_method :size, :length

    def empty?
      @data.empty?
    end

    def to_a
      @data
    end
  end
end
