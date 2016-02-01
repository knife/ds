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

  it '#size returns tree size' do
    @tree.size.must_equal(2)
  end
end
