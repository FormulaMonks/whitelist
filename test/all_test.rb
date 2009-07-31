require 'rubygems'
require 'contest'
require File.dirname(__FILE__) + "/../lib/whitelist"

def params
  { :a => 1, :b => 2, :c => { :d => 3 } }
end

include Whitelist

class TestWhitelist < Test::Unit::TestCase
  setup do
    @hash = { :a => 1, :b => 2, :c => { :d => 3 }, :foo => { :bar => { :baz => 'bang', :bing => 'boom', :bob => 'boo' }, :bad => 'beep' } }
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
  
  context "when nested" do
    should "keep bar in first level" do
      assert whitelist(@hash[:foo], :bar => :baz)[:bar]
    end
    
    should "strip bad in first level" do
      assert !whitelist(@hash[:foo], :bar => :baz)[:bad]
    end
    
    should "keep baz under bar" do
      assert_equal 'bang', whitelist(@hash[:foo], :bar => :baz)[:bar][:baz]
    end

    should "strip bing from under bar" do
      assert !whitelist(@hash[:foo], :bar => :baz)[:bar][:bing]
    end

    context "with multiple nested keys" do
      should "keep baz under bar" do
        assert_equal 'bang', whitelist(@hash[:foo], :bar => [ :baz, :bob ])[:bar][:baz]
      end

      should "keep bob under bar" do
        assert_equal 'boo', whitelist(@hash[:foo], :bar => [ :baz, :bob ])[:bar][:bob]
      end
      
      should "strip bing from under bar" do
        assert !whitelist(@hash[:foo], :bar => :baz)[:bar][:bing]
      end
    end
    
    context "when deeply nested" do
      should "keep baz under bar under foo" do
        assert_equal 'bang', whitelist(@hash, :foo => { :bar => :baz })[:foo][:bar][:baz]
      end
      
      should "strip bad under foo" do
        assert !whitelist(@hash, :foo => { :bar => :baz })[:foo][:bad]
      end
    end
  end
end
