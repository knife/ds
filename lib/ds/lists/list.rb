module DS
  class ListError < StandardError; end

  # Implements simple list data structure.
  class List
    include Enumerable

    attr_accessor :head, :tail

    # Creates new list.
    def initialize
      @size = 0
      @head = nil
      @tail = @head
    end

    # Creates list from array.
    def self.from_array(arr)
      list = new
      list = list.create_first(arr.shift)
      arr.each { |e| list.append(e) }
      list
    end

    # Creates first element in list.
    def create_first(x)
      first = unshift(x)
      self.head = first
      self.tail = first
      self
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

    alias_method :<<, :append
    alias_method :push, :append

    # Prepends new element to list. Returns list head
    def unshift(x)
      el = ListElement.new(x)
      el.next = @head
      increment_size
      @head = el
    end

    # Removes list head.
    def shift
      fail 'List is already empty' if empty?
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
      fail 'Element not found' unless found
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
        fail 'Element not found'
      end
    end

    # Inserts element x after another element.
    def insert_after(x, rel)
      x = ListElement.new(x)

      el = head
      el = el.next while el && el != rel
      fail 'Element not found' unless el

      x.next = el.next
      el.next = x

      self.tail = x if x.tail?
      @size += 1
    end

    # Inserts element x before another element.
    def insert_before(x, rel)
      x = ListElement.new(x)

      # inserting at the beginnig of the list
      if rel == head
        x.next = head
        self.head = x

      # inserting in the tail of the list
      else
        el = head
        prev = head
        while el && el != rel
          prev = el
          el = el.next
        end

        if el.nil?
          fail ListError, 'List element not found'
        else
          prev.next = x
          x.next = el
        end
      end
      @size += 1
    end

    # Removes element x from list.
    def remove(x)
      if x == head
        self.head = head.next
        x.next = nil
      else
        el = head
        while el && el != x
          prev = el
          el = el.next
        end

        fail ListError, 'Element not found' unless el

        self.tail = prev if el == tail
        prev.next = el.next
        el.next = nil

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

    alias_method :size, :length

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

    # Orderize list by evaluating block. Block should evaluate to one of these
    # values: 1,0,-1 (same as Comparable).
    def orderize
      zero = List.new
      plus = List.new
      minus = List.new

      el = head

      while el
        case yield el.data
        when 0
          zero_tail = zero.append(el.data)
        when 1
          plus_tail = plus.append(el.data)
        when -1
          minus_tail = minus.append(el.data)
        end
        el = el.next
      end

      minus_tail.next = zero.head
      zero_tail.next = plus.head
      minus
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
      elem = @head
      while elem
        yield elem
        elem = elem.next
      end
    end

    private

    def increment_size
      @size += 1
    end

    def decrement_size
      @size -= 1
    end
  end
end
