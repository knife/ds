require 'help'

describe SimpleQueue do
  describe 'empty queue' do
    before do
      @empty_queue = SimpleQueue.new
    end

    it 'should be empty.' do
      assert @empty_queue.empty?
    end

    it 'should have zero elements.' do
      @empty_queue.length.must_equal 0
    end
  end

  describe 'not empty queue' do
    before do
      @queue = SimpleQueue.new(1, 2)
      @queue2 = SimpleQueue.create(1, 2)
    end

    it 'should not be empty.' do
      refute @queue.empty?
      @queue.length.must_equal 2

      refute @queue2.empty?
      @queue2.length.must_equal 2
    end

    it '#peek should return element from forehead of queue.' do
      @queue.peek.must_equal 1
      @queue2.peek.must_equal 1
    end

    it '#enqueue and #push should add element to queue.' do
      @queue.enqueue 3
      @queue.length.must_equal 3

      @queue.push 3
      @queue.length.must_equal 4

      @queue2.enqueue 3
      @queue2.length.must_equal 3

      @queue2.push 3
      @queue2.length.must_equal 4
    end

    it '#dequeue and #shift should remove element from queue.' do
      x = @queue.dequeue
      @queue.length.must_equal 1
      x.must_equal 1

      x = @queue2.dequeue
      @queue2.length.must_equal 1
      x.must_equal 1
    end
  end
end
