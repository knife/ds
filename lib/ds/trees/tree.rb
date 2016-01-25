module DS
  class Tree
    include Enumerable

    attr_accessor :data
    attr_reader :children

    # Returns a new tree.
    def initialize(value = nil)
      @data = value
      @children = []
      @iterator = TreeWalker.new(self)
    end

    # Inserts a new subtree.
    def <<(value)
      subtree = Tree.new(value)
      @children << subtree
      subtree
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
        tree.children.inject(0) { |m, t| m + leaf_count(t) }
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
      unless tree.leaf?
        tree.children.reverse!
        tree.children.each { |t| mirror!(t) }
      end
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
      @iterator.traverse { |t| yield t }
    end

    def to_a
      map(&:data)
    end
  end
end
