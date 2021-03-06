require 'forwardable'

module DS
  # Simple Array-like data structure with indexing starting from one.
  class HeapStore
    extend Forwardable

    def_delegators :@store, :push, :pop, :[], :[]=

    def initialize(*args)
      @store = [nil] + args.to_a
    end

    def length
      @store.size - 1
    end

    def first
      @store[1]
    end

    alias size length

    def empty?
      length <= 0
    end

    def to_a
      @store[1..-1]
    end

    def swap(x, y)
      temp = self[y]
      self[y] = self[x]
      self[x] = temp
    end
  end
end
