require 'help'

describe Trie do
  before do
    @trie = Trie.new
    @dict = Trie.new
    @dict.insert("hello")
  end

  it "#insert should add new string to trie." do
    @trie.insert("thing");
    assert @trie.find("thing")
    
    @trie.insert("think")
    assert @trie.find("thing")
    
    @trie.insert("math")
    assert @trie.find("math")
    
  end

  it "should not find not added word." do
    @dict.find("blah").must_be_nil
  end

  it "should raise error if character is not in trie alphabet." do
    proc {@dict.find("m%$r")}.must_raise ArgumentError
    proc {@dict.insert("m%$r")}.must_raise ArgumentError
  end
end
