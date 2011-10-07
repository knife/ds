module DS
  module ArrayX

    #Checks if array is already sorted.
    def sorted?(order=:any)
      return true if size < 2
      
      if size == 2
        return false if self[0] > self[1] and order == :asc
        return false if self[0] < self[1] and order == :desc
      else
        case order
        when :asc
          (size-2).times{ |i| return false if self[i] > self[i+1] }
        when :desc
          (size-2).times{ |i| return false if self[i] < self[i+1] }
        else
          return (self[0] < self[1])? sorted?(:asc) : sorted?(:desc) 
        end
      end

      true
    end

    #Returns array tail.
    def tail
      self[1..-1]
    end
  end
end
