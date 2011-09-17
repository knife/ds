module DS
  class OrderedSet

    def initialize
      @size = 0
      @store = {}
    end

    def push e
      if index = @store[e]
        index
      else
        @size = @size+1
        @store[e] = @size-1
      end
    end

    def index e
      @store[e]
    end

    def to_a
      @store.sort{|a,b| a[1]<=>b[1]}.map{|e| e.first}
    end

  end
end
