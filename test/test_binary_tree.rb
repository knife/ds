require 'help'

describe BinaryTree do
  before do
    @bin_tree = BinaryTree.new
    [2, 5, 8, 9, 11, 12, 14].each { |x| @bin_tree.insert(x) }

    @izo_tree = BinaryTree.new
    [2, 7, 8, 3, 11, 12, 14].each { |x| @izo_tree.insert(x) }

    @small_tree = BinaryTree.new(2)
    @small_tree << BinaryTree.new(7)
    @small_tree << BinaryTree.new(8)

    @bin_walker = TreeWalker.new(@bin_tree)
  end

  it '#to_a should return tree converted to array.' do
    @bin_tree.to_a.must_equal [2, 5, 8, 9, 11, 12, 14]
  end

  it '#parent should return node parent' do
    @small_tree.parent.must_equal nil
    @small_tree.right.parent.must_equal @small_tree
    @bin_tree.right.parent.must_equal @bin_tree
  end

  it '#sibblings should return node sibblings' do
    r = @small_tree.right
    l = @small_tree.left
    r.sibblings.must_equal [l]
    r = @bin_tree.right
    l = @bin_tree.left
    r.sibblings.must_equal [l]
  end

  it '#height should return tree height.' do
    @bin_tree.height.must_equal 3
  end

  it '#width should return tree width.' do
    @bin_tree.width.must_equal 4
  end

  it '#leaf_count should return number of tree leaves.' do
    @bin_tree.leaf_count.must_equal 4
  end

  it '#get_leaves should return list of tree leaves.' do
    @bin_tree.get_leaves.to_a.collect(&:data).must_equal [9, 11, 12, 14]
  end

  it '#lowest_height should return node which lies closest to the root.' do
    assert @bin_tree.lowest_height.data.must_equal 9
  end

  it '#mirror should mirror tree.' do
    @bin_tree.mirror!
    @bin_tree.to_a.must_equal [2, 8, 5, 14, 12, 11, 9]
  end

  it '#isometric should check if tree is isometric to antother.' do
    assert @bin_tree.izometric?(@izo_tree)
    assert @izo_tree.izometric?(@bin_tree)
    refute @bin_tree.izometric?(@small_tree)
  end
end
