module DS
  module ArrayX

    #Checks if array is already sorted.
    def sorted?(order=:any)
      return true if size < 2

      case order
      when :asc
        (size-2).times{ |i| return false if self[i] > self[i+1] }
      when :desc
        (size-2).times{ |i| return false if self[i] < self[i+1] }
      else
        return (self[0] < self[1])? sorted?(:asc) : sorted?(:desc) 
      end

      true
    end

    #Pushes element e only if it is not already in the array. Returns index of
    #elemnt e.
    def push_uniq e
      if include? e
        index e
      else
        push e
        size-1
      end
    end

    #Tail
    def tail
      self[1..-1]
    end
  end
end
