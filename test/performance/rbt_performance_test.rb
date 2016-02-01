require 'help'

if ENV['BENCH']
  describe 'performance Bench' do
    before do
      @tree = RedBlackTree.new
    end

    bench_performance_constant 'insert is log(n) operation', 0.999 do |n|
      key = 'a'
      n.times do
        key = key.succ
        @tree.insert key, rand(10)
      end
    end
  end
end
