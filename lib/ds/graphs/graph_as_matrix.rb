module DS
  class GraphAsMatrix
    def initialize(edges)
      @store = Array2D.new
      @map = OrderedSet.new # maps objects to matrix indexes.

      add_edges(edges)
    end

    def vc
      (0...vertexes.size)
    end

    def vertexes
      @map.to_a
    end

    def vertex_size
      @map.size
    end

    # Adds new edges to graph.
    def add_edges(edges)
      edges.each do |e|
        x = @map.push e.from
        y = @map.push e.to

        @store[x, y] = e.weight
      end
    end

    # Returns all neighbors for given vertex.
    def neighbors(v)
      n = []
      v = @map.index(v)

      vc.each do |i|
        n << vertexes[i] if @store[v, i] > 0
      end
      n
    end

    # Removes conection between vertex x and y.
    def remove(x, y)
      v1 = @map.index(x)
      v2 = @map.index(y)

      @store[v1, v2] = 0
    end

    # Returns Edge(x,y) if exist.
    def get_edge(x, y)
      s = @map.index x
      t = @map.index y
      Edge.new(x, y, @store[s, t]) if @store[s, t] > 0
    end

    # Checks if two elements are connected.
    def edge?(x, y)
      v1 = @map.index(x)
      v2 = @map.index(y)
      @store[v1, v2] > 0
    end

    # Returns vertex degree. Second parameter determines direction - :in incoming
    # edges, :out - outcoming edges, :all - incoming and outcoming edges.
    def degree(x, direction = :all)
      x = @map.index(x)
      r = {}
      r[:in] = 0
      r[:out] = 0
      vc.each do |i|
        r[:in] += 1 if @store[i, x] && @store[i, x] > 0
        r[:out] += 1 if @store[x, i] && @store[x, i] > 0
      end
      r[:all] = r[:in] + r[:out]

      r[direction]
    end

    # Vertex iterator
    def each_vertex
      vc.each { |v| yield vertexes[v] }
    end

    # Edge iterator
    def each_edge
      vc.each do |v0|
        (0...v0).each do |v1|
          yield Edge.new(vertexes[v0], vertexes[v1], @store[v0, v1]) if @store[v0, v1] > 0
        end
      end
    end
  end
end
