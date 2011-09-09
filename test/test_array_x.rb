require 'help'

describe ArrayX do

  before do
    @asc = [1,3,6,9,10,13].extend(ArrayX)
    @desc = [9,8,7,7,4,3,2].extend(ArrayX)
    @empty = [].extend(ArrayX)
    @one = [3].extend(ArrayX)
    @not_sorted = [3,4,9,1,1,2,8].extend(ArrayX)
  end

  it "#sorted? should check if array is already sorted." do
    assert @desc.sorted?
    assert @asc.sorted?
    assert @empty.sorted?
    assert @one.sorted?
    refute @not_sorted.sorted?
  end

  it "#push_uniq should push element only if it is not already in array."  do
    @asc.size.must_equal 6 
    @asc.push_uniq(3).must_equal 1
    @asc.size.must_equal 6

    @empty.push_uniq(3).must_equal 0
    @empty.must_equal [3]
  end
end


