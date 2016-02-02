require 'help'

describe List do
  before do
    @list = List.new(1, 2, 3, 4)
    @list2 = List.new(4, 5, 7)
    @empty_list = List.new
    @numbers = List.new(*(1..10).to_a)
    @even_numbers = List.new(2, 4, 6, 8, 10)
  end

  describe 'Empty list' do
    it '#empty? should be true' do
      assert @empty_list.empty?
    end

    it '#append should add element to list' do
      @empty_list.append(8)
      @empty_list.to_a.must_equal [8]
    end

    it '#unshift should add element to list' do
      @empty_list.unshift(8)
      @empty_list.to_a.must_equal [8]
    end

    it '#shift raises exception' do
      proc { @empty_list.shift }.must_raise ListError
    end
  end

  it '#from_array should transform array to list.' do
    @list.must_be_kind_of List
    @list.length.must_equal 4
  end

  it '#length should return list size.' do
    @list.length.must_equal 4
    @list2.length.must_equal 3
  end

  it '#get should return list element if element is on the list' do
    x = @list.head.next
    found = @list.get(x)
    found.must_be_kind_of ListElement
  end

  it '#get! should raise error if element is not found on the list' do
    x = @list2.head.next
    proc { @list.get!(x) }.must_raise ListError
  end

  it 'at should return element on given index' do
    @list.at(2).data.must_equal 3
    @list2.at(2).data.must_equal 7
    @list.at(42).must_equal nil
  end

  it '#[] should return element on given index' do
    @list[2].data.must_equal 3
    @list2[2].data.must_equal 7
  end

  it '#[] should return change element on given index' do
    @list[2] = 11
    @list[2].data.must_equal 11
  end

  it '#append should add element to the end of the list.' do
    x = 5
    @list.append(x)
    @list.length.must_equal 5
    @list.last.must_be_same_as x
  end

  it '#unshift should add element at the beginning of the list.' do
    x = 0
    @list.unshift(x)
    @list.length.must_equal 5
    @list.first.must_be_same_as x
  end

  it '#remove should remove element from list.' do
    second = @list.head.next
    third = second.next
    forth = third.next
    @list.remove(second)
    @list.to_a.must_equal [1, 3, 4]
    @list.remove(@list.head)
    @list.to_a.must_equal [3, 4]
    @list.remove(forth)
    @list.to_a.must_equal [3]
    @list.remove(third)
    @list.to_a.must_equal []
  end

  it '#pop should remove last list element.' do
    last = @list.pop
    last.must_equal 4
    @list.last.must_equal 3
    @list.to_a.must_equal [1, 2, 3]
  end

  it '#insert_before should insert new element before another.' do
    second = @list.head.next
    @list.insert_before(9, second)
    @list.to_a.must_equal [1, 9, 2, 3, 4]

    @list.insert_before(8, @list.head)
    @list.to_a.must_equal [8, 1, 9, 2, 3, 4]

    @list.insert_before(7, @list.tail)
    @list.to_a.must_equal [8, 1, 9, 2, 3, 7, 4]
  end

  it '#insert_after should insert new element after another.' do
    second = @list.head.next
    @list.insert_after(9, second)
    @list.to_a.must_equal [1, 2, 9, 3, 4]

    tail = @list.tail
    @list.insert_after(11, tail)
    @list.to_a.must_equal [1, 2, 9, 3, 4, 11]
  end

  it '#head should point to first element of the list.' do
    @list.head.must_be_kind_of ListElement
    @list2.head.must_be_kind_of ListElement
    @list.head.data.must_equal 1
    @list2.head.data.must_equal 4
  end

  it '#tail sould point to last element of the list' do
    @list.tail.must_be_kind_of ListElement
    @list2.tail.must_be_kind_of ListElement
    @list.tail.next.must_be_nil
    @list2.tail.next.must_be_nil

    @list.tail.data.must_equal 4
    @list2.tail.data.must_equal 7
  end

  it '#first should return value of the first list element.' do
    @list.first.must_equal 1
    @list2.first.must_equal 4
  end

  it '#last should return value of the last list element.' do
    @list.last.must_equal 4
    @list2.last.must_equal 7
  end

  it '#zip? should check if two list are joined.' do
    refute @list.zip?(@list2)
  end

  it '#reverse! should reverse list' do
    @list.reverse!.to_a.must_equal [4, 3, 2, 1]
    @list.reverse!.to_a.must_equal [1, 2, 3, 4]
    @list.reverse!.length.must_equal 4
  end

  it '#looped? should check if list has cycle.' do
    refute @list2.looped?
    refute @list.looped?
  end

  it '#reverse_each should iterate list in reverse order.' do
    arr = []
    @list.reverse_each { |e| arr.push e.data }
    arr.must_equal [4, 3, 2, 1]
  end

  it '#each_with_index should iterate list.' do
    h = {}
    @list.each_with_index { |e, i| h[i] = e.data }
    h.must_equal(0 => 1, 1 => 2, 2 => 3, 3 => 4)
  end

  it '#to_s should print list in human friendly format.' do
    @list.to_s.must_equal '1=2=3=4'
  end

  it 'should include Enumerable methods.' do
    @list.map(&:data).must_equal [1, 2, 3, 4]
    @list.inject(0) { |a, e| a + e.data }.must_equal 10
    @list.find { |e| e.data == 1.0 }.data.must_equal 1
  end

  describe 'Zipped list' do
    before do
      last = @list.tail
      @zipped = List.new(1, 2)
      @zipped.tail = last
    end

    it '#zip? should return true' do
      assert @list.zip?(@zipped)
    end
  end
end
