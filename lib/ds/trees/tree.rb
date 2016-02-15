module DS
  # Tree class
  class Tree
    include Enumerable

    attr_accessor :data
    attr_reader :children, :parent

    # Returns a new tree.
    def initialize(value = nil, parent = nil)
      @data = value
      @parent = parent
      @children = []
    end

    # Inserts a new subtree.
    def <<(value)
      subtree = Tree.new(value, self)
      @children << subtree
      subtree
    end

    def sibblings
      parent.children.reject { |node| node == self }
    end

    # Checks if node is leaf.
    def leaf?
      children.empty?
    end

    # Returns leaf list.
    def get_leaves(tree = self)
      list = List.new
      walker = TreeWalker.new(tree, order: :postorder)
      walker.traverse { |t| list.append(t) if t.leaf? }
      list
    end

    # Returns the number of leaves for given subtree.
    def leaf_count(tree = self)
      if tree.leaf?
        1
      else
        tree.children.inject(0) { |a, e| a + leaf_count(e) }
      end
    end

    # Returns number of nodes for each tree level.
    # {1=>1, 2=>4, 3=>5}
    def levels
      walker = TreeWalker.new(self)
      nodes = {}

      walker.traverse_with_h(self, 1) do |_t, level|
        if nodes[level]
          nodes[level] += 1
        else
          nodes[level] = 1
        end
      end
      nodes
    end

    # Returns tree width.
    def width
      levels.values.max
    end

    # Returns subtree height.
    def self.h(tree)
      if tree.leaf?
        1
      else
        tree.children.map { |t| h(t) }.max + 1
      end
    end

    # Returns tree height.
    def height
      Tree.h(self)
    end

    # Returns node which lies closest to the root.
    def lowest_height
      find(&:leaf?)
    end

    # Mirrors tree.
    def mirror!(tree = self)
      return if tree.leaf?
      tree.children.reverse!
      tree.children.each { |t| mirror!(t) }
    end

    # Checks if tree is isometric to another tree.
    def izometric?(other)
      tree = self
      unless tree.leaf? && other.leaf?
        if tree.children.size == other.children.size
          tree.children.each_with_index { |t, i| return false unless t.izometric?(other.children[i]) }
        else
          return false
        end
      end
      true
    end

    # Iterates tree in BFS order.
    def each
      iterator = TreeWalker.new(self)
      iterator.traverse { |t| yield t }
    end

    def to_a
      map(&:data)
    end
  end
end
