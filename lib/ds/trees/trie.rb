module DS
  class Trie < Tree
    ALPHABET = %w(- a b c d e f g h i j k l m n o p q r s t u v w x y z)

    def alphabet
      self.class::ALPHABET
    end

    def initialize(value = nil)
      @children = Array.new(alphabet.size)
      @data = value
    end

    def insert(s, value = true)
      letters = s.scan(/./)
      fail ArgumentError, 'Not allowed symbol.' unless  allowed?(letters)
      put(letters, value)
    end

    def find(s)
      letters = s.scan(/./)
      fail ArgumentError, 'Not allowed symbol.' unless allowed?(letters)
      get(letters)
    end

    protected

    def allowed?(letters)
      (letters - alphabet).empty?
    end


    def key(chr)
      alphabet.index(chr)
    end

    def put(s, value)
      if s.empty?
        @data = value
      else
        index = key(s.first)
        @children[index] ||= Trie.new 
        @children[index].put(s[1..-1], value)
      end
    end

    def get(s)
      if s.empty?
        @data
      else
        index = key(s.first)
        @children[index].get(s[1..-1]) if @children[index]
      end
    end
  end
end
