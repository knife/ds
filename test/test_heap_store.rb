require 'help'

describe HeapStore do
  before do
    @store = HeapStore.new(1, 2, 3, 4, 5, 6, 7)
  end

  it '#size returns store size.' do
    @store.size.must_equal 7
  end

  it 'indexing starts form one.' do
    @store[1].must_equal 1
  end

  it '#first returns element on index 1.' do
    @store.first.must_equal 1
  end

  it '#pop removes last element.' do
    @store.pop.must_equal 7
    @store.size.must_equal 6
  end

  it '#push adds element to store.' do
    @store.push 11
    @store.size.must_equal 8
  end

  it '#to_a returns array representation.' do
    @store.to_a.must_equal [1, 2, 3, 4, 5, 6, 7]
    @store.to_a.must_be_kind_of Array
  end
end
