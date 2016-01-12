require 'help'

describe BinarySearchTree do
  before do
    t = BinarySearchTree.new(7)
    c1 = t.insert 5
    c2 = t.insert 8

    c3 = c1.insert 2
    c1.insert 6

    c3.insert 1

    @bst = t

    @bin_tree = BinaryTree.new
    [2, 5, 8, 9, 11, 12, 14].each { |x| @bin_tree.insert(x) }
  end

  it 'should be valid  Binary Search Tree.' do
    assert BinarySearchTree.valid?(@bst)
  end

  it '#from_array should create new valid BinarySearchTree.' do
    b = BinarySearchTree.from_array([8, 1, 5, 2, 7, 6, 3])
    assert BinarySearchTree.valid?(b)
    TreeWalker.new(b).traverse(:inorder).must_equal [1, 2, 3, 5, 6, 7, 8]
  end

  it 'not every Binary Tree is valid Binary Search Tree.' do
    refute BinarySearchTree.valid?(@bin_tree)
  end
end
