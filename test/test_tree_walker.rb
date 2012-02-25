require "help"

describe TreeWalker do

  describe "traversing Tree" do
    
    before do
     
      t = Tree.new(2)
      c1 = t << 5
      c2 = t << 8
      t << 9

      c1 << 4
      c1 << 10
      c2 << 3

      @tree = t

      @walker =  TreeWalker.new(@tree)
    end


    it "#traverse without arguments should traverse tree in BFS order." do
      @walker.traverse.must_equal [2,5,8,9,4,10,3]
    end

    it "should traverse in BFS order." do
      @walker.traverse(:bfs).must_equal [2,5,8,9,4,10,3]
    end

    it "#summarize should transform tree." do
      @walker.summarize(:topdown).to_a.must_equal [2,7,10,11,11,17,13]
    end
  end

  describe "traversing Binary Tree" do
    
    before do
      @bin_tree = BinaryTree.new
      [2,5,8,9,11,12,14].each{|x| @bin_tree.insert(x)}
      @bin_walker =  TreeWalker.new(@bin_tree)
    end

    it "#traverse without arguments should traverse tree in BFS order." do
      @bin_walker.traverse.must_equal [2,5,8,9,11,12,14]
    end

    it "should traverse in BFS order." do
      @bin_walker.traverse(:bfs).must_equal [2,5,8,9,11,12,14]

    end

    it "should traverse in preorder." do
      @bin_walker.traverse(:preorder).must_equal  [2,5,9,11,8,12,14]

      arr = []
      @bin_walker.traverse(:preorder){|t| arr << t.data}
      arr.must_equal  [2,5,9,11,8,12,14]
    end


    it "should traverse in postorder." do
      @bin_walker.traverse(:postorder).must_equal  [9,11,5,12,14,8,2]

      arr = []
      @bin_walker.traverse(:postorder){|t| arr << t.data}
      arr.must_equal  [9,11,5,12,14,8,2]
    end

    it "should traverse in inorder." do
      @bin_walker.traverse(:inorder).must_equal [9,5,11,2,12,8,14]
      
      arr = []
      @bin_walker.traverse(:inorder){|t| arr << t.data}
      arr.must_equal   [9,5,11,2,12,8,14]
    end

    it "#summarize should transform tree." do
      @bin_walker.summarize(:bottomup).to_a.must_equal [61,25,34,9,11,12,14]
    end

    it "recalculate! should change values of tree nodes." do
      @bin_walker.summarize(:inorder).to_a.must_equal [2,5,10,9,16,14,24]
    end

  end
end



