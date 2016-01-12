require 'help'

describe Queue do
  describe "Empty Queue" do
    before do
      @empty_queue = Queue.new
    end

    it "should be empty." do
      assert @empty_queue.empty?
    end

    it "should have zero elements." do
      @empty_queue.length.must_equal 0
    end
  end

  describe "Not empty queue" do
    before do
      @queue = DS::Queue.new
      @queue.enqueue 1
      @queue.enqueue 2

      @queue2 = DS::Queue.create
      @queue2.enqueue 1
      @queue2.enqueue 2
    end

    it "should not be empty." do
      refute @queue.empty?
      @queue.length.must_equal 2

      refute @queue2.empty?
      @queue2.length.must_equal 2
    end

    it "#peek should return element from forehead of queue." do
      @queue.peek.must_equal 1
      @queue2.peek.must_equal 1
    end

    it "#enqueue and #push should add element to queue." do
      @queue.enqueue 3
      @queue.length.must_equal 3

      @queue.push 3
      @queue.length.must_equal 4

      @queue2.enqueue 3
      @queue2.length.must_equal 3

      @queue2.push 3
      @queue2.length.must_equal 4
    end

    it "#dequeue and #shift should remove element from queue." do
      x = @queue.dequeue
      @queue.length.must_equal 1
      x.must_equal 1

      x = @queue2.dequeue
      @queue2.length.must_equal 1
      x.must_equal 1
    end

    if ENV['BENCH']
      describe "performance" do
        before do
          100_000.times do |n|
            @queue.push 4
            @queue2.push 4
          end
        end

        bench_performance_constant "#shift(array implementation) should be const operation.", 0.999 do |n|
          n.times do
            @queue.shift
          end
        end

        bench_performance_constant "#shift(list implementation) should be const operation.", 0.999 do |n|
          n.times do
            @queue2.shift
          end
        end

        bench_performance_constant "#push(array implementation) should be const operation.", 0.999 do |n|
          n.times do
            @queue.push 2
          end
        end

        bench_performance_constant "#push(list implementation) should be const operation.", 0.999 do |n|
          n.times do
            @queue2.push 2
          end
        end
      end
    end
  end
end
