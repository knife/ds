module DS
  class Pair
    attr_accessor :key, :value

    alias :first :key
    alias :second :value

    def initialize(x,y)
      @key = x
      @value = y
    end

  end
end
