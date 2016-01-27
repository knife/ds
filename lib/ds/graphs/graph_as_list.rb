module DS
  # Graph implemented as Adjency List
  class GraphAsList
    def initialize(edges)
      @store = []
      @map = IndexedSet.new # maps objects to matrix indexes.

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
        @store[x] ||= []
        @store[x].push v: y, weight: e.weight
      end
    end

    # Returns all neighbors for given vertex.
    def neighbors(v)
      v = @map.index(v)
      @store[v].map { |edge| vertexes[edge[:v]] }
    end

    # Removes conection between vertex x and y.
    def remove(x, y)
      v1 = @map.index(x)
      v2 = @map.index(y)

      @store[v1].delete_if { |edge| edge[:v] == v2 }
    end

    # Returns Edge(x,y) if exist.
    def get_edge(x, y)
      s = @map.index x
      t = @map.index y
      edge = connected?(s, t)
      Edge.new(x, y, edge[:weight]) if edge
    end

    # Checks if two elements are connected.
    def edge?(x, y)
      v1 = @map.index(x)
      v2 = @map.index(y)
      connected?(v1, v2)
    end

    # Returns vertex degree. Second parameter determines direction - :in incoming
    # edges, :out - outcoming edges, :all - incoming and outcoming edges.
    def degree(x, direction = :all)
      x = @map.index(x)
      r = Hash.new(0)
      vc.each do |i|
        r[:in] += 1 if  connected?(i, x)
        r[:out] += 1 if connected?(x, i)
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
      @store.each_with_index do |edges, i|
        edges.each do |e|
          yield Edge.new(vertexes[i], vertexes[e[:v]], edge[:weight])
        end
      end
    end

    private

    def connected?(x, y)
      @store[x] && @store[x].find{ |edge| edge[:v] == y }
    end
  end
end
