require 'help'

describe 'OrderedSet' do
  before do
    @set = OrderedSet.new
    @set.push(:first).must_equal 0
  end

  it '#push should add new element to set and return its index.' do
    @set.push(:second).must_equal 1
    @set.push(:first).must_equal 0
  end

  it '#index should return element index.' do
    @set.index(:first).must_equal 0
    @set.push(:second)
    @set.index(:second).must_equal 1
    @set.index(:non_exist).must_be_nil
  end

  it '#to_a should return array.' do
    @set.push(:second)
    @set.to_a.must_equal [:first, :second]
  end
end
