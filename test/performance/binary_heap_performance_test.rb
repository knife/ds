require 'help'

if ENV['BENCH']
  describe 'performance Bench' do
    before do
      @arr = (1..10_000).to_a.shuffle
      @heap = BinaryHeap.new(*@arr)
    end

    bench_performance_constant 'creating new heap should be linear operation.', 0.999 do |_n|
      BinaryHeap.new(*@arr)
    end

    bench_performance_constant 'accessing max element should be const operation.', 0.999 do |n|
      n.times do
        @heap.shift
      end
    end
  end
end
