require 'help'

describe IndexedPriorityQueue do
  describe 'Empty indexed priority queue' do
    before do
      @empty_queue = IndexedPriorityQueue.new
    end

    it 'is empty.' do
      @empty_queue.must_be_empty
    end

    it 'has zero elements.' do
      @empty_queue.length.must_equal 0
    end
  end

  describe 'Not empty indexed priority queue' do
    before do
      @queue = IndexedPriorityQueue.new
      @queue.enqueue :important, 2
      @queue.enqueue :not_important, 1
    end

    it 'is not empty.' do
      @queue.wont_be_empty
      @queue.length.must_equal 2
    end

    it '#update changes element priority' do
      @queue.update(:important, 0)
      @queue.peek.must_equal :not_important
    end

    it '#get returns element from queue' do
      x = @queue.get(:important)
      x.must_be_kind_of Pair
      x.value.must_equal :important
      @queue.peek.must_equal :important
    end

    it '#include? returns true if element is stored on queue.' do
      @queue.include?(:important).must_equal true
      @queue.include?(:bar).must_equal false
    end

    it '#peek returns element with highest priority.' do
      @queue.peek.must_equal :important
    end

    it '#enqueue and #push should add element to priority queue.' do
      @queue.enqueue :very_important, 5
      @queue.push :nevermind, 0
      @queue.length.must_equal 4
    end

    it '#dequeue and #shift should remove element with highest priority.' do
      x = @queue.dequeue
      @queue.length.must_equal 1
      x.must_equal :important
      @queue.dequeue.must_equal :not_important
      @queue.length.must_equal 0
      @queue.dequeue.must_be_nil
    end
  end

  describe 'Not empty indexed priority queue with custom order' do
    before do
      @queue = IndexedPriorityQueue.new { |a, b| a < b }
      @queue.enqueue 'gamma', 'g'
      @queue.enqueue 'alpha', 'a'
      @queue.enqueue 'beta', 'b'
    end

    it 'should not be empty.' do
      refute @queue.empty?
      @queue.length.must_equal 3
    end

    it '#peek should return element with highest priority.' do
      @queue.peek.must_equal 'alpha'
    end

    it '#change should change element priority.' do
      @queue.update('alpha', 'l')
      @queue.peek.must_equal('beta')
    end

    it '#dequeue and #shift should remove element with highest priority.' do
      x = @queue.dequeue
      @queue.length.must_equal 2
      x.must_equal 'alpha'
      @queue.dequeue.must_equal 'beta'
      @queue.length.must_equal 1
    end
  end

  describe 'IndexedPriorityQueue with duplications' do
    before do
      @dup_queue = IndexedPriorityQueue.new(Pair.new(2, :same_important))
      @dup_queue.enqueue :important, 2
      @dup_queue.enqueue :not_important, 1
    end

    it 'is not empty.' do
      @dup_queue.wont_be_empty
      @dup_queue.length.must_equal 3
    end

    it '#peek returns element with highest priority.' do
      [:important, :same_important].must_include @dup_queue.peek
      @dup_queue.dequeue
      [:important, :same_important].must_include @dup_queue.peek
      @dup_queue.dequeue
      @dup_queue.peek.must_equal :not_important
    end

    it '#enqueue and #push adds element to priority queue.' do
      @dup_queue.push :nevermind, 0
      @dup_queue.push :another_important, 2
      @dup_queue.length.must_equal 5
    end

    it '#enqueue does\'t add elements that are already in queue.' do
      @dup_queue.dequeue
      @dup_queue.length.must_equal 2
      @dup_queue.enqueue :important, 2
      @dup_queue.length.must_equal 2
      @dup_queue.dequeue.must_equal :important
      @dup_queue.dequeue.must_equal :not_important
    end

    it '#dequeue and #shift removes element with highest priority.' do
      x = @dup_queue.dequeue
      [:important, :same_important].must_include x
      @dup_queue.length.must_equal 2
    end
  end
end
