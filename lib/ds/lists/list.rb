module DS

  #Implements simple list data structure. 
  class List

    include Enumerable

    attr_accessor :head, :tail

    #Creates new list. 
    def initialize(x=nil)
      @head = ListElement.new(x)
      @tail = @head
    end

    #Creates list from array.
    def self.from_array(arr)
      list = new(arr.shift)
      tail = list.head
      arr.each{ |e| tail = tail.append(e) }
      list.tail = tail
      list
    end

    #Appends new element to list. 
    def append(x)
      last_elem = self.tail
      if !empty?
        @tail = last_elem.append(x)
      else
        @head = ListElement.new(x)
        @tail = @head
      end
    end

    alias :<< :append

    #Prepends new element to list.
    def prepend(x)
      el = ListElement.new(x)
      el.next = @head
      @head = el
    end

    #Removes element x from list.
    def remove(x)
      if x == head
        self.head = head.next
        x.next = nil
      else

        el = head
        while el and el != x
          prev = el 
          el = el.next
        end

        raise "Element not found" unless el

        prev.next = el.next
        el.next = nil
      end
      x
    end

    #Removes list head.
    def shift
      remove(head).data
    end

    #Inserts element x after another element.
    def insert_after(x,rel)
      x = ListElement.new(x)

      el = head
      while el and el != rel
        el = el.next
      end

      raise "Element not found" unless el

      x.next = el.next
      el.next = x

      if x.tail?
        self.tail = x
      end
    end

    #Inserts element x before another element.
    def insert_before(x,rel)
      x = ListElement.new(x)  

      #inserting at the beginnig of the list 
      if rel == head
        x.next = head
        self.head = x

      #inserting in the tail of the list
      else
        el = head
        prev = head
        while el and el != rel
          prev = el
          el = el.next
        end

        if el.nil?
          raise "List element not found"
        else
          prev.next = x
          x.next = el
        end
      end
    end


    #Checks if list is empty.
    def empty?
      head.data.nil?
    end

    #Returns last element of the list.
    def last
      tail.data
    end

    def first
      head.data
    end

    #Returns length of the list.
    def length
      count
    end

    #Checks if list is linked at the end with other list.
    def zip?(other)
      tail.equal? other.tail 
    end

    #Returns joint element if exists, otherwise returns nil.
    def joint
      elem = head
      elem2 = elem.next

      while elem and elem2

        #traversing by 1
        elem = elem.next

        #traversing by 2
        elem2 = elem2.next
        elem2 = elem2.next if elem2

        if elem2.equal? elem
          return elem
        end
      end

      nil
    end

    #Returns true if list has cycle.
    def looped?
      !!joint
    end


    #Orderize list by evaluating block. Block should evaluate to one of these
    #values: 1,0,-1 (same as Comparable).
    def orderize

      zero = List.new
      plus = List.new
      minus = List.new

      el = self.head

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
      return minus
    end


    # Removes elements that exists on the other list.
    def remove!(other)
      a = head
      b = other.head

      while a and b

        while a.data < b.data
          prev = a
          a = a.next
        end

        while b.data < a.data
          b = b.next
        end

        a = a.next
        prev.next = a
        b = b.next
      end
      self
    end

    # Merge list with other list.
    def merge(other)

      a = self.head
      b = other.head

      if a.data < b.data
        result = List.new(a.data)
        a = a.next
      else
        result = List.new(b.data)
        b = b.next
      end

      while a and b
        if a.data < b.data
          result.append(a.data)
          a = a.next
        else
          result.append(b.data)
          b = b.next
        end
      end
      if !b
        result.tail.next = a
        result.tail = self.tail
      elsif !a
        result.tail.next = b
        result.tail = other.tail
      end
      result
    end

    #Reverses list.
    def reverse!
      @tail = self.head
      prev = self.head
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

    #Prints list.
    def print
      each { |e| p e }
    end

    #Converts list to array.
    def to_a
      map { |e| e.data}
    end

    #Default list iterator.
    def each
      elem = @head
      while elem
        yield elem
        elem = elem.next
      end
    end

    def each_with_index
      elem = @head
      i = 0
      while elem
        yield elem,i
        elem = elem.next
        i = i + 1
      end
    end

  end
end
