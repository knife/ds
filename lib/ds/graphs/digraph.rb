module DS
  class Digraph < Graph
    def self.create(args)
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
