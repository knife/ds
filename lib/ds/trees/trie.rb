module DS
  # Trie dictionary data structure
  class Trie < Tree
    attr_accessor :root

    # Trie node
    class Node
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
          @data
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

    def initialize(value = nil, alphabet = nil)
      @root = Node.new(value)
      self.alphabet = (alphabet || %w(- a b c d e f g h i j k l m n o p q r s t u v w x y z))
    end

    def alphabet=(arr)
      @alphabet = {}
      arr.each_with_index { |c, i| @alphabet[c] = i }
    end

    def alphabet
      @alphabet.keys
    end

    def key(chr)
      @alphabet[chr]
    end

    def insert(s, value = true)
      letters = s.scan(/./)
      raise ArgumentError, 'Not allowed symbol.' unless allowed?(letters)
      root.put(letters, value, self)
    end

    def find(s)
      letters = s.scan(/./)
      raise ArgumentError, 'Not allowed symbol.' unless allowed?(letters)
      root.get(letters, self)
    end

    def delete(s)
      letters = s.scan(/./)
      root.delete(letters, self)
    end

    private

    def allowed?(letters)
      (letters - alphabet).empty?
    end
  end
end
