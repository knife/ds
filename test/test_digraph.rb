require 'help'

describe Digraph do
  describe 'without weighted edges' do
    before do
      edges = []
      edges << Edge.new('Lukas', 'Marc')
      edges << Edge.new('Lukas', 'Tom')
      edges << Edge.new('Marc', 'Jack')
      edges << Edge.new('Jack', 'Marc')
      edges << Edge.new('Tom', 'Marc')

      @digraph = Digraph.new(edges, :list)
    end

    it '#degree should return vertex degree.' do
      @digraph.degree('Marc').must_equal 4
      @digraph.degree('Tom').must_equal 2
      @digraph.degree('Lukas').must_equal 2
    end

    it '#in_degree should return number of incoming edges to the vertex.' do
      @digraph.in_degree('Marc').must_equal 3
      @digraph.in_degree('Tom').must_equal 1
      @digraph.in_degree('Lukas').must_equal 0
    end

    it '#out_degree should return number of outgoing edges from vertex.' do
      @digraph.out_degree('Marc').must_equal 1
      @digraph.out_degree('Tom').must_equal 1
      @digraph.out_degree('Lukas').must_equal 2
    end

    it '#get_edge should return graph edge.' do
      lukas_tom = @digraph.get_edge('Lukas', 'Tom')
      lukas_tom.from.must_equal 'Lukas'
      lukas_tom.to.must_equal 'Tom'
      lukas_tom.weight.must_equal 1
      lukas_tom.must_be_instance_of Edge
    end

    it '#edge? should check if two vertex are connected.' do
      refute @digraph.edge?('Marc', 'Tom')
      refute @digraph.edge?('Jack', 'Tom')
      refute @digraph.edge?('Tom', 'Lukas')
      assert @digraph.edge?('Tom', 'Marc')
      assert @digraph.edge?('Lukas', 'Marc')
    end

    it '#neighbors should return array containing all neighbors for given vertex.' do
      n = @digraph.neighbors('Tom')
      n.must_be_instance_of Array
      n.size.must_equal 1
      assert n.include?('Marc')
      refute n.include?('Lukas')
      refute n.include?('Jack')
    end

    it '#add_edge should add new edge.' do
      @digraph.add_edges([Edge.new('Marc', 'Kate')])
      @digraph.vertex_size.must_equal 5
      assert @digraph.edge?('Marc', 'Kate')
      refute @digraph.edge?('Kate', 'Marc')
      refute @digraph.edge?('Tom', 'Kate')
    end

    it '#remove_edge should remove edge.' do
      @digraph.remove('Marc', 'Jack')
      @digraph.vertex_size.must_equal 4
      refute @digraph.edge?('Marc', 'Jack')
      assert @digraph.edge?('Jack', 'Marc')
    end
  end

  describe 'with weighted edges' do
    before do
      edges = []

      edges << Edge.new(:A, :C, 5)
      edges << Edge.new(:A, :D, 3)
      edges << Edge.new(:A, :G, 14)
      edges << Edge.new(:C, :E, 3)
      edges << Edge.new(:C, :F, 2)
      edges << Edge.new(:D, :C, 11)
      edges << Edge.new(:D, :E, 7)
      edges << Edge.new(:D, :G, 6)
      edges << Edge.new(:G, :E, 7)
      edges << Edge.new(:E, :B, 5)
      edges << Edge.new(:G, :B, 6)
      edges << Edge.new(:F, :B, 7)

      @wdigraph = Digraph.create(edges)
    end

    it 'edge should be assigned a weight.' do
      d_c = @wdigraph.get_edge(:D, :C)
      d_c.weight.must_equal 11
      d_c.from.must_equal :D
      d_c.to.must_equal :C
      d_c.must_be_instance_of Edge
    end

    it '#degree should return vertex degree.' do
      @wdigraph.degree(:E).must_equal 4
      @wdigraph.degree(:C).must_equal 4
      @wdigraph.degree(:A).must_equal 3
    end

    it '#in_degree should return number of incoming edges to the vertex.' do
      @wdigraph.in_degree(:E).must_equal 3
      @wdigraph.in_degree(:C).must_equal 2
      @wdigraph.in_degree(:A).must_equal 0
    end

    it '#out_degree should return number of outgoing edges from vertex.' do
      @wdigraph.out_degree(:E).must_equal 1
      @wdigraph.out_degree(:B).must_equal 0
      @wdigraph.out_degree(:A).must_equal 3
    end

    it '#bfs should iterate over graph in bfs order.' do
      searcher = BreadthFirstSearch.new(@wdigraph)
      searcher.search(:A).must_equal [:A, :C, :D, :G, :E, :F, :B]
    end
  end
end
