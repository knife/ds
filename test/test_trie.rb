require 'help'

describe Trie do

  before do
    @trie = Trie.new
  end

  it "#insert should add new string to trie." do
    @trie.insert("thing",true);
    assert @trie.find("thing");
  end

end
