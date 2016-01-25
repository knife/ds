module DS
  # Graph implemented as Triangular Matrix
  class GraphAsTriMatrix < GraphAsMatrix
    def initialize(edges)
      @store = TriMatrix.new(0)
      @map = OrderedSet.new
      add_edges(edges)
    end

    # Returns vertex degree.
    def degree(x)
      x = @map.index(x)
      sum = 0
      vc.each do |i|
        sum += @store[x, i] if @store[x, i]
      end
      sum
    end
  end
end
