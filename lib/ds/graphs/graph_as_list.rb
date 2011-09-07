module DS
  class GraphAsList

    def initialize
      @store = {}	 # the graph // {node => { edge1 => weight, edge2 => weight}, node2 => ...
      @nodes = Array.new		 
      @INFINITY = 1 << 64 	 
    end

    def add_edge(x,y,w=nil) 		# s= source, t= target, w= weight
      if (not @store.has_key?(x))	 
        @store[x] = {y=>w}		 
      else
        @store[x][y] = w         
      end

      # Begin code for non directed graph (inserts the other edge too)

      if (not @store.has_key?(y))
        @store[y] = {x=>w}
      else
        @store[y][x] = w
      end

      # End code for non directed graph (ie. deleteme if you want it directed)

      if (not @nodes.include?(x))	
        @nodes << x
      end
      if (not @nodes.include?(y))
        @nodes << y
      end	
    end

    def add_edges(edges)
      for e in edges
        add(e.from,e.to)   
      end    
    end

    def each_vertex
      @adj_matrix.keys.each do |vertex|
        yield vertex
      end
    end

  end
end
