require 'help'

describe Tree do
  before do
    @tree = RedBlackTree.new
    @tree.insert(:a, 1)
    @tree.insert(:b, 2)
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

  it '#map return nodes in order' do
    @tree.insert(:e, 3)
    @tree.insert(:d, 3)
    @tree.insert(:c, 3)
    @tree.map(&:key).must_equal [:a, :b, :c, :d, :e]
  end
end
