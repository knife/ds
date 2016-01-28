module DS
  # Graph implemented as Triangular Matrix
  class GraphAsTriMatrix < GraphAsMatrix
    def initialize
      @store = TriMatrix.new(0)
    end

    # Returns vertex degree.
    def degree(x)
      sum = 0
      vc = (0..@store.size)
      vc.each do |i|
        sum += @store[x, i] if @store[x, i]
      end
      sum
    end

    # Edge iterator
    def each_edge(vertexes)
      size = vertexes.size
      (0...size).each do |v0|
        (0...v0).each do |v1|
          yield Edge.new(vertexes[v0], vertexes[v1], @store[v0, v1]) if connected?(v0, v1)
        end
      end
    end
  end
end
