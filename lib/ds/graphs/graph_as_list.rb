module DS
  # Graph implemented as Adjency List
  class GraphAsList
    attr_accessor :undirected
    def initialize(opts={})
      @store = []
      @undirected = opts[:undirected] || false
    end

    # Adds new edges to graph.
    def add(x, y, weight)
      @store[x] ||= []
      @store[x].push v: y, weight: weight
      if undirected
        @store[y] ||= []
        @store[y].push v: x, weight: weight
      end
    end

    # Removes conection between vertex x and y.
    def remove(x, y)
      @store[x].delete_if { |edge| edge[:v] == y }
      @store[y].delete_if { |edge| edge[:v] == x } if undirected
    end

    # Checks if two elements are connected.
    def edge?(x, y)
      connected?(x, y)
    end

    # Returns Edge(x,y) if exist.
    def get_edge(x, y)
      edge = connected?(x, y)
      edge[:weight] if edge
    end

    # Returns all neighbors for given vertex.
    def neighbors(x)
      @store[x].map { |edge| edge[:v] }
    end

    # Returns vertex degree. Second parameter determines direction - :in incoming
    # edges, :out - outcoming edges, :all - incoming and outcoming edges.
    def degree(x, direction = :all)
      r = Hash.new(0)
      vc = (0..@store.size)
      vc.each do |i|
        r[:in] += 1 if  connected?(i, x)
        r[:out] += 1 if connected?(x, i)
      end
      r[:all] = r[:in] + r[:out]
      return r[direction] / 2 if undirected 
      r[direction]
    end

    def each_edge(vertexes)
      @store.each_with_index do |list, i|
        list.each do |vertex|
          j = vertex[:v]
          next if i < j and undirected
          w = get_edge(i, j)
          yield Edge.new(vertexes[i], vertexes[j], w) if w
        end
      end
    end

    private

    def connected?(x, y)
      @store[x] && @store[x].find { |edge| edge[:v] == y }
    end
  end
end
