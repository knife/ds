module DS
  class Trie < Tree

    ALPHABET = %w{- a b c d e f g h i j k l m n o p q r s t u v w x y z} 

    def alphabet
      self.class::ALPHABET
    end
    
    def initialize(value=nil)
      @children = Array.new(alphabet.size)
      @data = value
    end

    def insert(s, value)
      priv_insert(s.scan(/./), value)
    end

    def find(s)
      priv_find(s.scan(/./))
    end

    protected
    def key(chr)
      raise ArgumentError,  "Argument chr is nil" unless chr
      k=alphabet.index(chr) 
      if k.nil?
        raise ArgumentError, "Character not found"
      else
        k
      end
    end

    def priv_insert(s, value)
      if s.empty?
          @data = value
      else
        index = key(s.first)
        subtree = if @children[index]
                    @children[index]
                  else
                    @children[index] = Trie.new
                  end

        subtree.priv_insert(s[1..-1], value)
      end
    end

    def priv_find(search)
      if @children[0]
        @children[0].value
      else
        if search.empty?
          @data
        else
          index = key(search.first)
          if @children[index]
            @children[index].priv_find(search[1..-1])
          else
            nil
          end
        end
      end
    end

  end
end
