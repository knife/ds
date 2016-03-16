module DS
  class ListError < StandardError; end

  # Implements simple list data structure.
  class List
    include Enumerable

    attr_accessor :head, :tail

    # Creates new list.
    def initialize(*arr)
      @size = 0
      @head = nil
      @tail = @head
      from_array(arr) if arr.any?
    end

    # Appends new element to list. Returns list tail
    def append(x)
      if !empty?
        @tail = tail.append(x)
        increment_size
      else
        create_first(x)
      end
      @tail
    end

    alias << append
    alias push append

    # Prepends new element to list. Returns list head
    def unshift(x)
      el = ListElement.new(x)
      el.next = @head
      @head.prev = el if @head

      increment_size
      @head = el
    end

    # Removes list head.
    def shift
      fail ListError, 'List is already empty' if empty?
      remove(head).data
    end

    # Return ListElement if it is on list otherwise returns nil
    def get(x)
      el = head
      el = el.next while el && el != x
      el
    end

    # Return ListElement if it is on list or raises error
    def get!(x)
      found = get(x)
      fail ListError, 'Element not found' unless found
    end

    # Returns list element on given index.
    def at(index)
      found = nil
      each_with_index do |element, i|
        if i == index
          found = element
          break
        end
      end
      found
    end

    # Returns list element on given index.
    def [](index)
      at(index)
    end

    # Sets list element on given index.
    def []=(index, val)
      found = at(index)
      if found
        found.data = val
      else
        fail ListError, 'Element not found'
      end
    end

    # Checks if two lists are equal
    def ==(other)
      a = head
      b = other.head
      while a && b && a.data == b.data
        a = a.next
        b = b.next
      end
      return true if a.nil? && b.nil?
      false
    end

    # Appends first list to other
    def +(other)
      other.head.prev = tail
      tail.next = other.head
      self.tail = other.tail
      self
    end

    # Inserts element x after another element.
    def insert_after(x, rel)
      x = ListElement.new(x)

      el = rel
      nxt = el.next
      x.next = nxt
      nxt.prev = x if nxt
      el.next = x
      x.prev = el
      self.tail = x if x.nil?

      increment_size

      self
    end

    # Inserts element x before another element.
    def insert_before(x, rel)
      if rel == head
        unshift(x)
      else
        x = ListElement.new(x)

        prev = rel.prev
        prev.next = x
        x.prev = prev
        x.next = rel
        rel.prev = x
      end
      increment_size
      self
    end

    # Removes element x from list.
    def remove(x)
      if x == head
        self.head = head.next
        x.next = nil
        head.prev = nil if head
      else
        nxt = x.next
        prev = x.prev
        prev.next = nxt
        nxt.prev = prev if nxt
        x.next = nil
        x.prev = nil

        self.tail = prev if nxt.nil?
      end
      decrement_size
      x
    end

    def pop
      remove(tail).data
    end

    # Checks if list is empty.
    def empty?
      @size.zero?
    end

    # Returns last element of the list.
    def last
      tail.data
    end

    def first
      head.data
    end

    # Returns length of the list.
    def length
      @size
    end

    alias size length

    # Checks if list is linked at the end with other list.
    def zip?(other)
      tail.equal? other.tail
    end

    # Returns joint element if exists, otherwise returns nil.
    def joint
      elem = head
      elem2 = elem.next

      while elem && elem2

        # traversing by 1
        elem = elem.next

        # traversing by 2
        elem2 = elem2.next
        elem2 = elem2.next if elem2

        return elem if elem2.equal? elem
      end
      nil
    end

    # Returns true if list has cycle.
    def looped?
      !joint.nil?
    end

    # Returns cycle size or nil if list has no cycles
    def cycle_size
      return unless looped?
      counter = 0
      start = joint
      if start
        counter = 1
        elem = start.next
        while elem != start
          elem = elem.next
          counter += 1
        end
      end
      counter
    end

    # Reverses list.
    def reverse!
      @tail = head
      prev = head
      elem = prev.next
      prev.next = nil
      while elem
        nxt = elem.next
        elem.next = prev
        prev.prev = elem
        prev = elem
        elem = nxt
      end

      @head = prev
      self
    end

    # Converts list to array.
    def to_a
      map(&:data)
    end

    # Default list iterator.
    def each
      elem = head
      while elem
        yield elem
        elem = elem.next
      end
    end

    # Reverse list iterator.
    def reverse_each
      elem = tail
      while elem
        yield elem
        elem = elem.prev
      end
    end

    def to_s
      to_a.join('=')
    end

    private

    def from_array(arr)
      create_first(arr.shift)
      arr.each { |e| append(e) }
    end

    # Creates first element in list.
    def create_first(x)
      first = unshift(x)
      self.head = first
      self.tail = first
      self
    end

    def increment_size
      @size += 1
    end

    def decrement_size
      @size -= 1
    end
  end
end
