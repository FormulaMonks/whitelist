require 'rubygems'
require 'contest'
require File.dirname(__FILE__) + "/../lib/whitelist"

def params
  { :a => 1, :b => 2, :c => { :d => 3 } }
end

include Whitelist

class TestWhitelist < Test::Unit::TestCase
  setup do
    @hash = { :a => 1, :b => 2, :c => { :d => 3 } }
  end

  context "without a whitelist " do
    should "return an empty hash" do
      assert_equal Hash.new, whitelist(@hash)
    end
  end

  context "with a nil value as the first parameter" do
    should "also return an empty hash" do
      assert_equal Hash.new, whitelist(nil)
    end
  end

  context "with a symbol as the first parameter" do
    should "pull the hash from the params method" do
      assert_equal @hash[:c], whitelist(:c, :d)
    end

    should "return an empty hash if the key is not found" do
      assert_equal Hash.new, whitelist(:c, :f)
    end
  end
end
