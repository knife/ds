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
      expand(size, x) if x >= size
      super(x)
    end

    # Sets the element at index. If index is greater than size of array then
    # elements from size to index are filled with extender.
    def []=(x, v)
      old_size = size
      super(x, v)
      expand(old_size, size - 2) if size - old_size > 1
    end

    private

    def expand(from, to)
      (from..to).each do |i|
        self[i] = @extender
      end
    end
  end
end
