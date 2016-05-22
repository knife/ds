require 'help'

describe Tree do
  before do
    @tree = RedBlackTree.new
    @tree.insert(:a, 1)
    @tree.insert(:b, 2)
  end

  it '#new creates new RBT from hash' do
    @dict = RedBlackTree.new(a: 1, b: 2, c: 3)
    @dict[:a].must_equal 1
    @dict[:b].must_equal 2
    @dict[:c].must_equal 3
  end

  it '#insert add new element into tree' do
    @tree.insert(:c, 3)
    @tree.get(:c).must_equal 3
  end

  it '#get returns element if it is on tree' do
    @tree.get(:b).must_equal 2
    @tree.get(:x).must_equal nil
  end

  it 'has hash like methods' do
    @tree[:c] = 3
    @tree[:c].must_equal 3
  end

  it '#size returns tree size' do
    @tree.size.must_equal(2)
  end

  it '#map returns nodes in order' do
    @tree.insert(:e, 3)
    @tree.insert(:d, 3)
    @tree.insert(:c, 3)
    @tree.map(&:key).must_equal [:a, :b, :c, :d, :e]
  end

  it '#to_h converts tree to Hash' do
    @tree.to_h.must_equal a: 1, b: 2
  end
end
