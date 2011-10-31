require 'help'

describe ArrayX do

  before do
    @asc = [1,3,6,9,10,13].extend(ArrayX)
    @desc = [9,8,7,7,4,3,2].extend(ArrayX)
    @short = [1,2].extend(ArrayX)

    @empty = [].extend(ArrayX)
    @one = [3].extend(ArrayX)
    @not_sorted = [3,4,9,1,1,2,8].extend(ArrayX)
  end

  it "#sorted? should check if array is already sorted." do
    assert @desc.sorted?
    assert @asc.sorted?
    assert @empty.sorted?
    assert @one.sorted?
    assert @short.sorted? 
    refute @not_sorted.sorted?
    assert @desc.sorted?(:desc)
    refute @desc.sorted?(:asc)
    assert @asc.sorted?(:asc)
    refute @asc.sorted?(:desc)
    refute @not_sorted.sorted?(:des)
    refute @not_sorted.sorted?(:asc)
    assert @short.sorted?(:asc)
    refute @short.sorted?(:desc)
    
    assert @one.sorted?(:asc)
    assert @one.sorted?(:asc)

  end
  
  it "#duplications? should check if array has duplicates." do
    refute @asc.duplications?
    assert @desc.duplications?
    assert @not_sorted.duplications?
    refute @empty.duplications?
  end

  it "#tail should return array without first element." do
    @asc.tail.must_equal [3,6,9,10,13]
    @short.tail.must_equal [2]
    @one.tail.must_equal []
    @empty.tail.must_be_nil
  end
end


