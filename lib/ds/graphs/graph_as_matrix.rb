module DS
  class GraphAsMatrix

    def initialize(edges)
      @store = Array2D.new
      @max = 0

      @v = 0 #vertex count
       
      @map = [] #maps objects to matrix indexes.

      add_edges(edges)
    end

    #Checks if two elements are connected.
    def edge? x,y
      v1 = @map.index(x)
      v2 = @map.index(y)
      @store[v1,v2] > 0
    end

    #Adds new edges to graph.
    def add_edges(edges)
      for e in edges
        x = @map.push_uniq e.from
        y = @map.push_uniq e.to

        @store[x,y] = e.weight
        @max = [@max, x, y].max
        @v = @v +  1
      end
    end

    #Returns all neighbors for given vertex.
    def neighbors(v)
      n = []
      v = @map.index(v)
      0.upto @max do |i|
        n << @map[i] if @store[v,i] > 0
      end
      n
    end

    #Removes conection between vertex x and y.
    def remove(x,y)
      v1 = @map.index(x)
      v2 = @map.index(y)

      @store[v1,v2] = 0
      if (degree @map[@max]) == 0
        @max -= 1
      end
      @v -= 1
    end

    #Returns Edge(x,y) if exist.
    def get_edge x,y
      s = @map.index x
      t = @map.index y
      if @store[s,t] > 0
        Edge.new(@map[s], @map[t], @store[s,t])
      else
        nil
      end
    end

    def vmax
      @max
    end

    #Returns vertex counter.
    def vertex_size
      @v
    end


    #Returns vertex degree. Second parameter determines direction - :in incoming
    #edges, :out - outcoming edges, :all - incoming and outcoming edges.
    def degree(x,direction=:all)
      x = @map.index(x)
      sum_in = 0
      sum_out = 0
      0.upto @max do |i|
        sum_in += 1 if @store[i,x] and @store[i,x] > 0
        sum_out += 1 if @store[x,i]  and @store[x,i] > 0
      end

      case direction
      when :all
        sum_in+sum_out
      when :in
        sum_in
      when :out
        sum_out
      end
    end


    #Vertex iterator
    def each_vertex
      (0..@max).each {|v| yield @map[v]}
    end

    #Edge iterator
    def each_edge
      for v0 in 0..@max
        for v1 in 0..v0-1
          yield Edge.new(@map[v0],@map[v1],@store[v0,v1]) if @store[v0,v1] > 0
        end    
      end    
    end

  end
end
