if ENV['BENCH']
  describe 'Lists Bench' do
    before do
      @arr = (1..10_000).to_a.sort_by { rand }
      @list = List.from_array([1, 2, 3, 4])
      @second = @list.head.next

      10_000.times do
        @list.append 4
      end
    end

    bench_performance_constant '#append should be const operation.', 0.999 do |n|
      n.times do
        @list.append 3
      end
    end

    bench_performance_constant '#insert after should be const operation.', 0.999 do |n|
      n.times do
        @list.insert_after(9, @second)
      end
    end

    bench_performance_constant '#unshift should be const operation.', 0.999 do |n|
      n.times do
        @list.unshift 3
      end
    end

    bench_performance_linear '#reverse! should be linear operation.', 0.999 do |n|
      list = List.from_array(@arr[0..n])
      list.reverse!
    end
  end
end
