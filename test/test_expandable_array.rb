require 'help'

describe ExpandableArray do
 
  describe "Zero Array" do
    
    before do
      @zero_arr = ExpandableArray.new(0,0)
      @zero_arr[0] = 1
    end

    it "access to element x should set all elements from array size to x to zero." do
      @zero_arr.size.must_equal 1
      @zero_arr[3].must_equal 0
      @zero_arr.size.must_equal 4
      @zero_arr.must_equal [1,0,0,0]
    end

    it "setting value on index x should set all elements from array size to x to zero." do
      @zero_arr[5] = 2
      @zero_arr.must_equal [1,0,0,0,0,2]
    end
  end
end


