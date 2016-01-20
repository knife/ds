module DS
  # Create new Heap from args.
  class BinaryHeap
    attr_reader :store

    # Create new Heap from args.
    # Given block sets the heap relation. Default heap relation is Max Heap.
    def initialize(*args, &block)
      if block_given?
        @relation = block
      else
        @relation = -> (parent, child) { parent >= child }
      end
      @store = HeapStore.new(*args)
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
      @relation.call(store[parent], store[child])
    end

    # Arranges data in heap.
    # O(n)
    def heapify!
      (length / 2).downto(1) { |i| sink(i) }
    end

    # Removes element from heap maintaining heap relation.
    def shift
      if length > 0
        result = store.first
        swap(1, length)
        store.pop
        sink(1)
      end
      result
    end

    # Inserts new value to heap maintaining the heap relation.
    # Returns heap itself.
    # O(log)
    def insert(value)
      store.push value
      swim(length)
      self
    end

    def top
      store.first
    end

    def length
      store.length
    end

    alias_method :size, :length

    def empty?
      store.empty?
    end

    def to_a
      store.to_a
    end

    private

    def swim(k)
      while k > 1 && less(k / 2, k)
        swap(k, k / 2)
        k /= 2
      end
    end

    def sink(k)
      n = length
      while (2 * k <= n)
        j = 2 * k
        j += 1 if j < n && less(j, j + 1)
        break unless less(k, j)
        swap(k, j)
        k = j
      end
    end

    def less(x, y)
      !relation(x, y)
    end

    def swap(x, y)
      temp = store[y]
      store[y] = store[x]
      store[x] = temp
    end
  end
end
