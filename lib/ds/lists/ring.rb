module DS
  
  #Ring - represent list which head is linked with tail.
  class Ring < CyclicList

    #Creates ring from array. 
    def self.from_array(arr)
      list = Ring.new(arr.shift)
      tail = list.head
      arr.each { |e| tail = tail.append(e) }
      tail.next = list.head
      list
    end

    def length
      cycle_size
    end

    #Removes ring elements by k until there is only one element in list.
    def eliminate_by(k)
      elem = self.head
      prev = elem

      k = k-1

      while prev != elem.next 

        k.times  do
          prev = elem
          elem = elem.next
        end

        prev.next = elem.next
        elem = prev.next
      end

      return prev.data

    end

  end
end
