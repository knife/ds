module DS
  # Complete Binary Tree
  class CompleteBinaryTree
    # Creates new tree (stored in array).
    def initialize(*args)
      if args.empty?
        @data = [nil]
      else
        @data = [nil] + args.to_a
      end
    end

    # Inserts new element.
    def <<(value)
      @data.push value
    end

    # Returns root element.
    def root
      @data[1]
    end

    # Returns index of left child.
    def left_index(i)
      2 * i
    end

    # Returns index of right child.
    def right_index(i)
      2 * i + 1
    end

    # Returns index of parent.
    def parent_index(i)
      i / 2
    end

    # Returns children of node i.
    def children(i)
      [@data[left_index(i)], @data[right_index(i)]]
    end

    # Returns left child of node i.
    def left(i)
      @data[left_index(i)]
    end

    # Returns left child of node i.
    def right(i)
      @data[right_index(i)]
    end

    # Returns parent of node i.
    def parent(i)
      @data[parent_index(i)]
    end
  end
end
