require File.expand_path('../spec_helper', __FILE__)

module Bohne
  describe Bohne do
    it 'can convert an iOS NIB to tvOS' do
      tmpfile = File.join(Dir.tmpdir, 'output.xib')

      Bohne.convert('spec/fixtures/iOS-View.xib', tmpfile)
      `xmllint -format #{tmpfile} -output #{tmpfile}`

      FileUtils.compare_file('spec/fixtures/tvOS-View.xib', tmpfile).should == true
    end
  end
end
