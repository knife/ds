module DS
  # Class implements Red Black Tree
  class RedBlackTree
    RED = true
    BLACK = false

    # Red Black Tree Node
    class Node
      attr_accessor :color, :right, :left, :data, :key

      def initialize(key, value, color)
        @key = key
        @data = value
        @color = color
        @left = nil
        @right = nil
      end

      def children
        [@left, @right]
      end
    end

    include Enumerable

    attr_accessor :root
    attr_reader :size

    def initialize(hash = nil)
      @root = nil
      @size = 0
      @iterator = TreeWalker.new(root)
      hash.each { |k, v| insert(k, v) } if hash
    end

    def insert(key, value)
      self.root = put(root, key, value)
      root.color = BLACK
    end

    def []=(key, value)
      insert(key, value)
    end

    def get(key, node = root)
      x = node
      while x
        case key <=> x.key
        when -1
          x = x.left
        when 1
          x = x.right
        else
          return x.data
        end
      end
    end

    def [](key)
      get(key)
    end

    def each
      iterator = TreeWalker.new(root)
      iterator.traverse(:inorder) { |t| yield t }
    end

    def to_h
      each_with_object({}) { |n, h| h[n.key] = n.data }
    end

    private

    def put(n, key, value)
      if n.nil?
        @size += 1
        return Node.new(key, value, RED)
      end

      case key <=> n.key
      when -1
        n.left = put(n.left, key, value)
      when 1
        n.right = put(n.right, key, value)
      else
        n.data = value
      end

      balance(n)
    end

    def balance(n)
      n = rotate_left(n)    if right_red?(n)
      n = rotate_right(n)   if two_red_in_row?(n)
      flip_colors(n)        if red_children?(n)
      n
    end

    def red_children?(n)
      red?(n.left) && red?(n.right)
    end

    def two_red_in_row?(n)
      red?(n.left) && red?(n.left.left)
    end

    def right_red?(n)
      red?(n.right) && !red?(n.left)
    end

    def red?(n)
      return false if n.nil?
      n.color == RED
    end

    def rotate_left(n)
      x = n.right
      n.right = x.left
      x.left = n
      x.color = n.color
      n.color = RED
      x
    end

    def rotate_right(n)
      x = n.left
      n.left = x.right
      x.right = n
      x.color = n.color
      n.color = RED
      x
    end

    def flip_colors(n)
      n.color = RED
      n.left.color = BLACK
      n.right.color = BLACK
    end
  end
end
