require 'help'

describe CompleteBinaryTree do

  before do
    @tree = CompleteBinaryTree.new(1,2,3,4,5,6,7)
    @empty_tree = CompleteBinaryTree.new
  end

  it "#<< should add new element." do
    @empty_tree << 1
    @empty_tree << 2
    @empty_tree.root.must_equal 1
  end

  it "#root should return root of the tree." do
    @tree.root.must_equal 1
  end

  it "#left_index should return index of left child" do
    @tree.left_index(0).must_equal 1
    @tree.left_index(1).must_equal 3
  end

  it "#right_index should return index of left child" do
    @tree.right_index(0).must_equal 2
    @tree.right_index(1).must_equal 4
  end

  it "#parent_index should return index of left child" do
    @tree.parent_index(1).must_equal 0
    @tree.parent_index(3).must_equal 1
  end

  it "#left should return left child" do
    @tree.left(0).must_equal 2
    @tree.left(1).must_equal 4
  end

  it "#right should return right child" do
    @tree.right(0).must_equal 3
    @tree.right(1).must_equal 5
  end

  it "#parent should return parent." do
    @tree.parent(3).must_equal 2
    @tree.parent(4).must_equal 2
    @tree.parent(1).must_equal 1
  end

  it "#children should return children." do
    @tree.children(0).must_equal [2,3]
  end



end
 
