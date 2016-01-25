module DS
  class TreeWalker
    attr_accessor :visited
    attr_accessor :tree
    attr_accessor :action
    attr_accessor :order

    # Creates new tree iterator.
    def initialize(tree, options = {}, &block)
      @visited = []
      @tree = tree
      @order = options[:order] || :bfs
      @action = block
    end

    # Traversing tree in given order:
    # bfs - Breadth-first search - default
    # postorder - postorder search
    # preorder - preorder search
    # inorder - inorder search - only for Binary Trees
    #
    # If block is  given, passes each visited subtree to block.
    # Returns values of nodes  in given order

    def traverse(traverse_order = nil, &block)
      self.action = block if block_given?
      self.order = traverse_order if traverse_order
      reset!

      if order == :bfs
        traverse_bfs
      else
        walk(tree)
      end
      visited
    end

    # Traverses tree in BFS order.
    def traverse_bfs(&block)
      self.action = block if block_given?
      q = Queue.new
      q.push tree

      loop do
        break if q.empty?
        node = q.shift
        visit_node(node)
        node.children.each { |n| q.push n } if node.children
      end
    end

    # Resets tree walker.
    def reset!
      @visited.clear
      self
    end

    # Traverses tree with tracking level.
    def traverse_with_h(tree, height = nil, &block)
      tree.children.each do |t|
        traverse_with_h(t, height + 1, &block)
      end

      yield tree, height if block_given?
    end

    # Recalculates tree by evaluating block on every node.
    def recalculate!(tree, order, memo = nil, &block)
      case order
      when :postorder
        arr = tree.children.map { |t| recalculate!(t, order, memo, &block) }
        tree.data = yield tree, arr
      when :preorder
        tree.data = yield tree, memo
        tree.children.each do |t|
          recalculate!(t, order, tree.data, &block)
        end
      when :inorder
        fail ArgumentError unless self.tree.is_a? BinaryTree
        recalculate!(tree.left, order, memo, &block)
        tree.data = yield tree, memo
        recalculate!(tree.right, order, tree.data, &block)
      end if tree
    end

    private

    def visit_node(node)
      action.call(node) if action
      @visited << node.data
    end

    def visit_children(node)
      node.children.each { |t| walk(t) }
    end

    def walk(node)
      case order
      when :postorder
        visit_children(node)
        visit_node(node)
      when :preorder
        visit_node(node)
        visit_children(node)
      when :inorder
        fail ArgumentError unless node.is_a? BinaryTree

        walk(node.left)
        visit_node(node)
        walk(node.right)
      end if node
    end
  end
end
