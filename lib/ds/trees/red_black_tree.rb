module DS
  # Class implements Red Black Tree
  class RedBlackTree
    RED = true
    BLACK = false

    # Red Black Tree Node
    class Node
      attr_accessor :color, :right, :left, :value, :key

      def initialize(key, value, color)
        @key = key
        @value = value
        @color = color
        @left = nil
        @right = nil
      end
    end

    attr_accessor :root
    attr_reader :size

    def initialize
      @root = nil
      @size = 0
    end

    def insert(key, value)
      self.root = put(root, key, value)
      root.color = BLACK
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
          return x.value
        end
      end
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
        n.value = value
      end

      balance(n)
    end

    def balance(n)
      n = rotate_left(n)    if red?(n.right) && !red?(n.left)
      n = rotate_right(n)   if red?(n.left) && red?(n.left.left)
      flip_colors(n)        if red?(n.left) && red?(n.right)
      n
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