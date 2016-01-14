module DS
  # Container for linked lists elements.
  class ListElement
    attr_accessor :data, :next, :prev

    def initialize(x = nil)
      @data = x
      @next = nil
      @prev = nil
    end

    # Adds new element to list.
    def append(x)
      elem = ListElement.new(x)
      elem.prev = self
      self.next = elem
    end

    # Checks if given element is last.
    def tail?
      @next.nil?
    end
  end
end
