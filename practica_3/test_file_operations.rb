require_relative 'file_operations'
require 'minitest/autorun'
require 'minitest/spec'
require 'mocha/mini_test'

describe 'test leer method' do

  describe 'files exists' do
    let(:filename) {'file'}
    before do
      returns = ["a","b"]
      File.expects(:open).with(filename,'r').once.returns returns
      returns.expects(:close).once
    end

    it 'must open file and close it' do
      leer(filename)
    end

    it 'must returns expected string' do
      leer(filename).must_equal "ab"
    end
  end

  describe 'file not exists' do
    let(:filename) {'file'}
    before do
      file = ""
      File.expects(:open).with(filename, 'r').raises(SystemCallError, 'File not found')
      IO.any_instance.expects(:puts).with('Failed to open file: unknown error - File not found').once
      File.expects(:new).with(filename, 'w').once.returns file
      file.expects(:close).once
    end

    it 'must rescue exception' do
      leer(filename)
    end

    it 'must returns expected string' do
      leer(filename).must_equal ""
    end
  end
end
