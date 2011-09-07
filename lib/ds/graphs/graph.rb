module DS
  class Graph

    Infinity = 1 << 64

    #Create new graph from array of edges. Second parameter determines
    #graph internal implementation: :list (Adjency List), :tri_matrix (Triangular
    #Matrix), :matrix (Matrix).
    def initialize(edges,store = :list)
      case store
      when :matrix
        @g = GraphAsMatrix.new(edges)
      when :tri_matrix
        @g = GraphAsTriMatrix.new(edges)
      else
        @g = GraphAsList.new(edges)
      end
    end

    #Create new graph from array of edges. Internally graph will be represented
    #by Triangular Matrix.
    def self.create(edges)
      new(edges,:tri_matrix) 
    end

    def add(x,y)
      @g.add(x,y)
    end

    def remove(x,y)
      @g.remove(x,y) 
    end

    def each_vertex &block
      @g.each_vertex &block
    end

    def each_edge &block
      @g.each_edge &block
    end

    def neighbors v
      @g.neighbors v
    end

    def bfs s
      colors = {}
      parents =  {}
      res = []
      d = {}
      q = Queue.new

      @g.each_vertex do |v|
        colors[v] = :white
        parents[v] = nil
        d[v] = Infinity
      end

      colors[s] = :white
      parents[s] = nil
      d[s] = 0

      q.enqueue s

      while !q.empty?
        u = q.dequeue 
        @g.neighbors(u).each do |v|
          if colors[v] === :white
            colors[v] = :grey
            d[v] = d[u] + 1
            parents[v] = u
            q.enqueue v
          end
        end
        colors[u] = :black
        res << u
      end
      res
    end

    def add_edges(edges)
      @g.add_edges(edges)
    end
    
    #Returns vertex degree. Second parameter determines direction - :in incoming
    #edges, :out - outcoming edges, :all - incoming and outcoming edges.
    def degree x
      @g.degree x
    end

    def edge? x,y
      @g.edge? x,y
    end

    def get_edge x, y
      @g.get_edge x,y
    end

    def vertex_size
      @g.vertex_size
    end

    def edge_size
      @g.vmax+1
    end
  end
end
