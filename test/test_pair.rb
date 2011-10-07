require 'help'

describe Pair do

  before do
    @pair = Pair.new(1,2)
  end

  it "first should return first element of a pair" do
    @pair.first.must_equal 1
  end

  it "key should return first element of a pair" do
    @pair.key.must_equal 1
  end

  it "second should return second element of a pair" do
    @pair.second.must_equal 2
  end

  it "value should return second element of a pair" do
    @pair.value.must_equal 2
  end
  
end

