require 'help'

if ENV['BENCH']
  describe 'implement as Array Bench' do
    before do
      @stack = Stack.new
      100_000.times do
        @stack.push 4
      end
    end

    bench_performance_constant 'array #pop should be const op', 0.999 do |n|
      n.times do
        @stack.pop
      end
    end

    bench_performance_constant 'array #push should be const op', 0.999 do |n|
      n.times do
        @stack.push 3
      end
    end
  end

  describe 'implement as List Bench' do
    before do
      @stack = Stack.create
      100_000.times do
        @stack.push 4
      end
    end

    bench_performance_constant 'list #pop should be const op', 0.999 do |n|
      n.times do
        @stack.pop
      end
    end

    bench_performance_constant 'list #push should be const op.', 0.999 do |n|
      n.times do
        @stack.push 3
      end
    end
  end
end
