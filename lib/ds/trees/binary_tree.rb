module DS
  class BinaryTree < Tree

    def left
      if @children.empty?
        nil
      else
        @children[0]
      end
    end

    def left=(value)
      @children[0] = value
    end

    def right
      if @children.empty?
        nil
      else
        @children[1]
      end
    end

    def right=(value)
      @children[1] = value
    end

    def << (value)
      subtree = BinaryTree.new(value)
      @children << subtree
      return subtree
    end

    #Inserts new element in BSF order
    def insert(x)
      q = Queue.new
      if @data == nil
        @data = x
      elsif self.left == nil
        self.left = BinaryTree.new(x)
      elsif self.right == nil
        self.right = BinaryTree.new(x)
      else
        q.push self.left
        q.push self.right
        loop do
          node = q.shift
          if node.left == nil
            node.insert(x)
            break
          else 
            q.push node.left
          end
          if node.right == nil
            node.insert(x)
            break
          else
            q.push node.right
          end
        end
      end
    end
  end
end

