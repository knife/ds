module DS
  class GraphAsMatrix
    def initialize(edges)
      @store = Array2D.new
      @max = 0

      @map = OrderedSet.new # maps objects to matrix indexes.

      add_edges(edges)
    end

    # Adds new edges to graph.
    def add_edges(edges)
      for e in edges
        x = @map.push e.from
        y = @map.push e.to

        @store[x, y] = e.weight

        @max = [@max, x, y].max
      end
    end

    # Returns all neighbors for given vertex.
    def neighbors(v)
      n = []
      vertexes = @map.to_a
      v = @map.index(v)

      0.upto @max do |i|
        n << vertexes[i] if @store[v, i] > 0
      end
      n
    end

    # Removes conection between vertex x and y.
    def remove(x, y)
      v1 = @map.index(x)
      v2 = @map.index(y)

      vertexes = @map.to_a

      @store[v1, v2] = 0
      if (degree vertexes[@max]) == 0
        @max -= 1
      end
    end

    # Returns Edge(x,y) if exist.
    def get_edge(x, y)
      s = @map.index x
      t = @map.index y
      if @store[s, t] > 0
        Edge.new(x, y, @store[s, t])
      else
        nil
      end
    end

    # Checks if two elements are connected.
    def edge?(x, y)
      v1 = @map.index(x)
      v2 = @map.index(y)
      @store[v1, v2] > 0
    end

    # Returns vertex counter.
    def vertex_size
      @map.size
    end

    # Returns vertex degree. Second parameter determines direction - :in incoming
    # edges, :out - outcoming edges, :all - incoming and outcoming edges.
    def degree(x, direction = :all)
      x = @map.index(x)
      sum_in = 0
      sum_out = 0
      0.upto @max do |i|
        sum_in += 1 if @store[i, x] and @store[i, x] > 0
        sum_out += 1 if @store[x, i] and @store[x, i] > 0
      end

      case direction
      when :all
        sum_in + sum_out
      when :in
        sum_in
      when :out
        sum_out
      end
    end

    # Vertex iterator
    def each_vertex
      vertexes = @map.to_a
      (0..@max).each { |v| yield vertexes[v] }
    end

    # Edge iterator
    def each_edge
      vertexes = @map.to_a
      for v0 in 0..@max
        for v1 in 0..v0 - 1
          yield Edge.new(vertexes[v0], vertexes[v1], @store[v0, v1]) if @store[v0, v1] > 0
        end
      end
    end
  end
end
