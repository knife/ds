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
    end

  end
end
