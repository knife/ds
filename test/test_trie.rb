require 'help'

describe Trie do
  before do
    @trie = Trie.new
    @dict = Trie.new
    @dict.insert('hello')
  end

  it '#insert should add new string to trie.' do
    @trie.insert('thing')
    assert @trie.find('thing')

    @trie.insert('think')
    assert @trie.find('thing')

    @trie.insert('math')
    assert @trie.find('math')
  end

  it '#find should not find not added word.' do
    @dict.find('blah').must_be_nil
  end

  it '#delete removes word from tree' do
    @dict.insert('he')
    @dict.insert('help')
    @dict.delete('hello')
    refute @dict.find('hello')
    refute @dict.find('hell')
    refute @dict.find('hel')
    assert @dict.find('he')
    assert @dict.find('help')
  end

  it '#alphabet= sets Trie alphabet' do
    @trie = Trie.new
    @trie.alphabet = %w(a b c d)
    proc { @trie.insert('thing') }.must_raise ArgumentError
  end

  it 'should raise error if character is not in trie alphabet.' do
    proc { @dict.find('m%$r') }.must_raise ArgumentError
    proc { @dict.insert('m%$r') }.must_raise ArgumentError
  end
end
