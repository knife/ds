module DS
  class CompleteBinaryTree
    
    def initialize(*args)
      if args.empty? 
        @data = []
      else
        @data = args.to_a
      end
    end

    def << (value)
      @data.push value
    end

    def root
      @data.first
    end

    def children(value)
      i = @data.index(value) 
      return [@data[2*i+1], @data[2*i+2]]
    end

    def right value
      children(value)[1]
    end

    def left value
      children(value).first
    end

    def left_index(i)
      2*i+1  
    end

    def right_index(i)
      2*i+2
    end

    def parent_index(i)
      (i+1)/2 - 1
    end

    def parent value
      i = @data.index(value)
      @data[parent_index(i)]
    end

  end
end

