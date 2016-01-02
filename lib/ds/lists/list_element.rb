module DS
  # Container for linked lists elements.
  class ListElement
    attr_accessor :data, :next

    def initialize(x = nil)
      @data = x
      @next = nil
    end

    # Adds new element to list.
    def append(x)
      elem = ListElement.new(x)
      self.next = elem
    end

    # Checks if given element is last.
    def tail?
      @next.nil?
    end
  end
end
