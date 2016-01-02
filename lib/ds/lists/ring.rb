module DS
  # Ring - represent list which head is linked with tail.
  class Ring < List
    # Creates ring from array.
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
  end
end
