module DS
  # Class implements binary tree
  class BinaryTree < Tree
    # Inserts a new subtree.
    def <<(value)
      subtree = BinaryTree.new(value)
      @children << subtree
      subtree
    end

    # Returns left subtree
    def left
      @children[0]
    end

    # Sets left subtree
    def left=(value)
      @children[0] = value
    end

    # Returns right subtree
    def right
      @children[1]
    end

    # Sets right subtree
    def right=(value)
      @children[1] = value
    end

    # Inserts new element in BSF order
    def insert(x)
      q = SimpleQueue.new
      if @data.nil?
        @data = x
      elsif left.nil?
        self.left = BinaryTree.new(x)
      elsif right.nil?
        self.right = BinaryTree.new(x)
      else
        q.push left
        q.push right
        insert_next(q, x)
      end
    end

    def insert_next(q, x)
      loop do
        node = q.shift
        if node.left.nil?
          node.insert(x)
          break
        else
          q.push node.left
        end
        if node.right.nil?
          node.insert(x)
          break
        else
          q.push node.right
        end
      end
    end
  end
end
