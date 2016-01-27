module DS
  # Class implements directed graph
  class Digraph < Graph
    def initialize(edges, store = :list)
      case store
      when :list
        @g = GraphAsList.new(edges)
      when :matrix
        @g = GraphAsMatrix.new(edges)
      when :tri_matrix
        @g = GraphAsTriMatrix.new(edges)
      end
    end

    def self.new_dense(args)
      new(args, :matrix)
    end

    # Returns number of incoming edges to given vertex.
    def in_degree(x)
      @g.degree x, :in
    end

    # Returns number of outcoming edges to given vertex.
    def out_degree(x)
      @g.degree x, :out
    end
  end
end
