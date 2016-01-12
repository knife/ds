require 'help'

describe 'Cyclic List' do
  before do
    @ring = Ring.from_array([1, 2, 3, 4, 5, 6, 7])
  end

  it '#from_array should create ring from array.' do
    @ring.must_be_kind_of List
    @ring.must_be_instance_of Ring
    @ring.length.must_equal 7
  end

  it 'should be looped.' do
    assert @ring.looped?
  end

  it 'should has cycle.' do
    @ring.cycle_size.must_equal 7
  end
end
