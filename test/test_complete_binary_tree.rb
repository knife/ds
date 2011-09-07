require 'help'

describe CompleteBinaryTree do

  before do
    @tree = CompleteBinaryTree.new(1,2,3,4,5,6,7)
  end

  it "#root should return root of the tree." do
    @tree.root.must_equal 1
  end

  it "#left should return left child" do
    @tree.left(1).must_equal 2
    @tree.left(2).must_equal 4
  end

  it "#right should return right child" do
    @tree.right(1).must_equal 3
    @tree.right(2).must_equal 5
  end

  it "#parent should return parent." do
    @tree.parent(4).must_equal 2
    @tree.parent(5).must_equal 2
    @tree.parent(2).must_equal 1
  end

end
 
