module DS
   
  #Implements two dimensional array.  
  class Array2D


    #Creates new two dimensional array. Init is the default value of the array.
    def initialize(size=1,init=0)
      @init = init
      @store = Array.new(size){Array.new(size){init}}
    end

    
    def [](x,y)
      if @store[x].nil?
        @store[x] = []
        @init
      elsif @store[x][y].nil?
        @init
      else
        @store[x][y]
      end
    end

    def []=(x,y,v)
      @store[x] = [] if @store[x].nil?
      @store[x][y] = v
    end

    def to_a
      @store.flatten
    end

  end
end
