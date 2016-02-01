module DS
  # Class implements directed graph
  class Digraph < Graph
    def initialize(edges, store = :list)
      @map = IndexedSet.new
      case store
      when :list
        @g = GraphAsList.new
      when :matrix
        @g = GraphAsMatrix.new
      end
      add_edges(edges)
    end

    def self.new_dense(args)
      new(args, :matrix)
    end

    # Returns number of incoming edges to given vertex.
    def in_degree(x)
      @g.degree index(x), :in
    end

    # Returns number of outcoming edges to given vertex.
    def out_degree(x)
      @g.degree index(x), :out
    end
  end
end
