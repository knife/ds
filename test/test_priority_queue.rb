require 'help'

describe PriorityQueue do

  describe "Empty Priority Queue" do

    before do
      @empty_queue = PriorityQueue.new
    end

    it "should be empty." do
      assert @empty_queue.empty?
    end

    it "should have zero elements." do
      @empty_queue.length.must_equal 0
    end
  end

  describe "Not empty priority queue" do

    before do
      @queue = PriorityQueue.new
      @queue.enqueue :important, 2
      @queue.enqueue :not_important, 1
    end

    it "should not be empty." do
      refute @queue.empty?
      @queue.length.must_equal 2

    end

    it "#peek should return element with highest priority." do
      @queue.peek.must_equal :important
    end

    it "#enqueue and #push should add element to priority queue." do
      @queue.enqueue :very_important, 5
      @queue.push :nevermind, 0
      @queue.length.must_equal 4
    end

    it "#dequeue and #shift should remove element with highest priority." do
      x = @queue.dequeue
      @queue.length.must_equal 1
      x.must_equal :important
      @queue.dequeue.must_equal :not_important
      @queue.length.must_equal 0
      @queue.dequeue.must_be_nil
    end
  end

  describe "Priority Queue with duplications" do

    before do
      @dup_queue = PriorityQueue.new
      @dup_queue.enqueue :same_important, 2
      @dup_queue.enqueue :important, 2
      @dup_queue.enqueue :not_important, 1
    end

    it "should not be empty" do
      refute @dup_queue.empty?
      @dup_queue.length.must_equal 3
    end

    it "#peek should return element with highest priority." do
      assert [:important,:same_important].include? @dup_queue.peek
      @dup_queue.dequeue
      assert [:important,:same_important].include? @dup_queue.peek
      @dup_queue.dequeue
      @dup_queue.peek.must_equal :not_important
    end

    it "#enqueue and #push should add element to priority queue." do
      @dup_queue.push :nevermind, 0
      @dup_queue.push :another_important, 2
      @dup_queue.length.must_equal 5
    end

    it "#dequeue and #shift should remove element with highest priority." do
      x  = @dup_queue.dequeue
      assert [:important,:same_important].include? x
      @dup_queue.length.must_equal 2

      @dup_queue.enqueue :important, 2
      @dup_queue.length.must_equal 3
      @dup_queue.dequeue.must_equal :important
      @dup_queue.dequeue.must_equal :important
    end
  end

  if ENV['BENCH']
    describe "performance" do

      before do
        
        @queue = PriorityQueue.new
        10000.times do |n|
          @queue.push :elem, rand(10)
        end

        @empty_queue = PriorityQueue.new
      end

      bench_performance_constant "#accessing max element should be const operation.", 0.999 do |n|
        n.times do
          @queue.peek
        end
      end

      bench_performance_constant "#removing max element should be log operation.", 0.999 do |n|
        n.times do
          @queue.dequeue
        end
      end

      bench_performance_constant "creating new priority queue should be linear operation.", 0.999 do |n|
        n.times do
          @empty_queue.push :elem, rand(10)
        end
      end

    end
  end
end
