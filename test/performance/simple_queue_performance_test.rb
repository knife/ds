require 'help'
if ENV['BENCH']
  describe 'performance Bench' do
    before do
      @queue = SimpleQueue.new
      @queue2 = SimpleQueue.create
      100_000.times do
        @queue.push 4
        @queue2.push 4
      end
    end

    bench_performance_constant '#shift(array implementation) should be const operation.', 0.999 do |n|
      n.times do
        @queue.shift
      end
    end

    bench_performance_constant '#shift(list implementation) should be const operation.', 0.999 do |n|
      n.times do
        @queue2.shift
      end
    end

    bench_performance_constant '#push(array implementation) should be const operation.', 0.999 do |n|
      n.times do
        @queue.push 2
      end
    end

    bench_performance_constant '#push(list implementation) should be const operation.', 0.999 do |n|
      n.times do
        @queue2.push 2
      end
    end
  end
end
