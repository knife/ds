require 'help'

describe Stack do
  before do
    @stack = Stack.new
    @stack.push :first
    @stack.push :second
  end

  describe 'Empty stack' do
    before do
      @empty_stack = Stack.new
    end

    it 'should be empty.' do
      assert @empty_stack.empty?
      @empty_stack.size.must_equal 0
    end

    it '#pop should retrun nil.' do
      @empty_stack.pop.must_be_nil
    end

    it '#peek should return nil.' do
      @empty_stack.peek.must_be_nil
    end

    it '#push should change stack size.' do
      @empty_stack.push :first
      refute @empty_stack.empty?
      @empty_stack.size.must_equal 1
    end
  end

  describe 'Not empty stack implemented as List' do
    before do
      @stack = Stack.create
      @stack.push :first
      @stack.push :second
    end

    it 'should not be empty.' do
      refute @stack.empty?
    end

    it '#peek should return element from the top of the stack.' do
      @stack.peek.must_equal :second
    end

    it '#pop should remove element form the top of the stack.' do
      last = @stack.pop
      last.must_equal :second
      @stack.size.must_equal 1
      @stack.peek.must_equal :first
    end

    it '#push should insert element to the top of the stack.' do
      @stack.push(:third)
      @stack.peek.must_equal :third
      @stack.size.must_equal 3
    end
  end

  describe 'Not empty stack implemented as Array' do
    it 'should not be empty.' do
      refute @stack.empty?
    end

    it '#peek should return element from the top of the stack.' do
      @stack.peek.must_equal :second
    end

    it '#pop should remove element form the top of the stack.' do
      @stack.pop
      @stack.size.must_equal 1
      @stack.peek.must_equal :first
    end

    it '#push should insert element to the top of the stack.' do
      @stack.push(:third)
      @stack.peek.must_equal :third
      @stack.size.must_equal 3
    end
  end
end

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
