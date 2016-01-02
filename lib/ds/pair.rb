module DS
  # Simple class for key, value objects
  class Pair
    attr_accessor :key, :value

    alias_method :first, :key
    alias_method :second, :value

    def initialize(x, y)
      @key = x
      @value = y
    end
  end
end
