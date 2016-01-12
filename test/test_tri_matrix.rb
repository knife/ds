require 'help'

describe TriMatrix do
  before do
    @tri_matrix = TriMatrix.new
    @tri_matrix[0,1] = true
    @tri_matrix[0,2] = true
  end

  it "[x,y] should be same as [y,x]" do
    @tri_matrix[0,1].must_be_same_as @tri_matrix[1,0]
  end

  it "should store elements in array" do
    @tri_matrix.to_a.must_equal [0,true,0,true]
  end
end


