module DS
  class BinaryHeap < CompleteBinaryTree
    attr_accessor :data
    
    #Create new Heap from args.
    #Given block sets the heap relation. Default heap relation is Max Heap.
    def initialize(*args, &block)
      if block_given?
        @relation = block
      else
        @relation = Proc.new{|parent,child| parent >= child}
      end
      @data = args.to_a
      heapify!
    end

    def set_relation(&relation)
      @relation = relation
    end

    def relation(parent,child)
      @relation.call(@data[parent],@data[child])
    end

    #Arranges data in heap.
    #O(n)
    def heapify!
      (@data.size/2).downto(0) do |i|
        heapify(i)
      end
    end

    #Inserts new value to heap maintaining the heap relation.
    #Returns heap itself.
    #O(log)
    def insert(value)
      @data.push value
      child = @data.size-1
      parent = parent_index(child)

      while parent >= 0 and !relation(parent,child)
        @data[child], @data[parent] = @data[parent], @data[child]
        child = parent
        parent = parent_index(child)
      end
      self
    end

    #Maintains heap condition for i node.
    #O(log)
    def heapify(i)
      left =  left_index(i)
      left = nil if left >= @data.size

      right = right_index(i)
      right = nil if right >= @data.size

      largest = [i,left,right].compact.sort{|x,y| relation(x,y)?-1:1}.first

      if largest != i
        @data[i], @data[largest] = @data[largest], @data[i]
        heapify(largest)
      end
    end

    #Removes element from heap maintaining heap relation.
    def shift
      result = @data.shift
      @data.unshift @data.pop
      heapify(0)
      result
    end

    def length
      @data.size 
    end

    alias :size :length

    def empty?
      @data.empty?
    end


    def to_a
      @data
    end

  end
end
