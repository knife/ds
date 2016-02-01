module DS
  # Class implements Binary Search Tree
  class BinarySearchTree < BinaryTree
    # Creates new search tree from array.
    def self.from_array(arr)
      tree = BinarySearchTree.new(arr.shift)
      arr.each do |e|
        tree.insert e
      end
      tree
    end

    def get(data, node = self)
      x = node
      while x
        case data <=> x.data
        when -1
          x = x.left
        when 1
          x = x.right
        else
          return x.data
        end
      end
    end

    # Inserts new element.
    def insert(x)
      if x > @data && right.nil?
        self.right = BinarySearchTree.new(x)
      elsif x <= @data && left.nil?
        self.left = BinarySearchTree.new(x)
      elsif x > @data
        right.insert x
      else
        left.insert x
      end
    end

    # Checks if tree is valid Binary Search Tree.
    def self.valid?(other)
      visited = TreeWalker.new(other, order: :inorder).traverse
      (0...visited.size).each do |i|
        return false if visited[i + 1] && visited[i] > visited[i + 1]
      end
      true
    end
  end
end
