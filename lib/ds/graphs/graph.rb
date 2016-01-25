module DS
  # Graph class
  class Graph
    # Create new graph from array of edges. Second parameter determines
    # graph internal implementation: :list (Adjency List), :tri_matrix (Triangular
    # Matrix), :matrix (Matrix).
    def initialize(edges, store = :matrix)
      case store
      when :list
        @g = GraphAsList.new(edges)
      when :matrix
        @g = GraphAsMatrix.new(edges)
      when :tri_matrix
        @g = GraphAsTriMatrix.new(edges)
      end
    end

    # Create new graph from array of edges. Internally graph will be represented
    # by Triangular Matrix.
    def self.create(edges)
      new(edges, :tri_matrix)
    end

    # Adds new edge to graph.
    def add(x, y, weight = 1)
      e = Edge.new(x, y, weight)
      add_edges([e])
    end

    # Adds new edges to graph.
    def add_edges(edges)
      @g.add_edges(edges)
    end

    # Removes conection between vertex x and y.
    def remove(x, y)
      @g.remove(x, y)
    end

    # Returns all neighbors for given vertex.
    def neighbors(v)
      @g.neighbors v
    end

    # Returns vertex degree.
    def degree(x)
      @g.degree x
    end

    # Checks if two elements are connected.
    def edge?(x, y)
      @g.edge? x, y
    end

    # Returns Edge(x,y) if exist.
    def get_edge(x, y)
      @g.get_edge x, y
    end

    def vertex_size
      @g.vertex_size
    end

    def each_vertex(&block)
      @g.each_vertex(&block)
    end

    def each_edge(&block)
      @g.each_edge(&block)
    end

    def bfs(s)
      colors = {}
      parents = {}
      visited = []
      d = {}
      q = Queue.new

      @g.each_vertex do |v|
        colors[v] = :white
        parents[v] = nil
        d[v] = Float::INFINITY
      end

      colors[s] = :white
      parents[s] = nil
      d[s] = 0

      q.enqueue s

      until q.empty?
        u = q.dequeue
        @g.neighbors(u).each do |v|
          next unless colors[v] == :white
          colors[v] = :grey
          d[v] = d[u] + 1
          parents[v] = u
          q.enqueue v
        end
        colors[u] = :black
        visited << u
      end
      visited
    end
  end
end
