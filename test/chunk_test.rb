require 'test/test_helper'

class ChunkTest < Test::Unit::TestCase

  def setup
    @dir = Dir.mktmpdir
  end

  def teardown
    `rm -rf #{@dir}`
  end

  def test_small
    store = FakeS3::FileStore.new(@dir)
    file_data = File.binread('./test/testdata_small')
    processed = store.clean_chunk(file_data)
    assert_equal('foobarbaz',processed)
  end
  
  def test_full
    store = FakeS3::FileStore.new(@dir)
    chunked_data = File.binread('./test/Xamarin.UITest.dll.chunked')
    processed = store.clean_chunk(chunked_data)
    expected = File.binread('./test/Xamarin.UITest.dll')
    STDERR.puts "test_full_completed"
    assert_equal(expected, processed)
  end


end
