module DS
  # Ring - represent list which head is linked with tail.
  class Ring < List
    # Creates ring from array.
    def self.from_array(arr)
      list = super(arr)
      list.tail.next = list.head
      list
    end

    def length
      cycle_size
    end
  end
end
