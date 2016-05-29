module DS
  # Class implements Red Black Tree
  class RedBlackTree
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
  end
end
