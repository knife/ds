require 'help'

if ENV['BENCH']
  describe 'performance Bench' do
    before do
      @queue = PriorityQueue.new
      10_000.times do
        @queue.push :elem, rand(10)
      end

      @empty_queue = PriorityQueue.new
    end

    bench_performance_constant '#accessing max element should be const operation.', 0.999 do |n|
      n.times do
        @queue.peek
      end
    end

    # bench_performance_logarithmic '#removing max element should be log operation.', 0.999 do |n|
    #   n.times do
    #     @queue.dequeue
    #   end
    # end

    bench_performance_linear 'creating new priority queue should be linear operation.', 0.999 do |n|
      n.times do
        @empty_queue.push :elem, rand(10)
      end
    end
  end
end
