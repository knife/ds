module DS
  # Class implements Triangular Matrix (lower).
  class TriMatrix
    # Creates new triangular matrix.
    def initialize(init = 0)
      @store = ExpandableArray.new(0, init)
      @max = 0
    end

    # Returns element at index x,y (or y,x).
    def [](x, y)
      x, y = y, x if y > x
      index = (x * x + x) / 2 + y
      @store[index]
    end

    # Sets the element at index x,y (or y,x).
    def []=(x, y, v)
      x, y = y, x if y > x
      index = (x * x + x) / 2 + y
      @max = x if x > @max
      @store[index] = v
    end

    def to_a
      @store
    end

    def size
      @max 
    end
  end
end
