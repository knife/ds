module DS
  # Class provides access to any element in array. If index i
  # is greter than array size then elements from size to i are
  # filled with extender.
  class ExpandableArray < Array
    def initialize(size = 0, extender = 0)
      @extender = extender
      super(size, extender)
    end

    # Returns element at index. If index is greater than size of array then
    # elements from size to index are filled with extender.
    def [](x)
      if x >= size
        (size..x).each do |i|
          self[i] = @extender
        end
      end
      super(x)
    end

    # Sets the element at index. If index is greater than size of array then
    # elements from size to index are filled with extender.
    def []=(x, v)
      max = size
      super(x, v)
      if size - max > 1
        (max..size - 2).each do |i|
          self[i] = @extender
        end
      end
    end
  end
end
