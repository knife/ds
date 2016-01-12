require 'help'

describe Array2D do
  describe 'initialized with 0' do
    before do
      @zero_matrix = Array2D.new(2, 0)
    end

    it 'should return zero for any index.' do
      @zero_matrix[1, 1].must_equal 0
      @zero_matrix[0, 0].must_equal 0
    end

    it '#flatten should return matrix flattened to array.' do
      @zero_matrix.flatten.must_be_instance_of Array
      @zero_matrix.flatten.must_equal [0, 0, 0, 0]
    end

    it '#to_a should return internal representation (nested arrays)' do
      @zero_matrix.to_a.must_be_instance_of Array
      @zero_matrix.to_a.must_equal [[0, 0], [0, 0]]
    end

    it '#should extend magically.' do
      @zero_matrix[3, 3].must_equal 0
      @zero_matrix[4, 8].wont_be_nil
    end
  end

  describe 'initialized with false' do
    before do
      @discrete_matrix = Array2D.new(3, false)
    end

    it 'should return false for any index.' do
      refute @discrete_matrix[1, 1]
      refute @discrete_matrix[0, 0]
    end

    it '#flatten should return matrix flattened to array.' do
      @discrete_matrix.flatten.must_be_instance_of Array
      @discrete_matrix.flatten.must_equal [false, false, false, false, false, false, false, false, false]
    end

    it '#to_a should return internal representation (nested arrays)' do
      @discrete_matrix.to_a.must_be_instance_of Array
      @discrete_matrix.to_a.must_equal [
        [false, false, false],
        [false, false, false],
        [false, false, false]
      ]
    end

    it '#should extend magically.' do
      refute @discrete_matrix[3, 3]
      @discrete_matrix[4, 8].wont_be_nil
    end
  end
end
