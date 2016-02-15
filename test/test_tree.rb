require 'help'

describe Tree do
  before do
    t = Tree.new(2)
    @child1 = t << 5
    @child2 = t << 8
    @child3 = t << 9

    @grand1 = @child1 << 4
    @grand2 = @child1 << 10
    @grand3 = @child2 << 3

    @tree = t
  end

  it '#to_a should return tree converted to array.' do
    @tree.to_a.must_equal [2, 5, 8, 9, 4, 10, 3]
  end

  it '<< should add new subtree to tree.' do
    subtree = @tree << 7
    subtree.must_be_kind_of Tree
    @tree.children.size.must_equal 4
  end

  it '#parent should return node parent' do
    @child1.parent.must_equal @tree
    @child2.parent.must_equal @tree
    @grand1.parent.must_equal @child1
    @grand3.parent.must_equal @child2
  end

  it '#sibblings should return node sibblings' do
    @child1.sibblings.must_equal [@child2, @child3]
    @child2.sibblings.must_equal [@child1, @child3]
    @grand1.sibblings.must_equal [@grand2]
    @grand3.sibblings.must_equal []
  end

  it '#leaf? should check if node is a leaf.' do
    refute @tree.leaf?
    assert @tree.children.last.leaf?
  end

  it '#children returns node child nodes.' do
    @tree.children.map(&:data).must_equal([5, 8, 9])
  end

  it '#get_leaves should return list of tree leaves.' do
    leaves = @tree.get_leaves
    leaves.must_be_kind_of List
    leaves.to_a.collect(&:data).must_equal [4, 10, 3, 9]
  end

  it '#leaf_count should return number of tree leaves.' do
    @tree.leaf_count.must_equal 4
  end

  it '#levels should return number of nodes on each tree level.' do
    @tree.levels.must_equal 1 => 1, 2 => 3, 3 => 3
  end

  it '#height should return tree height.' do
    @tree.height.must_equal 3
  end

  it 'Tree.h should return subtree height.' do
    Tree.h(@tree.children.last).must_equal 1
  end

  it '#width should return tree width.' do
    @tree.width.must_equal 3
  end

  it '#lowest_height should return node which lies closest to the root.' do
    @tree.lowest_height.data.must_equal 9
  end

  it '#mirror! should mirror tree.' do
    @tree.mirror!
    @tree.to_a.must_equal [2, 9, 8, 5, 3, 10, 4]
  end
end
