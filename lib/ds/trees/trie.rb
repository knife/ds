module DS
  # Trie dictionary data structure
  class Trie < Tree
    attr_accessor :root

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
      letters = get_letters(s)
      root.put(letters, value, self)
    end

    def []=(k, v)
      insert(k, v)
    end

    def find(s)
      letters = get_letters(s)
      node = root.get(letters, self)
      node.data if node
    end

    def [](k)
      find(k)
    end

    def delete(s)
      letters = s.scan(/./)
      root.delete(letters, self)
    end

    def each(&block)
      visit(root, '', &block)
    end

    def visit(node, prefix, &block)
      yield prefix, node.data if node.data
      node.children.each_with_index do |n, i|
        visit(n, prefix + alphabet[i], &block) if n
      end
    end

    def with_prefix(prefix, &block)
      letters = get_letters(prefix)
      node = root.get(letters, self)
      if block_given?
        return nil unless node
        visit(node, prefix, &block)
      else
        arr = []
        return arr unless node
        visit(node, prefix) { |n| arr << n }
        arr
      end
    end

    def to_h
      h = {}
      each { |k, v| h[k] = v }
      h
    end

    private

    def allowed?(letters)
      (letters - alphabet).empty?
    end

    def get_letters(s)
      letters = s.scan(/./)
      raise ArgumentError, 'Not allowed symbol.' unless allowed?(letters)
      letters
    end
  end
end
