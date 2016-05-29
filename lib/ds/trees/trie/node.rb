module DS
  # Trie dictionary data structure
  class Trie
    # Trie node
    class Node
      attr_reader :children, :data

      def initialize(value = nil)
        @children = []
        @data = value
      end

      def put(s, value, trie)
        if s.empty?
          @data = value
        else
          index = trie.key(s.first)
          @children[index] ||= Node.new
          @children[index].put(s[1..-1], value, trie)
        end
      end

      def get(s, trie)
        if s.empty?
          self
        else
          index = trie.key(s.first)
          @children[index].get(s[1..-1], trie) if @children[index]
        end
      end

      def delete(s, trie)
        return true if s.empty?
        index = trie.key(s.first)
        flag = @children[index].delete(s[1..-1], trie)
        flag &&= one_child?
        @children[index] = nil if flag
        s.size < 2 ? true : flag && @data.nil?
      end

      private

      def one_child?
        @children.compact.size <= 1
      end
    end
  end
end
