require "help"

describe BinaryHeap do

  before do
    @arr = [9,8,4,5,11,6]
    @arr2 = [4,2,9,11,3,5,1]
    @heap = BinaryHeap.new(*@arr)
    @heap2 = BinaryHeap.new(*@arr2)
  end

  it "should create heap from array" do
    @heap.to_a.must_equal [11,9,6,5,8,4]
    @heap2.to_a.must_equal [11,4,9,2,3,5,1]
  end

  it "#insert should insert new element to the heap maintaining heap relation." do
    @heap.insert(13).to_a.must_equal  [13,9,11,5,8,4,6]
  end

  describe "Minimal Heap" do

    before do
      @min_heap = BinaryHeap.new(*@arr){|parent,child| parent < child}
    end

    it "should create heap from array." do
      @min_heap.to_a.must_equal [4,5,6,8,11,9]
    end

    it "#insert should insert new element to the heap maintaining heap relation." do
      @min_heap.insert(3).to_a.must_equal [3,5,4,8,11,9,6]
    end
  end
end
