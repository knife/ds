require 'help'

describe 'List Element' do
  before do
    @empty_el = ListElement.new
    @el = ListElement.new(1)
  end

  describe 'not initialized' do
    before do
      @empty_el = ListElement.new
    end

    it 'should have no elements.' do
      @empty_el.data.must_be_nil
    end

    it 'should be tail.' do
      assert @empty_el.tail?
    end

    it '#append should return appended element.' do
      el = @empty_el.append(2)
      el.must_be_instance_of ListElement
      el.data.must_equal 2
      el.must_equal @empty_el.next
    end

    it '#append should link element with another.' do
      @next = @empty_el.append(2)
      @next.must_be_instance_of ListElement
      @empty_el.next.wont_be_nil
      @empty_el.next.must_be_instance_of ListElement
      @empty_el.next.data.must_equal 2
      @next.prev.wont_be_nil
      @next.prev.must_be_instance_of ListElement
    end
  end

  describe 'initialized' do
    before do
      @el = ListElement.new(1)
    end

    it 'should have one element' do
      @el.data.must_equal 1
    end

    it 'should be tail.' do
      assert @el.tail?
    end

    it '#append should link element with another.' do
      @next = @el.append(2)
      @next.must_be_instance_of ListElement
      @el.append(2).must_be_instance_of ListElement
      @el.next.wont_be_nil
      @el.next.must_be_instance_of ListElement
      @el.next.data.must_equal 2

      @next.prev.wont_be_nil
      @next.prev.must_be_instance_of ListElement
      @next.prev.data.must_equal 1
    end
  end
end
