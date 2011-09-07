require 'help'

describe Tree do

  before do
    t = Tree.new(2)
    c1 = t << 5
    c2 = t << 8
    t << 9

    c1 << 4
    c1 << 10
    c2 << 3

    @tree = t
  end
    
  it "#to_a should return tree converted to array." do
    @tree.to_a.must_equal [2,5,8,9,4,10,3]
  end

  it "#height should return tree height." do
    @tree.height.must_equal 3
  end

  it "#width should return tree width." do
    @tree.width.must_equal 3
  end

  it "#leaf_count should return number of tree leaves." do
    @tree.leaf_count.must_equal 4
  end
  
  it "#get_leaves should return list of tree leaves." do
    @tree.get_leaves.to_a.collect{ |e| e.data }.must_equal [4,10,3,9]
  end

  it "#lowest_height should return node which lies closest to the root." do
    @tree.lowest_height.must_equal 9 
  end

  it "#mirror! should mirror tree." do
     @tree.mirror!
     @tree.to_a.must_equal [2,9,8,5,3,10,4]
  end

end

