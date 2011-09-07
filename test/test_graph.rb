require 'help'

describe Graph do

  before do
    edges = []
    edges << Edge.new('Lukas','Marc')
    edges << Edge.new('Lukas','Tom')
    edges << Edge.new('Marc','Jack')
    edges << Edge.new('Tom','Marc')
    @graph = Graph.create(edges)
  end

  it "#vertex_size should return number of vertexes" do
    @graph.vertex_size.must_equal 4
  end

  it "#degree should return degree for given vertex." do
    @graph.degree("Marc").must_equal 3
    @graph.degree("Jack").must_equal 1 
    @graph.degree("Lukas").must_equal 2
    @graph.degree("Tom").must_equal 2
  end

  it "#edge? should check if given vertexes are connected." do
    assert @graph.edge?("Marc","Tom")
    assert @graph.edge?("Tom","Marc")
    refute @graph.edge?("Tom","Jack")
    refute @graph.edge?("Jack","Tom")
  end

  it "#add_edges should add new edges." do
    @graph.add_edges([Edge.new("Marc","Kate")])
    @graph.vertex_size.must_equal 5
    assert @graph.edge?("Marc","Kate")
    assert @graph.edge?("Kate","Marc")
    refute @graph.edge?("Tom","Kate")
  end

  it "#remove_edge should remove edge." do
    @graph.remove("Marc","Jack")
    @graph.vertex_size.must_equal 3
    refute @graph.edge?("Marc","Jack")
    refute @graph.edge?("Jack","Marc")
  end

  it "#neighbors should return all neighbors for given vertex." do
    n = @graph.neighbors('Tom')
    n.must_be_instance_of Array
    n.size.must_equal 2
    assert n.include?("Marc")
    assert n.include?("Lukas")
    refute n.include?("Jack")
  end

  it "should iterate edges." do 
    r = []
    @graph.each_edge{|e| r.push e}
    r.size.must_equal 4
  end

  it "should iterate vertexes." do
    r = []
    @graph.each_vertex { |v| r.push v }
    r.size.must_equal 4
    r.sort.must_equal ['Jack','Lukas', 'Marc', 'Tom' ]
  end

end


