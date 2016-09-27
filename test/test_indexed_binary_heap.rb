require 'help'

describe IndexedBinaryHeap do
  before do
    @nine = Pair.new(9, :nine)
    @eight = Pair.new(8, :eight)
    @four = Pair.new(4, :four)
    @five = Pair.new(5, :five)
    @eleven = Pair.new(11, :eleven)
    @six = Pair.new(6, :six)

    @arr = [@nine, @eight, @four, @five, @eleven, @six]
    @heap = IndexedBinaryHeap.new(*@arr)
  end

  it 'creates heap from array.' do
    @heap.to_a.must_equal [@eleven, @nine, @six, @five, @eight, @four]
  end

  it '#change_priority changes priority for given heap element.' do
    @heap.change_priority(:five, 20)
    @heap.top.value.must_equal :five
  end

  it '#insert adds new element maintaining heap relation.' do
    @heap.size.must_equal 6
    fourteen = Pair.new(14, :fourteen)
    @heap.insert(fourteen).to_a.must_equal [fourteen, @nine, @eleven, @five, @eight, @four, @six]
    @heap.size.must_equal 7
  end

  it '#top returns max or min heap element.' do
    @heap.top.must_equal @eleven
    @heap.shift
    @heap.top.must_equal @nine
  end

  it '#shift removes element from heap maintaining heap relation.' do
    @heap.shift.must_equal @eleven
    @heap.to_a.must_equal [@nine, @eight, @six, @five, @four]
    @heap.shift.must_equal @nine
    @heap.to_a.must_equal [@eight, @five, @six, @four]
    @heap.shift.must_equal @eight
  end
end
