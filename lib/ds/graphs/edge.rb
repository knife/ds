module DS
  class Edge
    attr_accessor :from, :to, :weight
    
    #Create new edge.
    def initialize(from,to,weight=1)
      @from = from
      @to = to
      @weight = weight
    end
  end
end

