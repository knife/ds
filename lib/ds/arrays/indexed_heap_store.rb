module DS
  # HeapStore with constant access to any element
  class IndexedHeapStore < HeapStore

    def_delegators :@store, :[]

    def initialize(*args)
      args = args.to_a
      @map = {}
      args.each_with_index do |e, i|
        raise ArgumentError, 'Duplicates are not allowed' if @map[e.value]
        @map[e.value] = i + 1
      end
      @store = [nil] + args
    end

    def pop
      x = @store.pop
      @map.delete(x)
      x
    end

    def []=(i, x)
      @map[x.value] = i
      @store[i] = x
    end

    def push(x)
      return if @map[x.value]
      last = @store.size
      @store.push x
      @map[x.value] = last
    end

    def index(x)
      @map[x]
    end

    def get(x)
      self[index(x)] if index(x)
    end

    def swap(x, y)
      super
      @map[self[x].value] = x
      @map[self[y].value] = y
    end
  end
end
