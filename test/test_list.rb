require 'help'

describe List do

  before do
    @list = List.from_array([1,2,3,4])
    @list2 = List.from_array([4,5,7])
  end

  it "#from_array should transform array to list." do
    @list.must_be_kind_of List  
    @list.length.must_equal 4
  end

  it "#length should return list size." do
    @list.length.must_equal 4
    @list2.length.must_equal 3
  end


  it "#append should add element to the end of the list." do
    x = 5
    @list.append(x)
    @list.length.must_equal 5
    @list.last.must_be_same_as x 
  end

  it "#prepend should add element at the beginning of the list." do
    x = 0
    @list.prepend(x)
    @list.length.must_equal 5
    @list.first.must_be_same_as x
  end

  it "#remove should remove element from list." do
    second = @list.head.next
    @list.remove(second)
    @list.to_a.must_equal [1,3,4]
  end

  it "#insert_before should insert new element before another." do
    second = @list.head.next
    @list.insert_before(9,second)
    @list.to_a.must_equal [1,9,2,3,4]

    @list.insert_before(8,@list.head)
    @list.to_a.must_equal [8,1,9,2,3,4]

    @list.insert_before(7,@list.tail)
    @list.to_a.must_equal [8,1,9,2,3,7,4]

  end

  it "#insert_after should insert new element after another." do
    second = @list.head.next
    @list.insert_after(9,second)
    @list.to_a.must_equal [1,2,9,3,4]
  end


  it "#head should point to first element of the list." do
    @list.head.must_be_kind_of ListElement 
    @list2.head.must_be_kind_of ListElement
    @list.head.data.must_equal 1
    @list2.head.data.must_equal 4
  end

  it "#tail sould point to last element of the list" do
    @list.tail.must_be_kind_of ListElement 
    @list2.tail.must_be_kind_of ListElement
    @list.tail.next.must_be_nil    
    @list2.tail.next.must_be_nil

    @list.tail.data.must_equal 4
    @list2.tail.data.must_equal 7
  end

  it "#first should return value of the first list element." do
    @list.first.must_equal 1
    @list2.first.must_equal 4
  end


  it "#last should return value of the last list element." do
    @list.last.must_equal 4
    @list2.last.must_equal 7
  end

  it "#zip? should check if two list are joined." do
    refute @list.zip?(@list2)
  end

  it "#reverse! should reverse list" do
    @list.reverse!.to_a.must_equal [4,3,2,1]
    @list.reverse!.to_a.must_equal [1,2,3,4]
    @list.reverse!.length.must_equal 4
  end

  it "#merge should merge two list into one." do
    @list2.merge(@list).to_a.must_equal [1,2,3,4,4,5,7]
  end

  it "#orderize should order elements by evaluating block." do
    not_sorted_list = List.from_array([3,-1,0,-8,2,0,1])
    not_sorted_list.orderize{|elem| elem <=> 0}.to_a.must_equal [-1,-8,0,0,3,2,1]
  end

  it "#remove! should remove all elements that occur on the other list." do
    @list.remove!(@list2).to_a.must_equal [1,2,3]
  end

  it "#looped? should check if list has cycle." do
    refute @list2.looped?
    refute @list.looped?
  end

  it "should include Enumerable methods." do
    @list.map{ |e| e }.must_equal [1,2,3,4]
    @list.inject(0){ |mem, var| mem = mem + var }.must_equal 10
  end


  describe "Zipped list" do

    before do
      last = @list.tail
      @zipped = List.from_array([1,2])
      @zipped.tail = last
    end

    it "#zip? should return true" do
      assert @list.zip?(@zipped)
    end

  end

  end

