module DS
  class TreeWalker

    attr_accessor :visited
    attr_accessor :tree

    #Creates new tree iterator.
    def initialize(tree=nil)
      @visited = [] 
      @tree = tree
    end

    #Traversing tree in given order:
    #bfs - Breadth-first search - default
    #postorder - postorder search
    #preorder - preorder search
    #inorder - inorder search - only for Binary Trees
    #
    #If block is  given, passes each visited subtree to block.
    #Returns values of nodes  in given order

    def traverse(order=:bfs,&block)
      reset 
      tree = @tree

      case order
      when :bfs
        traverse_bfs &block
      when :postorder
        walk(tree,:postorder,&block)
      when :preorder
        walk(tree,:preorder, &block)
      when :inorder
        raise ArgumentError unless tree.kind_of? BinaryTree
        walk(tree,order,&block)
      end

      return visited
    end

    #Traverses tree in BFS order.
    def traverse_bfs
      q = Queue.new
      q.push @tree
      
      loop do
        break if q.empty?
        node = q.shift
        if block_given?
          yield node
        else
          @visited << node.data
        end
        node.children.each{ |n| q.push n } if node.children
      end
    end

    #Resets tree walker.
    def reset
      @visited.clear
      self
    end

    #Traverses tree with tracking level.
    def traverse_with_h(tree,height=nil,&block)

      tree.children.each do |t|
        traverse_with_h(t,height+1,&block)
      end

      if block_given?
        yield tree, height
      end

    end

    #Recalculates tree by evaluating block on every node.
    def recalculate!(tree,order,memo=nil,&block)
      if tree

        case order
        when :postorder
          
          arr =  tree.children.map{ |t| recalculate!(t,order,memo,&block) }
          result =  block.call(arr.push tree.data)
          tree.data = result

        when :preorder
            
          tree.data = yield tree, memo
          memo = tree.data

          tree.children.each do |t|
            recalculate!(t,order,memo,&block)
          end

        when :inorder
          raise ArgumentError unless  self.tree.is_a? BinaryTree
          recalculate!(tree.left,order,memo,&block)

            tree.data = yield tree, memo
            memo = tree.data

          recalculate!(tree.right,order,memo,&block)

        end
      end
    end

    #Summarize tree
    def summarize(direction=:bottomup)

      case direction
      when :bottomup
        recalculate!(self.tree,:postorder,0){|ar| ar.inject(0){|x,memo| memo += x}}
        self.tree
      when :topdown
        recalculate!(self.tree,:preorder,0){|x,memo| memo = memo+x.data} 
        self.tree
      when :inorder
        recalculate!(self.tree,:inorder,0){|x,memo| memo = memo+x.data if x.data and memo} 
        self.tree
      end
    end

    private

    def walk(tree,order,&block)
      if tree

        case order
        when :postorder
          tree.children.each do |t|
            walk(t,order,&block)
          end

          if block_given?
            yield tree
          else 
            @visited << tree.data
          end

        when :preorder
          if block_given?
            yield tree
          else 
            @visited << tree.data
          end

          tree.children.each do |t|
            walk(t,order,&block)
          end

        when :inorder
          raise ArgumentError unless  self.tree.is_a? BinaryTree
          walk(tree.left,order,&block)

          if block_given?
            yield tree
          else 
            @visited << tree.data
          end

          walk(tree.right,order,&block)

        end
      end
    end
  end
end

