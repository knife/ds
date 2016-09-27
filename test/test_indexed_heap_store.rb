require 'help'

describe IndexedHeapStore do
  before do
    @first  = Pair.new(1, 1)
    @second = Pair.new(2, 2)
    @third  = Pair.new(3, 3)
    @fourth = Pair.new(4, 4)
    @store = IndexedHeapStore.new(@first, @second, @third, @fourth)
  end

  it '#new raises error if arguments contains duplicates' do
    proc { IndexedHeapStore.new(Pair.new(1, 9), Pair.new(2, 9)) }
      .must_raise ArgumentError
  end

  it '#size returns store size.' do
    @store.size.must_equal 4
  end

  it 'indexing starts form one.' do
    @store[1].must_equal @first
  end

  it '#first returns element at index 1.' do
    @store.first.must_equal @first
  end

  describe '#pop' do
    it 'removes last element.' do
      @store.pop.must_equal @fourth
      @store.size.must_equal 3
    end

    it 'updates store index' do
      last = @store.pop
      @store.index(last).must_be_nil
      @store.get(last).must_be_nil
    end
  end

  describe '#push' do
    it 'adds element to store.' do
      fifth = Pair.new(5, 5)
      @store.push fifth
      @store.size.must_equal 5
    end

    it 'ignores duplicates.' do
      @store.push(@first).must_be_nil
      @store.size.must_equal 4

      @store.push(Pair.new(1, 1)).must_be_nil
      @store.size.must_equal 4
    end
  end

  it '#index returns heap index for given element' do
    @store.index(@first.value).must_equal 1
    @store.index(@third.value).must_equal 3
    @store.index(:not_in_store).must_be_nil
  end

  it '#get returns element from store' do
    @store.get(1).value.must_equal 1
    @store.get(9).must_be_nil
  end

  it '#to_a returns array representation.' do
    @store.to_a.must_equal [@first, @second, @third, @fourth]
    @store.to_a.must_be_kind_of Array
  end

  it '#swap swaps elements in store' do
    @store.swap(1, 4)
    @store.to_a.must_equal [@fourth, @second, @third, @first]
  end
end
