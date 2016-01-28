module DS
  # Graph implemented as Matrix
  class GraphAsMatrix
    def initialize
      @store = Array2D.new
    end

    def add(x, y, weight)
      @store[x, y] = weight
    end

    # Removes conection between vertex x and y.
    def remove(x, y)
      @store[x, y] = 0
    end

    # Checks if two elements are connected.
    def edge?(x, y)
      connected?(x, y)
    end

    # Returns Edge(x,y) if exist.
    def get_edge(x, y)
      @store[x, y]
    end

    # Returns all neighbors for given vertex.
    def neighbors(v)
      n = []
      vertexes.each { |i| n << i if connected?(v, i) }
      n
    end

    # Returns vertex degree. Second parameter determines direction - :in incoming
    # edges, :out - outcoming edges, :all - incoming and outcoming edges.
    def degree(x, direction = :all)
      r = Hash.new(0)
      vertexes.each do |i|
        r[:in] += 1 if connected?(i, x)
        r[:out] += 1 if connected?(x, i)
      end
      r[:all] = r[:in] + r[:out]
      r[direction]
    end

    # Edge iterator
    def each_edge(vertexes)
      size = vertexes.size
      (0...size).each do |v0|
        (0...size).each do |v1|
          yield Edge.new(vertexes[v0], vertexes[v1], @store[v0, v1]) if connected?(v0, v1)
        end
      end
    end

    private

    def connected?(x, y)
      @store[x, y] > 0
    end

    def vertexes
      (0..@store.size)
    end
  end
end
