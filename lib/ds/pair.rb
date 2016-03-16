module DS
  # Simple class for key, value objects
  class Pair
    attr_accessor :key, :value

    alias first key
    alias second value

    def initialize(x, y)
      @key = x
      @value = y
    end
  end
end
