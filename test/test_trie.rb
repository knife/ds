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

  it 'has hash like accessors' do
    @trie['thing'] = 'one'
    assert_equal @trie['thing'], 'one'
  end

  it '#find should not find not added word.' do
    @dict.find('blah').must_be_nil
  end

  it '#delete removes word from tree' do
    @dict.insert('he')
    @dict.insert('help')
    assert @dict.find('hello')
    refute @dict.find('hellp')
    refute @dict.find('hel')
    assert @dict.find('he')
    assert @dict.find('help')
  end

  it '#each iterates through trie' do
    @dict.insert('he')
    @dict.insert('help')
    assert_equal @dict.map { |n| n }, %w(he hello help)
    assert_equal @dict.map { |k, v| [k, v] }, [['he', true], ['hello', true], ['help', true]]
  end

  it '#with_prefix returns words with matching prefix' do
    @dict.insert('help')
    @dict.insert('him')
    assert_equal @dict.with_prefix('he'), %w(hello help)

    arr = []
    @dict.with_prefix('he') { |n| arr << n }
    assert_equal arr, %w(hello help)

    assert_equal @dict.with_prefix('yeti'), []
  end

  it '#to_h converts tree to Hash' do
    @dict.to_h.must_equal 'hello' => true
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
