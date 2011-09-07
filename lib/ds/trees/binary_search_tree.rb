module DS
  class BinarySearchTree < BinaryTree

    def self.from_array(arr)
      tree = BinarySearchTree.new(arr.shift)
      arr.each do |e|
        tree.insert e
      end
      tree
    end

    def insert x
      if x > @data and right.nil?
        self.right = BinarySearchTree.new(x)
      elsif x <= @data and left.nil?
        self.left = BinarySearchTree.new(x)
      elsif x > @data
        right.insert x
      else
        left.insert x
      end
    end


    def BinarySearchTree.valid?(other)
      walker = TreeWalker.new(other)
      walker.traverse(:inorder)
      walker.visited.sorted?
    end

  end
end
