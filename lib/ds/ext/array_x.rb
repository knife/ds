module DS
  # Custom extensions to Array class
  module ArrayX
    # Checks if array is already sorted.
    def sorted?(order = :any)
      return true if size < 2

      case order
      when :asc
        (size - 1).times { |i| return false if self[i] > self[i + 1] }
      when :desc
        (size - 1).times { |i| return false if self[i] < self[i + 1] }
      else
        return (self[0] < self[1]) ? sorted?(:asc) : sorted?(:desc)
      end

      true
    end

    # Checks if array has duplicates.
    def duplications?
      size != uniq.size
    end

    # Returns array tail.
    def tail
      self[1..-1]
    end
  end
end
